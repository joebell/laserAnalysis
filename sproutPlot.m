function sproutPlot(plotTitle, fileList, useEpochs, useLanes, usePowers) 

    exp = 0; % Ensure compiler knows exp is a variable loaded from the data file

timeSampleInterval = .05;
plotLength = 30/timeSampleInterval;    % Samples
previewLength = 2/timeSampleInterval; % Samples
filterCorner = .25;
nCols = 7;

% fileList = (4765+14*4):(4765+14*9-1);
% fileList = 4341+14*5;
% useEpochs = 2;

allData = [];

% sproutFig = figure();
% posFig = figure();
% speedFig = figure();
% angSpeedFig = figure();
%totalPosFig = figure();
%totalSpeedFig = figure();
%totalAngSpeedFig = figure();

for n=1:12
    posMatrixC{n} = [];
    speedMatrixC{n} = [];
	ySpeedMatrixC{n} = [];
    angSpeedMatrixC{n} = [];
end

orderList = 1:size(fileList,2);
for order = orderList
    
    fileNum = fileList(order);
    loadData(fileNum);
    [lEpoch, testPower] = leftOrRight(exp); 
    rowN = dsearchn(exp.laserPowers',testPower);
   
    for epochN = useEpochs
        
        bodyXs = resample(exp.epoch(epochN).track.bodyX,0:timeSampleInterval:exp.epoch(epochN).track.bodyX.Time(end));
        bodyYs = resample(exp.epoch(epochN).track.bodyY,0:timeSampleInterval:exp.epoch(epochN).track.bodyY.Time(end));
        headXs = resample(exp.epoch(epochN).track.headX,0:timeSampleInterval:exp.epoch(epochN).track.headX.Time(end));
        headYs = resample(exp.epoch(epochN).track.headY,0:timeSampleInterval:exp.epoch(epochN).track.headY.Time(end));

        for flyN = useLanes

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
            dAdT = [diff(smoothUnwrapped);0];
%             smoothAngle = mod(smoothUnwrapped + pi,2*pi) - pi;
%             ix = find(abs(diff(smoothAngle)) > pi);
%             smoothAngle(ix) = NaN;
%             ix = find(abs(diff(angle)) > pi);
%             angle(ix) = NaN;
            
            if (lEpoch==1 && (bodyX(1)+headX(1) > 0))
                ix = find(bodyX+headX < 0);
                bodyX = -bodyX;
                headX = -headX;
            elseif (lEpoch==-1 && (bodyX(1)+headX(1) < 0))
                ix = find(bodyX+headX > 0);
			else
				ix = [];
            end
            

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
            
%                figure(sproutFig);
                sproutSampleVector = sampleVector(previewLength:end);
%                subplot(size(exp.laserPowers,2)*1,nCols,(rowN-1)*nCols+randi(nCols));
%                plot(bodyX(sproutSampleVector),bodyY(sproutSampleVector),'.-','Color',pretty(flyN)); hold on;
%                 plotXVecs = [bodyX(sampleVector),bodyX(sampleVector)+headX(sampleVector)/1,...
%                     NaN.*bodyX(sampleVector)]';
%                 plotYVecs = [bodyY(sampleVector),bodyY(sampleVector)+headY(sampleVector)/1,...
%                     NaN.*bodyY(sampleVector)]';
%                 plot(plotXVecs(:),plotYVecs(:),'Color',pretty(flyN)); 
%                xlim([-25 25]);
%                ylim([-3 3]);
%                title(['LP = ',num2str(exp.laserPowers(rowN).*exp.laserFilter)]);
%                axis off;
%                line([-25 25],[0 0],'Color','k');
%                line([0 0],[-2.5 2.5],'Color','k');

%                figure(posFig);
%                subplot(size(exp.laserPowers,2)*1,1,rowN*1-0);
%                plot((sampleVector - sampleVector(previewLength+1)).*timeSampleInterval,bodyX(sampleVector),'Color',[.8 .8 1]*1); hold on;
                posMatrix = posMatrixC{rowN};
                posMatrix = padcat(1,posMatrix,bodyX(sampleVector)',NaN);
                posMatrixC{rowN} = posMatrix;
                
%                figure(speedFig);
%                subplot(size(exp.laserPowers,2)*1,1,rowN*1-0);
				xSpeed = [diff(bodyX(sampleVector));0];
                speedTrace = abs(xSpeed)./timeSampleInterval;
%                plot((sampleVector - sampleVector(previewLength+1)).*timeSampleInterval,speedTrace,'Color',[.8 .8 1]*1); hold on;
                speedMatrix = speedMatrixC{rowN};
                speedMatrix = padcat(1,speedMatrix,speedTrace',NaN);
                speedMatrixC{rowN} = speedMatrix;

				ySpeed = [diff(bodyY(sampleVector));0];
                ySpeedTrace = abs(ySpeed)./timeSampleInterval;
                ySpeedMatrix = ySpeedMatrixC{rowN};
                ySpeedMatrix = padcat(1,ySpeedMatrix,ySpeedTrace',NaN);
                ySpeedMatrixC{rowN} = ySpeedMatrix;
                
%                figure(angSpeedFig);
%                subplot(size(exp.laserPowers,2)*1,1,rowN*1-0);
                angSpeedTrace = abs(dAdT(sampleVector))./timeSampleInterval;
%                plot((sampleVector - sampleVector(previewLength+1)).*timeSampleInterval,angSpeedTrace,'Color',[.8 .8 1]*1); hold on;
                angSpeedMatrix = angSpeedMatrixC{rowN};
                angSpeedMatrix = padcat(1,angSpeedMatrix,angSpeedTrace',NaN);
                angSpeedMatrixC{rowN} = angSpeedMatrix;
                
            end

        end
    end
end


for rowN = usePowers
    
    posMatrix = posMatrixC{rowN};
    speedMatrix = speedMatrixC{rowN};
	ySpeedMatrix = ySpeedMatrixC{rowN};
    angSpeedMatrix = angSpeedMatrixC{rowN};
    
%    figure(posFig);
%    subplot(size(exp.laserPowers,2)*1,1,rowN*1-0);
    meanVals = nanmean(posMatrix,1);
    stdVals = nanstd(posMatrix)/sqrt(size(posMatrix,1));
    timeVals = ((1:size(posMatrix,2))-previewLength).*timeSampleInterval;
%    h = joeArea(timeVals,meanVals-stdVals,meanVals+stdVals);
%    set(h,'EdgeColor','none','FaceColor',[1 1 1]*.2,'FaceAlpha',.3);
%    plot(timeVals,meanVals,'r'); hold on;
%                    xlim([-previewLength plotLength]*timeSampleInterval);
%                    ylim([-25 25]);
%                    ylabel('X (mm)');
%                    title(['LP = ',num2str(exp.laserPowers(rowN).*exp.laserFilter)]);
    % figure(totalPosFig);
	subplot(4,1,1);
    h = joeArea(timeVals,meanVals-stdVals,meanVals+stdVals); hold on;
    set(h,'EdgeColor','none','FaceColor',pretty(9-rowN),'FaceAlpha',.3);
    plot(timeVals,meanVals,'Color',pretty(9-rowN));
                    xlim([-previewLength plotLength]*timeSampleInterval);
                    ylim([-25 25]);
					line(xlim(),[0 0],'Color','k');
					line([0,0],ylim(),'Color','k');
                    ylabel('X (mm)');
					xlabel('Time (s)');
%	set(gca,'ActivePositionProperty','OuterPosition','LooseInset',[0 0 0 0]);


%    figure(speedFig);
%    subplot(size(exp.laserPowers,2)*1,1,rowN*1-0);
    meanVals = nanmean(speedMatrix,1);
    stdVals = nanstd(speedMatrix)/sqrt(size(speedMatrix,1));
    timeVals = ((1:size(speedMatrix,2))-previewLength).*timeSampleInterval;
%    h = joeArea(timeVals,meanVals-stdVals,meanVals+stdVals);
%    set(h,'EdgeColor','none','FaceColor',[1 1 1]*.2,'FaceAlpha',.3);
%    plot(timeVals,meanVals,'r'); hold on;
%                    xlim([-previewLength plotLength]*timeSampleInterval);
%                    ylim([0 20]);
%                    ylabel('Speed (mm/sec)');
%                    title(['LP = ',num2str(exp.laserPowers(rowN).*exp.laserFilter)]);
%    figure(totalSpeedFig);
	subplot(4,1,2);
    h = joeArea(timeVals,meanVals-stdVals,meanVals+stdVals); hold on;
    set(h,'EdgeColor','none','FaceColor',pretty(9-rowN),'FaceAlpha',.3);
    plot(timeVals,meanVals,'Color',pretty(9-rowN));
                    xlim([-previewLength plotLength]*timeSampleInterval);
                    ylim([0 15]);
                    ylabel('dX/dt (mm/s)'); 
					line([0,0],ylim(),'Color','k');
					xlabel('Time (s)');
					% title('Aligned by first laser onset per trial');
                    %title(['LP = ',num2str(exp.laserPowers(rowN).*exp.laserFilter)]);
%	set(gca,'ActivePositionProperty','OuterPosition','LooseInset',[0 0 0 0]);
 
    meanVals = nanmean(ySpeedMatrix,1);
    stdVals = nanstd(ySpeedMatrix)/sqrt(size(ySpeedMatrix,1));
    timeVals = ((1:size(ySpeedMatrix,2))-previewLength).*timeSampleInterval;
	subplot(4,1,3);
    h = joeArea(timeVals,meanVals-stdVals,meanVals+stdVals); hold on;
    set(h,'EdgeColor','none','FaceColor',pretty(9-rowN),'FaceAlpha',.3);
    plot(timeVals,meanVals,'Color',pretty(9-rowN));
                    xlim([-previewLength plotLength]*timeSampleInterval);
                    ylim([0 4]);
                    ylabel('dY/dt (mm/s)'); 
					line([0,0],ylim(),'Color','k');
					xlabel('Time (s)');
%	set(gca,'ActivePositionProperty','OuterPosition','LooseInset',[0 0 0 0]);
   
%    figure(angSpeedFig);
%    subplot(size(exp.laserPowers,2)*1,1,rowN*1-0);
    meanVals = nanmean(angSpeedMatrix,1);
    stdVals = nanstd(angSpeedMatrix)/sqrt(size(angSpeedMatrix,1));
    timeVals = ((1:size(angSpeedMatrix,2))-previewLength).*timeSampleInterval;
%    h = joeArea(timeVals,meanVals-stdVals,meanVals+stdVals);
%    set(h,'EdgeColor','none','FaceColor',[1 1 1]*.2,'FaceAlpha',.3);
%    plot(timeVals,meanVals,'r'); hold on;
%                    xlim([-previewLength plotLength]*timeSampleInterval);
%                    ylim([0 5]);
%                    ylabel('Ang. sp. (rad/sec)');
%                    title(['LP = ',num2str(exp.laserPowers(rowN).*exp.laserFilter)]);
%    figure(totalAngSpeedFig);
	subplot(4,1,4);
    h = joeArea(timeVals,meanVals-stdVals,meanVals+stdVals); hold on;
    set(h,'EdgeColor','none','FaceColor',pretty(9-rowN),'FaceAlpha',.3);
    plot(timeVals,meanVals,'Color',pretty(9-rowN));
                    xlim([-previewLength plotLength]*timeSampleInterval);
                    ylim([0 4]);
                    ylabel('(rad/s)');
					line([0,0],ylim(),'Color','k');
					xlabel('Time (s)');
%	set(gca,'ActivePositionProperty','OuterPosition','LooseInset',[0 0 0 0]);

end


%figList = [sproutFig,posFig,speedFig,angSpeedFig,totalPosFig,totalSpeedFig,totalAngSpeedFig];
%saveMultiPage(figList, 'sproutPlot.pdf', [true,false,false,false,true,true,true]);




