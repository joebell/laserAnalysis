function laserPowerSeriesFlex(dM, useLanes, plotQuantity, travelThreshold, lineColor, scatters, timeTrend, laneAvg, grandMean, errorBars, LR)
    
    laneSwitches = zeros(8,1);
    laneSwitches(useLanes) = 1;

    refLineOn = false;
    if strcmp(plotQuantity,'dTraveled')
        pQ = dM.dTraveled;
        pQ = pQ ./ 120;
        plotQuantity = 'Mean speed (mm/sec)';
    elseif strcmp(plotQuantity, 'decPI')
        pQ = dM.decPI;
        plotQuantity = 'PI (# Decisions)';
        refLineOn = true;
    elseif strcmp(plotQuantity, 'numDec')
        pQ = dM.numDec;
        plotQuantity = '# Decisions';
    elseif strcmp(plotQuantity,'PI')
        refLineOn = true;
        pQ = dM.PI;
    else
        pQ = getfield(dM,plotQuantity);
    end
    
    plotEpochScatters = scatters;
    plotTimeTrends = timeTrend;
    plotLaneAvgs    = laneAvg;
    plotGrandMean   = grandMean;
    plotLRBreakouts = LR;
    
    bigLineWidths = .5;
    labelFontSize = 6;
    chunkWidth = 2.75;

    numPoints = size(pQ,2);
    laserPowers = dM.conc(:,1)';
    powerList = unique(laserPowers);
    nPowers = size(powerList,2);
    fileNs = dM.fileN;
    fileList = unique(fileNs);
    nFiles = size(fileList,2);
    fileOrder = dsearchn(fileList',fileNs');
    blockNs = ceil(fileOrder./nPowers);
    nBlocks = max(blockNs);

    if refLineOn
        line([powerList(1)-chunkWidth/2,powerList(end)+chunkWidth/2],[0,0],'LineStyle',':','Color',[1 1 1]*.7); hold on;
    end

means = [];
stErrs  = [];

for powerN = 1:nPowers;
    power = powerList(powerN);
    
    % Plot a point for each scored epoch
    if plotEpochScatters
        for laneN = useLanes
                ix = find((laserPowers == power)&...
                    (dM.dTraveled > travelThreshold)&...
                    (dM.isOdor)&(dM.lane == laneN)&...
                    (laneSwitches(dM.lane))');
                numFound = size(ix,2);
                pQs = pQ(ix);
            xDots = power + ((fileOrder(ix)/nFiles)-.5)*chunkWidth;
            plotColor = pretty(laneN);
            scatter(xDots,pQs,'MarkerEdgeColor',plotColor,'Marker','+','SizeData',ones(numFound,1)*9);
            hold on;
        end
    end
    
    % Plot a mini time series at each power point
    if plotTimeTrends
        for blockN = 1:nBlocks
            ix = find((laserPowers == power)&...
                (dM.dTraveled > travelThreshold)&...
                (dM.isOdor)&(blockNs' == blockN)&(laneSwitches(dM.lane))');
            numFound = size(ix,2);
            pQs = pQ(ix);
            blockMeans(blockN) = nanmean(pQs);
            blockStErrs(blockN) = nanstd(pQs)./sqrt(numFound);
        end
        xPoints = power + ((1:nBlocks)./nBlocks - .5)*chunkWidth;
        h = joeArea(xPoints,blockMeans-blockStErrs,blockMeans+blockStErrs);
        set(h,'EdgeColor','none','FaceColor',lineColor,'FaceAlpha',.2);
        hold on;
        plot(xPoints,blockMeans,'Color',lineColor); 
        box off;
    end    
    
    % Plot each fly's avg. at each power
    if plotLaneAvgs
        for laneN = 1:8
            ix = find((laserPowers == power)&...
                (dM.dTraveled > travelThreshold)&...
                (dM.isOdor)&(dM.lane == laneN)&(laneSwitches(dM.lane))');
            numFound = size(ix,2);
            pQs = pQ(ix);
            laneMean = nanmean(pQs);
            laneErr = nanstd(pQs)/sqrt(numFound);
            x = power+(laneN/8 -.5)*chunkWidth;
            tickWidth = .2;
            line([x x],[-laneErr, laneErr]+laneMean,'Color',pretty(laneN),'LineWidth',bigLineWidths); hold on;
            line(x + tickWidth/2.*[-1 1],laneMean+[0,0],'Color',pretty(laneN),'LineWidth',bigLineWidths);
            % errorbar(power+(laneN/8 -.5)*1,laneMean,laneErr,'Color',pretty(laneN));
        end        
    end
    
    % Plot separate scores for L & R
    if plotLRBreakouts
    	ix = find((laserPowers == power)&...
                (dM.dTraveled > travelThreshold)&...
                (dM.isOdor)&(dM.leftEpoch == 1)&(laneSwitches(dM.lane))');
        numFound = size(ix,2);
        pQs = pQ(ix);
        leftMean = nanmean(pQs);
        leftErr = nanstd(pQs)/sqrt(numFound);
        
        ix = find((laserPowers == power)&...
                (dM.dTraveled > travelThreshold)&...
                (dM.isOdor)&(dM.leftEpoch == -1)&(laneSwitches(dM.lane))');
        numFound = size(ix,2);
        pQs = pQ(ix);
        rightMean = nanmean(pQs);
        rightErr = nanstd(pQs)/sqrt(numFound);
        
        x = power+(-1)*chunkWidth/8;
        tickWidth = .2;
        line([x x],[-leftErr, leftErr]+leftMean,'Color',pretty('e'),'LineWidth',bigLineWidths ); hold on;
        line(x + tickWidth/2.*[-1 1],leftMean+[0,0],'Color',pretty('e'),'LineWidth',bigLineWidths );

        x = power+(1)*chunkWidth/8;
        tickWidth = .2;
        line([x x],[-rightErr, rightErr]+rightMean,'Color',pretty('r'),'LineWidth',bigLineWidths );
        line(x + tickWidth/2.*[-1 1],rightMean+[0,0],'Color',pretty('r'),'LineWidth',bigLineWidths );
    end
    
    % Plot the grand means
    ix = find((laserPowers == power)&...
        (dM.dTraveled > travelThreshold)&...
        (dM.isOdor)&(laneSwitches(dM.lane))');
    numFound = size(ix,2);
    pQs = pQ(ix);   
    
    means(powerN) = nanmean(pQs);
    stErrs(powerN) = nanstd(pQs)/sqrt(numFound);
end

if plotGrandMean
    if errorBars
        errorbar(powerList,means,stErrs,'Color',lineColor,'LineWidth',bigLineWidths); hold on;
    else
        plot(powerList,means,'Color',lineColor,'LineWidth',bigLineWidths); hold on;
    end
end

axis tight;
ylims = ylim();
ylim([ylims(1)-.1,ylims(2)+.1]);
ylabel(plotQuantity,'FontSize',labelFontSize);

xlim([powerList(1)-chunkWidth/2,powerList(end)+chunkWidth/2]);
xlabel('Laser Command (AU / 255)','FontSize',labelFontSize);
set(gca,'ZTick',[],'FontSize',labelFontSize);
set(gca,'XTick',powerList);
    