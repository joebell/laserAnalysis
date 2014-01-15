function plotVelocityAutocorrelation(expList,useEpochs,useLanes)

timeSampleInterval = .1;
    
    for expNn = 1:size(expList,2)
        expN = expList(expNn);
        loadData(expN);
		[lEpoch, testPower] = leftOrRight(exp);
        laserPowers(expNn) = testPower;
    end   
    powerList = unique(laserPowers);
    Npowers = size(powerList,2);

    for powerN=1:Npowers
        allCorrs{powerN} = [];
    end
        
    for expNn = 1:size(expList,2)
        expN = expList(expNn);
        loadData(expN);
		[lEpoch, testPower] = leftOrRight(exp);
        powerN = dsearchn(powerList',testPower);
        powerCorrs = allCorrs{powerN};
        for epochN = useEpochs
            bodyX = resample(exp.epoch(epochN).track.bodyX,0:timeSampleInterval:exp.epoch(epochN).track.bodyX.Time(end));
			headX = resample(exp.epoch(epochN).track.headX,0:timeSampleInterval:exp.epoch(epochN).track.headX.Time(end));
			tTrack = bodyX.Time;
            for laneN = useLanes
                scaledTrack = bodyX.Data(:,laneN) + headX.Data(:,laneN);
                velTrack = smoothVelocityTrack(scaledTrack);
                [powerCorrs(end+1,:), lags] = xcorr(velTrack,150,'coeff');
            end
        end
        allCorrs{powerN} = powerCorrs;
    end
    
    for powerN=1:Npowers
        powerCorrs = allCorrs{powerN};
        plotColor = [powerN/Npowers,0,0];
        plot(lags./10, nanmean(powerCorrs,1),'Color',plotColor);
        hold on;
    end
    xlabel('Time (sec)');
    ylabel('Velocity Autocorrelation');
    ylim([-.3 1.1]);
