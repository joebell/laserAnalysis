function I = plotMutualInformationByThisState(expList)

% Turn state vector into a binary list for each current state

timeLags = [0:5:150];
useLanes = 1:8;
plotColors = ['b','r','g'];

I = zeros(3, size(timeLags,2));
% For each time lag
for thisState = 1:3
    for timeLagN = 1:size(timeLags,2);  
        disp(['T: ',num2str(timeLagN)]);
        timeLag = timeLags(timeLagN);
        NC = zeros(2,1);
        NT = zeros(2,1);
        PC = zeros(3,1);
        PT = zeros(3,1);
        JC = zeros(2,3);
        JT = zeros(2,3);
        % Load all the files
        for expNn = 1:size(expList,2)
            expN = expList(expNn);
            disp(expN);
            loadData(expN);
            exp.comment;
            scaledExp = scaleTracks(exp);
            for laneN = useLanes
                aTrack = scaledExp.wholeScaledTrack(:,1,laneN);
                stateSequence = identifyStates(aTrack);
                thisSequence = (stateSequence == thisState) + 1;
                nowSequence = thisSequence((1+timeLag):end);
                prevSequence = stateSequence(1:(end-timeLag));
                for nowState = 1:2
                    NC(nowState) = NC(nowState) + nnz(nowSequence == nowState);
                    NT(nowState) = NT(nowState) + size(nowSequence,1);
                end
                for prevState = 1:3
                    PC(prevState) = PC(prevState) + nnz(prevSequence == prevState);
                    PT(prevState) = PT(prevState) + size(prevSequence,1);
                end
                for nowState = 1:2
                    for prevState = 1:3
                        JC(nowState,prevState) = JC(nowState,prevState) + ...
                            nnz((nowSequence == nowState) & ...
                               (prevSequence == prevState));
                        JT(nowState,prevState) = JT(nowState,prevState) + size(prevSequence,1);                    
                    end
                end
            end
        end

        % After we've cycled through all the experiments, collect the
        % probabilities
        % If timeLag = 0, show the self entropy
        if (timeLag == 0)
            for nowState = 1:2
                Pnow = NC(nowState) / NT(nowState);
                marginalI = Pnow * log2(1/Pnow);
                I(thisState,timeLagN) = I(thisState,timeLagN) + marginalI;
            end
        else
            for nowState = 1:2
                for prevState = 1:3
                    Pnow = NC(nowState)/NT(nowState);
                    Pprev = PC(prevState)/PT(prevState);
                    Pjoint = JC(nowState,prevState)/JT(nowState,prevState);

                    marginalI = Pjoint*log2(Pjoint/(Pnow*Pprev));
                    I(thisState, timeLagN) = I(thisState,timeLagN) + marginalI;
                end
            end
        end

    end
end


for thisState = 1:3

    % Plot it
    plot(-timeLags'./10, I(thisState,:),'Color',plotColors(thisState)); hold on;
    line([-timeLags(1)./10,-timeLags(end)./10],[1 1]*I(thisState,1),...
        'LineStyle','--','Color',plotColors(thisState));
end
    xlabel('Time (sec)');
    ylabel('I(now ; previous) (bits)');
        

        
        
