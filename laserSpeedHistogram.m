function laserSpeedHistogram(expList, useEpochs, useLanes)

    exp = 0; % Ensure compiler knows exp is a variable loaded from the data file

	histBins = 0:1:26;
	timeSampleInterval = .1;

    for expNn = 1:size(expList,2)
        expN = expList(expNn);
        loadData(expN);
		[lEpoch, testPower] = leftOrRight(exp);
        laserPowers(expNn) = testPower;
    end   
    powerList = unique(laserPowers);
    Npowers = size(powerList,2);
    
    histCounts = zeros(Npowers, size(histBins,2));
    histCountsRem = zeros(Npowers, size(histBins,2));

    for powerN=1:Npowers
        allCorrs{powerN} = [];
    end
        
    for expNn = 1:size(expList,2)
        expN = expList(expNn);
        loadData(expN);
		[lEpoch, testPower] = leftOrRight(exp);
        powerN = dsearchn(powerList',testPower);
        
        for epochN = useEpochs

		    bodyX = resample(exp.epoch(epochN).track.bodyX,0:timeSampleInterval:exp.epoch(epochN).track.bodyX.Time(end));
			headX = resample(exp.epoch(epochN).track.headX,0:timeSampleInterval:exp.epoch(epochN).track.headX.Time(end));
			tTrack = bodyX.Time;

            for laneN = useLanes
                scaledTrack = bodyX.Data(:,laneN) + headX.Data(:,laneN);
                stateSequence = identifyStates(scaledTrack);
                speedTrack = abs(smoothVelocityTrack(scaledTrack));
                % Remove stopped flies
                speedRemoved = speedTrack;
                ix = find(stateSequence == 2);
                speedRemoved(ix) = [];
                Nrem = hist(speedRemoved, histBins);
                N = hist(speedTrack, histBins);
                histCountsRem(powerN,:) = histCountsRem(powerN,:) + Nrem;
                histCounts(powerN,:) = histCounts(powerN,:) + N;               
            end
        end
    end
    
    for powerN=1:Npowers
        N = histCounts(powerN,:);
        Nrem = histCountsRem(powerN,:);
        totalCounts = sum(N);
        plotColor = pretty(Npowers + 1 - powerN);
		plot(histBins(1:(end-1)), Nrem(1:end-1)./totalCounts ,'Color',plotColor);
        hold on;
    end
    xlabel('Instantaneous Speed (mm/s)');
    ylabel('P');
    box off;
