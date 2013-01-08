function manySproutPlot() 

timeSampleInterval = .1;
plotLength = 8/timeSampleInterval;    % Samples
previewLength = 0/timeSampleInterval; % Samples
filterCorner = .1;
nRows = 7;
nCols = 4;

p1powNum = 2;
p2powNum = 7;

fileList = (4765+14*4):(4765+14*9-1);
% fileList = 4341+14*5;
useEpochs = 2;

allData = [];

sproutFig1 = figure();
sproutFig2 = figure();
nPow1Sprouts = 0;
nPow2Sprouts = 0;

orderList = 1:size(fileList,2);
for order = orderList
    
    fileNum = fileList(order);
    loadData(fileNum);
    
    powN = dsearchn(exp.laserPowers',max(exp.laserParams));
    if powN == p1powNum
        useFig = 1;
    elseif powN == p2powNum
        useFig = 2;
    else
        useFig = 0;
    end
    
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
            
            if (leftEpoch && (bodyX(1)+headX(1) > 0))
                ix = find(bodyX+headX < 0);
                bodyX = -bodyX;
                headX = -headX;
            elseif (rightEpoch && (bodyX(1)+headX(1) < 0))
                ix = find(bodyX+headX > 0);
            elseif (nullEpoch && (bodyX(1)+headX(1) > 0))
                ix = find(bodyX+headX < 0);
                bodyX = -bodyX;
                headX = -headX;
            elseif (nullEpoch && (bodyX(1)+headX(1) < 0))
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
                if ((startSample + previewLength + plotLength) <= size(bodyX,1))
                    sampleVector = startSample : (startSample+previewLength+plotLength);
                else
                    sampleVector = startSample : size(bodyX,1);
                end
            end
            
            if (size(sampleVector,1) > 0)
                
                if useFig == 1
                    figure(sproutFig1);
                    nPow1Sprouts = nPow1Sprouts + 1;
                    if nPow1Sprouts > nRows*nCols
                        break;
                    end
                    subplot(nRows,nCols,nPow1Sprouts); hold on;
                elseif useFig == 2
                    figure(sproutFig2);
                    nPow2Sprouts = nPow2Sprouts + 1;
                    if nPow2Sprouts > nRows*nCols
                        break;
                    end
                    subplot(nRows,nCols,nPow2Sprouts); hold on;
                else
                    break;
                end
                
                sproutSampleVector = sampleVector(1+previewLength:end);
%                subplot(size(exp.laserPowers,2)*1,nCols,(rowN-1)*nCols+randi(nCols));
                plot(bodyX(sproutSampleVector),bodyY(sproutSampleVector),'-','Color',[1 1 1]*.3); hold on;
                %scatter(bodyX(sproutSampleVector),bodyY(sproutSampleVector),4,1:size(sproutSampleVector,2));
                plotXVecs = [bodyX(sproutSampleVector),bodyX(sproutSampleVector)+headX(sproutSampleVector)/1,...
                    NaN.*bodyX(sproutSampleVector)]';
                plotYVecs = [bodyY(sproutSampleVector),bodyY(sproutSampleVector)+headY(sproutSampleVector)/1,...
                    NaN.*bodyY(sproutSampleVector)]';
                %plot(plotXVecs(:),plotXVecs(:),'Color',pretty(flyN)); 
                z = zeros(size(plotXVecs(:)));
                col = [1:size(plotXVecs(:),1)]';
                surface([plotXVecs(:)';plotXVecs(:)'],[plotYVecs(:)';plotYVecs(:)'],[z(:)';z(:)'],[col(:)';col(:)'],...
                    'facecol','no',...
                    'edgecol','interp',...
                    'linew',1);
                xlim([-25 25]);
                ylim([-3 3]);
                % title(['LP = ',num2str(exp.laserPowers(rowN).*exp.laserFilter)]);
                axis off;
                line([-25 25],[0 0],'Color','k');
                line([0 0],[-2.5 2.5],'Color','k');
                axis equal;
                
            end

        end
    end
end




% figList = [sproutFig,posFig,speedFig,angSpeedFig,totalPosFig,totalSpeedFig,totalAngSpeedFig];
% saveMultiPage(figList, 'sproutPlot.pdf', [true,false,false,false,true,true,true]);




