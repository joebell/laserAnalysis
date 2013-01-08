function sproutPlotNonAligned() 

timeSampleInterval = .05;
plotLength = 60/timeSampleInterval;    % Samples
previewLength = 0/timeSampleInterval; % Samples
filterCorner = .1;
nCols = 7;

fileList = (4765+14*4):(4765+14*9-1);
% fileList = 4341+14*5;
useEpochs = 2;

allData = [];

sproutFig = figure();
posFig = figure();
speedFig = figure();
angSpeedFig = figure();
totalPosFig = figure();
totalSpeedFig = figure();
totalAngSpeedFig = figure();

for n=1:7
    posMatrixC{n} = [];
    speedMatrixC{n} = [];
    angSpeedMatrixC{n} = [];
end

orderList = 1:size(fileList,2);
for order = orderList
    
    fileNum = fileList(order);
    loadData(fileNum);
    
    rowN = dsearchn(exp.laserPowers',max(exp.laserParams));
    
    if exp.laserParams(1) > exp.laserParams(2)
        % Left epoch
        leftEpoch = true;
        rightEpoch = false;
        nullEpoch = false;
    elseif exp.laserParams(1) < exp.laserParams(2)
        % Right epoch
        leftEpoch = false;
        rightEpoch = true;
        nullEpoch = false;
    elseif exp.laserParams(1) == exp.laserParams(2)
        % No laser epoch, do either
        leftEpoch = false;
        rightEpoch = false;
        nullEpoch = true;
    end
    
    for epochN = useEpochs
        
        bodyXs = resample(exp.epoch(epochN).track.bodyX,0:timeSampleInterval:exp.epoch(epochN).track.bodyX.Time(end));
        bodyYs = resample(exp.epoch(epochN).track.bodyY,0:timeSampleInterval:exp.epoch(epochN).track.bodyY.Time(end));
        headXs = resample(exp.epoch(epochN).track.headX,0:timeSampleInterval:exp.epoch(epochN).track.headX.Time(end));
        headYs = resample(exp.epoch(epochN).track.headY,0:timeSampleInterval:exp.epoch(epochN).track.headY.Time(end));

        for flyN = 1:8

            bodyX = bodyXs.Data(:,flyN);
            bodyY = bodyYs.Data(:,flyN);
            headX = headXs.Data(:,flyN);
            headY = headYs.Data(:,flyN);
            time = 0:timeSampleInterval:exp.wholeTrack.bodyX.Time(end);
            
            angle = atan2(headY,headX);
            unwrappedAngle = unwrap(angle);
            sampleRate = 1/timeSampleInterval;
            lowPass = sampleRate*filterCorner; % Hz
            [b a] = butter(2, lowPass/(sampleRate/2),'low');
            smoothUnwrapped = filtfilt(b,a,unwrappedAngle);
            dAdT = diff(smoothUnwrapped);
%             smoothAngle = mod(smoothUnwrapped + pi,2*pi) - pi;
%             ix = find(abs(diff(smoothAngle)) > pi);
%             smoothAngle(ix) = NaN;
%             ix = find(abs(diff(angle)) > pi);
%             angle(ix) = NaN;
            
            if (leftEpoch)
                bodyX = -bodyX;
                headX = -headX;
            elseif (rightEpoch)
            elseif (nullEpoch)
                if (randi(2) == 1)
                    bodyX = -bodyX;
                    headX = -headX;
                end
            end
            ix = 1;
            

            if (size(ix,1) < 1)
                sampleVector = [];
            elseif (ix(1) < (previewLength+1))
                sampleVector = [];
            else    
                startSample = ix(1) - previewLength;
                if ((startSample + previewLength + plotLength + 1) <= size(bodyX,1))
                    sampleVector = startSample : (startSample+previewLength+plotLength+1);
                else
                    sampleVector = startSample : size(bodyX,1);
                end
            end
            
            if (size(sampleVector,1) > 0)
            
                figure(sproutFig);
                sproutSampleVector = sampleVector((previewLength+1):end);
                subplot(size(exp.laserPowers,2)*1,nCols,(rowN-1)*nCols+randi(nCols));
                plot(bodyX(sproutSampleVector),bodyY(sproutSampleVector),'.-','Color',pretty(flyN)); hold on;
%                 plotXVecs = [bodyX(sampleVector),bodyX(sampleVector)+headX(sampleVector)/1,...
%                     NaN.*bodyX(sampleVector)]';
%                 plotYVecs = [bodyY(sampleVector),bodyY(sampleVector)+headY(sampleVector)/1,...
%                     NaN.*bodyY(sampleVector)]';
%                 plot(plotXVecs(:),plotYVecs(:),'Color',pretty(flyN)); 
                xlim([-25 25]);
                ylim([-3 3]);
                title(['LP = ',num2str(exp.laserPowers(rowN).*exp.laserFilter)]);
                axis off;
                line([-25 25],[0 0],'Color','k');
                line([0 0],[-2.5 2.5],'Color','k');

                figure(posFig);
                subplot(size(exp.laserPowers,2)*1,1,rowN*1-0);
                plot((sampleVector - sampleVector(previewLength+1)).*timeSampleInterval,bodyX(sampleVector),'Color',[.8 .8 1]*1); hold on;
                posMatrix = posMatrixC{rowN};
                posMatrix = padcat(1,posMatrix,bodyX(sampleVector)',NaN);
                posMatrixC{rowN} = posMatrix;
                
                figure(speedFig);
                subplot(size(exp.laserPowers,2)*1,1,rowN*1-0);
                speedTrace = abs([diff(bodyX(sampleVector));0])./timeSampleInterval;
                plot((sampleVector - sampleVector(previewLength+1)).*timeSampleInterval,speedTrace,'Color',[.8 .8 1]*1); hold on;
                speedMatrix = speedMatrixC{rowN};
                speedMatrix = padcat(1,speedMatrix,speedTrace',NaN);
                speedMatrixC{rowN} = speedMatrix;
                
                figure(angSpeedFig);
                subplot(size(exp.laserPowers,2)*1,1,rowN*1-0);
                angSpeedTrace = abs(dAdT(sampleVector))./timeSampleInterval;
                plot((sampleVector - sampleVector(previewLength+1)).*timeSampleInterval,angSpeedTrace,'Color',[.8 .8 1]*1); hold on;
                angSpeedMatrix = angSpeedMatrixC{rowN};
                angSpeedMatrix = padcat(1,angSpeedMatrix,angSpeedTrace',NaN);
                angSpeedMatrixC{rowN} = angSpeedMatrix;
                
            end

        end
    end
end


for rowN = 1:size(exp.laserPowers,2)
    
    posMatrix = posMatrixC{rowN};
    speedMatrix = speedMatrixC{rowN};
    angSpeedMatrix = angSpeedMatrixC{rowN};
    
    figure(posFig);
    subplot(size(exp.laserPowers,2)*1,1,rowN*1-0);
    meanVals = nanmean(posMatrix,1);
    stdVals = nanstd(posMatrix)/sqrt(size(posMatrix,1));
    timeVals = ((1:size(posMatrix,2))-previewLength).*timeSampleInterval;
    h = joeArea(timeVals,meanVals-stdVals,meanVals+stdVals);
    set(h,'EdgeColor','none','FaceColor',[1 1 1]*.2,'FaceAlpha',.3);
    plot(timeVals,meanVals,'r'); hold on;
                    xlim([-previewLength plotLength]*timeSampleInterval);
                    ylim([-25 25]);
                    ylabel('X (mm)');
                    title(['LP = ',num2str(exp.laserPowers(rowN).*exp.laserFilter)]);
    figure(totalPosFig);
    h = joeArea(timeVals,meanVals-stdVals,meanVals+stdVals); hold on;
    set(h,'EdgeColor','none','FaceColor',pretty(8-rowN),'FaceAlpha',.3);
    plot(timeVals,meanVals,'Color',pretty(8-rowN));
                    xlim([-previewLength plotLength]*timeSampleInterval);
                    ylim([-25 25]);
                    ylabel('X (mm)');
                    %title(['LP = ',num2str(exp.laserPowers(rowN).*exp.laserFilter)]);

    figure(speedFig);
    subplot(size(exp.laserPowers,2)*1,1,rowN*1-0);
    meanVals = nanmean(speedMatrix,1);
    stdVals = nanstd(speedMatrix)/sqrt(size(speedMatrix,1));
    timeVals = ((1:size(speedMatrix,2))-previewLength).*timeSampleInterval;
    h = joeArea(timeVals,meanVals-stdVals,meanVals+stdVals);
    set(h,'EdgeColor','none','FaceColor',[1 1 1]*.2,'FaceAlpha',.3);
    plot(timeVals,meanVals,'r'); hold on;
                    xlim([-previewLength plotLength]*timeSampleInterval);
                    ylim([0 20]);
                    ylabel('Speed (mm/sec)');
                    title(['LP = ',num2str(exp.laserPowers(rowN).*exp.laserFilter)]);
    figure(totalSpeedFig);
    h = joeArea(timeVals,meanVals-stdVals,meanVals+stdVals); hold on;
    set(h,'EdgeColor','none','FaceColor',pretty(8-rowN),'FaceAlpha',.3);
    plot(timeVals,meanVals,'Color',pretty(8-rowN));
                    xlim([-previewLength plotLength]*timeSampleInterval);
                    ylim([0 20]);
                    ylabel('Speed (mm/sec)'); 
                    %title(['LP = ',num2str(exp.laserPowers(rowN).*exp.laserFilter)]);
    
    figure(angSpeedFig);
    subplot(size(exp.laserPowers,2)*1,1,rowN*1-0);
    meanVals = nanmean(angSpeedMatrix,1);
    stdVals = nanstd(angSpeedMatrix)/sqrt(size(angSpeedMatrix,1));
    timeVals = ((1:size(angSpeedMatrix,2))-previewLength).*timeSampleInterval;
    h = joeArea(timeVals,meanVals-stdVals,meanVals+stdVals);
    set(h,'EdgeColor','none','FaceColor',[1 1 1]*.2,'FaceAlpha',.3);
    plot(timeVals,meanVals,'r'); hold on;
                    xlim([-previewLength plotLength]*timeSampleInterval);
                    ylim([0 5]);
                    ylabel('Ang. sp. (rad/sec)');
                    title(['LP = ',num2str(exp.laserPowers(rowN).*exp.laserFilter)]);
    figure(totalAngSpeedFig);
    h = joeArea(timeVals,meanVals-stdVals,meanVals+stdVals); hold on;
    set(h,'EdgeColor','none','FaceColor',pretty(8-rowN),'FaceAlpha',.3);
    plot(timeVals,meanVals,'Color',pretty(8-rowN));
                    xlim([-previewLength plotLength]*timeSampleInterval);
                    ylim([0 5]);
                    ylabel('Angular speed (rad/sec)');
                    %title(['LP = ',num2str(exp.laserPowers(rowN).*exp.laserFilter)]);
    
end


figList = [sproutFig,posFig,speedFig,angSpeedFig,totalPosFig,totalSpeedFig,totalAngSpeedFig];
saveMultiPage(figList, 'sproutPlot.pdf', [true,false,false,false,true,true,true]);




