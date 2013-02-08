function laserLagPlot(presentationScan, dM, useLanes, plotQuantity, travelThreshold, lineColor)

    laneSwitches = zeros(8,1); 
    laneSwitches(useLanes) = 1;
	lags = -presentationScan:presentationScan;
	nLags = presentationScan*2 + 1;

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

% Find Grand Mean
		ix = find((dM.dTraveled > travelThreshold)&...
				(dM.isOdor)&(laneSwitches(dM.lane))');
	  	pQs = pQ(ix);
		grandMean = nanmean(pQs);


means = [];
stErrs  = [];

for powerN = 1:nPowers;   
	
	% subplot(nPowers,1,powerN);
    if refLineOn
        line([-presentationScan-1 presentationScan+1],[grandMean grandMean],'LineStyle',':','Color',[1 1 1]*.7); hold on;
		line([-presentationScan-1 presentationScan+1],[0 0],'LineStyle',':','Color',[1 1 1]*.7); hold on;      
	end
	targetPower = powerList(powerN); 

    % Plot the grand means
    ix = find((laserPowers == targetPower)&...
        (dM.dTraveled > travelThreshold)&...
        (dM.isOdor)&(laneSwitches(dM.lane))');
%    numFound = size(ix,2);
%    pQs = pQ(ix); 
	fileOrders = fileOrder(ix);

	for lagN = 1:nLags
		lagVal = lags(lagN);
		getFileOrders = fileOrders + lagVal;
		ix = find(getFileOrders < 1);      getFileOrders(ix) = [];
		ix = find(getFileOrders > nFiles); getFileOrders(ix) = [];
		ix = find(ismember(fileOrder,getFileOrders)'&...
				(dM.dTraveled > travelThreshold)&...
				(dM.isOdor)&(laneSwitches(dM.lane))');
	  	pQs = pQ(ix);
    	numFound = size(ix,2);
		means(powerN,lagN) = nanmean(pQs);
		stErrs(powerN, lagN) = nanstd(pQs)/sqrt(numFound);
	end
	h = joeArea(lags,means(powerN,:)-stErrs(powerN,:),means(powerN,:)+stErrs(powerN,:));
	lineColor = pretty(8-powerN);	
	set(h,'EdgeColor','none','FaceColor',lineColor,'FaceAlpha',.3); hold on;
    plot(lags,means(powerN,:),'.-','Color',lineColor,'LineWidth',bigLineWidths); hold on;


	axis tight;
	ylims = ylim();
	ylim([ylims(1)-.1,ylims(2)+.1]);
	ylabel(plotQuantity,'FontSize',labelFontSize);

	xlim([-presentationScan-.5 presentationScan+.5]);
	xlabel('Stimulus Lag (Trials)','FontSize',labelFontSize);
	set(gca,'ZTick',[],'FontSize',labelFontSize);
	%set(gca,'XTick',1:nBlocks);

end






    
