function laserLightDurationHistogram(expList, useEpochs, useLanes)

	histBins = 0:.5:30;
	timeSampleInterval = .1;

    for expNn = 1:size(expList,2)
        expN = expList(expNn);
        loadData(expN);
        laserPowers(expNn) = max(exp.laserParams.*exp.laserFilter);
    end   
    powerList = unique(laserPowers);
    Npowers = size(powerList,2);
    
    histCountsOn = zeros(Npowers, size(histBins,2));
    histCountsOff = zeros(Npowers, size(histBins,2));

    for powerN=1:Npowers
        allCorrs{powerN} = [];
    end
        
    for expNn = 1:size(expList,2)
        expN = expList(expNn);
        loadData(expN);
        powerN = dsearchn(powerList',max(exp.laserParams.*exp.laserFilter));
        
        for epochN = useEpochs

		    bodyX = resample(exp.epoch(epochN).track.bodyX,0:timeSampleInterval:exp.epoch(epochN).track.bodyX.Time(end));
			headX = resample(exp.epoch(epochN).track.headX,0:timeSampleInterval:exp.epoch(epochN).track.headX.Time(end));
			tTrack = bodyX.Time;


            for laneN = useLanes
                scaledTrack = bodyX.Data(:,laneN) + headX.Data(:,laneN);

				if (exp.laserParams(1) > exp.laserParams(2))
					leftEpoch = 1;
				elseif (exp.laserParams(2) > exp.laserParams(1))
					leftEpoch = 0;
				elseif ((exp.laserParams(1) == 0) && (exp.laserParams(2) == 0))
					leftEpoch = randi(2) - 1;
				end
				if (leftEpoch == 1)
                	stateSequence = (scaledTrack < 0);
				else
					stateSequence = (scaledTrack > 0);
				end
				[onDur, offDur] = binaryDurations(scaledTrack);
					


                Non = hist(onDur.*timeSampleInterval, histBins);
                Noff = hist(offDur.*timeSampleInterval, histBins);
                histCountsOn(powerN,:) = histCountsOn(powerN,:) + Non;
                histCountsOff(powerN,:) = histCountsOff(powerN,:) + Noff;               
            end
        end
    end
    
    for powerN=1:Npowers
        Non = histCountsOn(powerN,:);
        Noff = histCountsOff(powerN,:);
        totalCounts = sum(Non)+sum(Noff);
        plotColor = [powerN/Npowers,0,0];
        plot(histBins, Non./totalCounts.*histBins,'Color',plotColor); hold on;
		plot(histBins, -Noff./totalCounts.*histBins ,'Color',plotColor);
    end
    xlabel('Light Duration (s)','FontSize',6);
    ylabel('P','FontSize',6);
    set(gca,'FontSize',6);
    box off;
