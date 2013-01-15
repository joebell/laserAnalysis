function laserBlockSeries(blockSize, dM, useLanes, plotQuantity, travelThreshold, lineColor)

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
    
    
    bigLineWidths = .5;
    labelFontSize = 6;
	chunkWidth = .75;


    numPoints = size(pQ,2);
    laserPowers = dM.conc(:,1)';
    powerList = unique(laserPowers);
    nPowers = size(powerList,2);
	xScale = max([mean(diff(powerList)),1]);  % Protect against 1 power
    fileNs = dM.fileN;
    fileList = unique(fileNs);
    nFiles = size(fileList,2);
    fileOrder = dsearchn(fileList',fileNs');
    blockNs = ceil(fileOrder./(blockSize));
    nBlocks = max(blockNs);

    if refLineOn
        line([0 nBlocks+1],[0,0],'LineStyle',':','Color',[1 1 1]*.7); hold on;
    end

means = [];
stErrs  = [];

for blockN = 1:nBlocks;   
  
    % Plot the grand means
    ix = find((blockNs == blockN)'&...
        (dM.dTraveled > travelThreshold)&...
        (dM.isOdor)&(laneSwitches(dM.lane))');
    numFound = size(ix,2);
    pQs = pQ(ix);   
    
    means(blockN) = nanmean(pQs);
    stErrs(blockN) = nanstd(pQs)/sqrt(numFound);
end

%if plotGrandMean
%    if errorBars
%        errorbar(1:nBlocks,means,stErrs,'Color',lineColor,'LineWidth',bigLineWidths); hold on;
	h = joeArea(1:nBlocks,means-stErrs,means+stErrs);
	set(h,'EdgeColor','none','FaceColor',lineColor,'FaceAlpha',.3);
%    else
        plot(1:nBlocks,means,'.-','Color',lineColor,'LineWidth',bigLineWidths); hold on;
%    end
%end

axis tight;
ylims = ylim();
ylim([ylims(1)-.1,ylims(2)+.1]);
ylabel(plotQuantity,'FontSize',labelFontSize);

xlim([0 nBlocks+1]);
xlabel('Block #','FontSize',labelFontSize);
set(gca,'ZTick',[],'FontSize',labelFontSize);
set(gca,'XTick',1:nBlocks);

for n = 1:7
	line((nBlocks*n/8).*[1 1] + .5,ylim(),'Color','k');
end

    
