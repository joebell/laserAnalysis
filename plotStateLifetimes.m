function plotStateLifetimes(expList, useEpochs, useLanes)

    fontSize = 8;
    plotColors = ['b','r','g'];
    spaceFactor = 1.2;
    timeSampleInterval = .1;
    
%     useLanes = 1:8;
%     useEpochs = [2,4];
    timeBins = 1:1:61;
    
    for expNn = 1:size(expList,2)
        expN = expList(expNn);
        loadData(expN);
        laserPowers(expNn) = max(exp.laserParams.*exp.laserFilter);
    end
    powerList = unique(laserPowers);
    Npowers = size(powerList,2);
    
    histCounts = zeros(3,Npowers,size(timeBins,2));
    for expNn = 1:size(expList,2)
        % disp(expNn);
        expN = expList(expNn);
        loadData(expN);

        powerN = dsearchn(powerList',max(exp.laserParams.*exp.laserFilter));

        for laneN = useLanes
            for epochN = useEpochs
                
                bodyX = resample(exp.epoch(epochN).track.bodyX,0:timeSampleInterval:exp.epoch(epochN).track.bodyX.Time(end));
                headX = resample(exp.epoch(epochN).track.headX,0:timeSampleInterval:exp.epoch(epochN).track.headX.Time(end));
                tTrack = bodyX.Time;
                
                scaledTrack = bodyX.Data(:,laneN) + headX.Data(:,laneN);
                stateSeq   = identifyStates(scaledTrack);
                dSSeq = 1 - abs([1,diff(stateSeq)']);
                stateDuration = zeros(size(dSSeq,2),1);
                for n=1:size(dSSeq,2)
                    if (dSSeq(n) == 0)
                        stateDuration(n) = 1;
                    elseif (dSSeq(n) == 1)
                        stateDuration(n) = stateDuration(n-1) + 1;
                    end
                end
                thisState = stateSeq(1:(end-1));
                nextState = stateSeq(2:end);
                for fromState = 1:3
                    ix = find((thisState == fromState) & (nextState ~= fromState));
                    durations = stateDuration(ix);
                    N = hist(durations,timeBins);
                    histCounts(fromState,powerN,:) = ...
                        squeeze(histCounts(fromState,powerN,:)) + N(:);
                end    
            end
        end
    end
    
    
    
    % First figure out the spacing
    for fromState = 1:3
        % subplot(3,1,fromState);
        N = squeeze(histCounts(fromState,:,1:(end-1)));
        totalCounts = sum(N,2);
        for powerN = 1:Npowers
            P(powerN,:) = N(powerN,:)./totalCounts(powerN);
        end
        topPoint(fromState) = max(P(:));
    end
    Yspacing = max(topPoint);
    for fromState = 1:3
        % subplot(3,1,fromState);
        N = squeeze(histCounts(fromState,:,1:(end-1)));
        totalCounts = sum(N,2);
        for powerN = 1:Npowers
            P(powerN,:) = N(powerN,:)./totalCounts(powerN);
        end
        for powerN=1:Npowers
            line([timeBins(1) timeBins(end-1)]./10,-[1 1].*(fromState-1)*Yspacing*spaceFactor,...
                'Color',[.7 .7 .7],'LineStyle','--');
            hold on;
            plot(timeBins(1:(end-1))./10, ...
                P(powerN,:) - (fromState - 1)*Yspacing*spaceFactor,...
                'Color',[(powerN/Npowers) 0 0]);
        end
    end
    
    fromState = 1;
    text(0, -(fromState - 1)*Yspacing*spaceFactor,'Walking Left  ',...
        'HorizontalAlignment', 'left', 'VerticalAlignment','baseline',...
        'FontSize',fontSize, 'Rotation', 90);
    fromState = 2;
    text(0, -(fromState - 1)*Yspacing*spaceFactor,'Stopped  ',...
        'HorizontalAlignment', 'left', 'VerticalAlignment','baseline',...
        'FontSize',fontSize, 'Rotation', 90);
    fromState = 3;
    text(0, -(fromState - 1)*Yspacing*spaceFactor,'Walking Right  ',...
        'HorizontalAlignment', 'left', 'VerticalAlignment','baseline',...
        'FontSize',fontSize, 'Rotation', 90);
    
    axis tight;
    ylim([(-2*spaceFactor - (spaceFactor-1)) 1].*Yspacing);
    xlim([0 timeBins(end-1)./10]);
    ylabel('P');
    xlabel('State duration (sec)');
    set(gca, 'YTick', [], 'YColor','w');
     set(gcf,'Color','w');        
     
            
            
                
                
        
        
        
        