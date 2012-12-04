function I = plotMutualInformationByPrevState(expList)

% Turn state vector into a binary list for each previous state

timeLags = [0:5:150];
useLanes = 1:8;
plotColors = ['b','r','g'];

I = zeros(3, size(timeLags,2));
% For each time lag
for targetState = 1:3
    for timeLagN = 1:size(timeLags,2);  
        disp(['T: ',num2str(timeLagN)]);
        timeLag = timeLags(timeLagN);
        NC = zeros(3,1);
        NT = zeros(3,1);
        PC = zeros(2,1);
        PT = zeros(2,1);
        JC = zeros(3,2);
        JT = zeros(3,2);
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
                nowSequence = stateSequence((1+timeLag):end);
                targetSequence = (stateSequence == targetState) + 1;
                prevSequence = targetSequence(1:(end-timeLag));
                for nowState = 1:3
                    NC(nowState) = NC(nowState) + nnz(nowSequence == nowState);
                    NT(nowState) = NT(nowState) + size(nowSequence,1);
                end
                for prevState = 1:2
                    PC(prevState) = PC(prevState) + nnz(prevSequence == prevState);
                    PT(prevState) = PT(prevState) + size(prevSequence,1);
                end
                for nowState = 1:3
                    for prevState = 1:2
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
            for nowState = 1:3
                Pnow = NC(nowState) / NT(nowState);
                marginalI = Pnow * log2(1/Pnow);
                I(targetState,timeLagN) = I(targetState,timeLagN) + marginalI;
            end
        else
            for nowState = 1:3
                for prevState = 1:2
                    Pnow = NC(nowState)/NT(nowState);
                    Pprev = PC(prevState)/PT(prevState);
                    Pjoint = JC(nowState,prevState)/JT(nowState,prevState);

                    marginalI = Pjoint*log2(Pjoint/(Pnow*Pprev));
                    I(targetState, timeLagN) = I(targetState,timeLagN) + marginalI;
                end
            end
        end

    end
end


for targetState = 1:3

    % Plot it
    plot(-timeLags'./10, I(targetState,:),'Color',plotColors(targetState)); hold on;
    line([-timeLags(1)./10,-timeLags(end)./10],[1 1]*I(targetState,1),...
        'LineStyle','--','Color',plotColors(targetState));
end
    xlabel('Time (sec)');
    ylabel('I(now ; previous) (bits)');
        

        
        
