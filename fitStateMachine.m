function [ProbDist, StateCounts, StateChangeStats] = fitStateMachine(expList,useEpochs,useLanes)

    xBins = -30:1:30;
    vThresh = .2;       % mm/sec
    
    nBins = size(xBins,2);
    StateCounts = zeros(3,nBins,3);
    StateChangeStats = [];

    for expN = expList

        loadData(expN);
        exp.comment;
        scaledExp = scaleTracks(exp);

        for epochN = useEpochs
            for laneN = useLanes
                % Get a smooth velocity track to work with
                xTrack =  scaledExp.epoch(epochN).scaledTrack(:,1,laneN);
                stateSequence = identifyStates(xTrack);
                nextState = stateSequence(2:end);
                thisState = stateSequence(1:(end-1));
                % Create a vector of # of samples since state changes
                stateChanges = [0;(abs(diff(stateSequence))==0)];
                prevState = [2;nextState];
                for t=2:size(stateChanges,1)
                    % If we're still in the same state
                    if (stateChanges(t) > 0)
                        stateChanges(t) = stateChanges(t-1)+1;
                        prevState(t) = prevState(t-1);
                    end
                    if ((stateChanges(t) == 0) || (t == size(stateChanges,1)))
                        prevState(t) = stateSequence(t-1);
                        % When you get to a state change, go back and write
                        % the length
                        tp = t-1; tVal = stateChanges(tp)+1; 
                        while ((stateChanges(tp) ~= 0)&&(tp > 1))
                            stateChanges(tp) = tVal;
                            tp = tp-1;
                        end
                        stateChanges(tp) = tVal;
                    end
                end
                
                %disp([stateSequence,stateChanges,prevState]);
                
                
                % Calculate the transition probs.
                for fromState = 1:3
                    for toState = 1:3
                        ix = find((thisState == fromState)&(nextState == toState));
                        xLocs = xTrack(ix);
                        fromLengths = stateChanges(ix);
                        prevStates  = prevState(ix);
                        toLengths = stateChanges(ix+1);
                        Xix = dsearchn(xBins',xLocs);
                        if (size(Xix,1) > 0)
                            for xNn=1:size(Xix,1)
                                xN = Xix(xNn);
                                xLoc = xLocs(xNn);
                                StateCounts(fromState,xN,toState) = StateCounts(fromState,xN,toState)+1;
                                if (fromState ~= toState)
                                    fromLength = fromLengths(xNn)./10;
                                    toLength = toLengths(xNn)./10;
                                    aPrevState = prevStates(xNn);
                                    StateChangeStats(end+1,:) = ...
                                        [fromState,toState,xLoc,fromLength,toLength,aPrevState];
                                end
                            end   
                        end
                    end
                end             

            end
        end
    end

    ProbDist = StateCounts;
    % Normalize to probability 
    % Enforce that all outgoing probs sum to 1
    for fromState = 1:3
        for binN = 1:nBins
            totalByX = sum(ProbDist(fromState,binN,:));
            % Ensure we got at least one sample
            potentialProbs = [1 1 1];
            if (totalByX > 0)
                potentialProbs = ProbDist(fromState,binN,:)./totalByX;
            end
            % If there are no deterministic samples it's ok
            if (max(potentialProbs) < 1)
                newProbDist(fromState,binN,:) = potentialProbs;
            else
                % If the sampling is wacky, enforce boundary conditions
                    % If on the left side, go right
                    if (binN < nBins/2)
                        % and on the left side, turn right or stop
                        newProbDist(fromState,binN,:) = [0, .5, .5];
                    % If on the right side, go left
                    else
                        % If on the right side, keep going
                        newProbDist(fromState,binN,:) = [.5, .5, 0];
                    end                    
            end

        end
    end
    ProbDist = newProbDist;
    
%     figure();
%     plotProbDist(ProbDist,xBins);
%  
%     
    