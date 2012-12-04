function plotVelocityAutocorrelation(expList,useEpochs,useLanes)

%     useLanes = 1:8;
%     useEpochs = [2,4];
    
    for expNn = 1:size(expList,2)
        expN = expList(expNn);
        loadData(expN);
        laserPowers(expNn) = exp.laserPower;
    end   
    powerList = unique(laserPowers);
    Npowers = size(powerList,2);

    for powerN=1:Npowers
        allCorrs{powerN} = [];
    end
        
    for expNn = 1:size(expList,2)
        expN = expList(expNn);
        loadData(expN);
        exp.comment;
        powerN = dsearchn(powerList',exp.laserPower);
        powerCorrs = allCorrs{powerN};
        scaledExp = scaleTracks(exp);
        for epochN = useEpochs
            for laneN = useLanes
                velTrack = scaledExp.epoch(epochN).velocity(:,1,laneN);
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