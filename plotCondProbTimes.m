function plotCondProbTimes(expList,axesArray, useEpochs, useLanes)

    exp = 0; % Ensure compiler knows exp is a variable loaded from the data file

minSamples = 1;        % Don't display averages with fewer    
timeLags = [0:1:60,65:5:150];
timeSampleInterval = .1;

% useEpochs = [2,4];
% useLanes = 1:8;
           
% Lag time, lag state, current state, next state
N = zeros(size(timeLags,2),3,3,3);

% Load all the files
for expNn = 1:size(expList,2)
    expN = expList(expNn);
    loadData(expN);
    disp(['CP: ',num2str(expN)]);

    for epochN = useEpochs
        for laneN = useLanes
            
            bodyX = resample(exp.epoch(epochN).track.bodyX,0:timeSampleInterval:exp.epoch(epochN).track.bodyX.Time(end));
			headX = resample(exp.epoch(epochN).track.headX,0:timeSampleInterval:exp.epoch(epochN).track.headX.Time(end));
			tTrack = bodyX.Time;
            
            aTrack = bodyX.Data(:,laneN) + headX.Data(:,laneN);
            stateSequence = identifyStates(aTrack);
            % For each time lag
            for timeLagN = 1:size(timeLags,2);
                timeLag = timeLags(timeLagN);
                nextSequence = stateSequence((1+1+timeLag):end);
                nowSequence  = stateSequence((1+timeLag):(end-1));
                prevSequence = stateSequence(1:(end-timeLag-1));
                for prevState = 1:3
                    for nowState = 1:3
                        for nextState = 1:3
                            counts = nnz( (nextSequence==nextState) &...
                                (nowSequence==nowState) & ...
                                (prevSequence==prevState) );
                            N(timeLagN,prevState,nowState,nextState) = ...
                                N(timeLagN,prevState,nowState,nextState) + counts;
                        end
                    end
                end
            end
        end
    end
end
    
    % After we've cycled through all the experiments, collect the
    % probabilities
    
for timeLagN = 1:size(timeLags,2);
    for prevState = 1:3
        for nowState = 1:3
            for nextState = 1:3
                % P(next | this,prev)
                if (sum( N(timeLagN,prevState,nowState,:)) > minSamples)
                    P(timeLagN,prevState,nowState,nextState) =...
                        N(timeLagN,prevState,nowState,nextState) ./ ...
                        sum( N(timeLagN,prevState,nowState,:));
                else
                    P(timeLagN,prevState,nowState,nextState) = NaN;
                end
            end
        end
    end
end

colorVec = ['b','r','g'];
for nowState = 1:3
    for prevState = 1:3
        for nextState = 1:3
            axes(axesArray(nowState,nextState)); 
            plot(-timeLags./10,P(:,prevState,nowState,nextState),'Color',colorVec(prevState));
            if (nowState == nextState)
                ylim([.9 1]);
            else
                ylim([0 .1]);
            end
			xlim([-15 0]);
            hold on;
			% Add blank labels to ensure even plot sizes.
			title(' ');
			xlabel(' ');
			ylabel(' ');
        end
    end
end

axes(axesArray(1,1));
title(['{P( ... | \leftarrow}',' ','{)}'],'VerticalAlignment','bottom');

axes(axesArray(2,1));
title(['{P( ... | \oslash}',' ','{)}'],'VerticalAlignment','bottom');

axes(axesArray(3,1));
title(['{P( ... | \rightarrow}',' ','{)}'],'VerticalAlignment','bottom');

axes(axesArray(1,1));
ylabel(['{P( \leftarrow}',' ','{| ... )}']);

axes(axesArray(1,2));
ylabel(['{P( \oslash}',' ','{| ... )}']);

axes(axesArray(1,3));
ylabel(['{P( \rightarrow}',' ','{| ... )}']);

axes(axesArray(1,3));
xlabel('Time (sec)');

axes(axesArray(2,3));
xlabel('Time (sec)');

axes(axesArray(3,3));
xlabel('Time (sec)');



        
 
