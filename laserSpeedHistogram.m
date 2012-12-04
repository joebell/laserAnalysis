function laserSpeedHistogram(expList, useEpochs, useLanes)

histBins = 0:.5:25;

    for expNn = 1:size(expList,2)
        expN = expList(expNn);
        loadData(expN);
        laserPowers(expNn) = exp.laserPower;
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
        exp.comment;
        powerN = dsearchn(powerList',exp.laserPower);
        
        scaledExp = scaleTracks(exp);
        for epochN = useEpochs
            for laneN = useLanes
                scaledTrack = scaledExp.epoch(epochN).scaledTrack(:,1,laneN);
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
        plotColor = [powerN/Npowers,0,0];
        plot(histBins, Nrem./totalCounts ,'Color',plotColor);
        hold on;
    end
    xlabel('Speed (mm/sec)','FontSize',6);
    ylabel('P','FontSize',6);
    set(gca,'FontSize',6);
    box off;