function binBySpeed(dM, useLanes, plotQuantity)

	speedBinSize = .25;  % in stdev
	nSpeedBins = 128;

	laneSwitches = zeros(8,1);
    laneSwitches(useLanes) = 1;

    refLineOn = false;
    if strcmp(plotQuantity,'dTraveled')
        pQ = dM.dTraveled;
        pQ = pQ ./ 30;
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

    numPoints = size(pQ,2);
    laserPowers = dM.conc(:,1)';
    powerList = unique(laserPowers);
    nPowers = size(powerList,2);
	xScale = max([mean(diff(powerList)),1]);  % Protect against 1 power
    fileNs = dM.fileN;
    fileList = unique(fileNs);
    nFiles = size(fileList,2);
    fileOrder = dsearchn(fileList',fileNs');
	
		


	blockNs = zeros(1,size(pQ,2));
	for powerN = 1:nPowers
		power = powerList(powerN);
		ix = find((laserPowers == power)&...
		     	  (dM.isOdor));
		for ixN = 1:size(ix,2)
			blockNs(ix(ixN)) = ceil(ixN/16);
		end
	end
	nBlocks = max(blockNs);

	meanSpeeds = dM.dTraveled./30;
	speedBinHalfWidth = std(meanSpeeds).*speedBinSize;
	binRange = (max(meanSpeeds)-speedBinHalfWidth) - speedBinHalfWidth;
	speedBinCenters = speedBinHalfWidth:(binRange/nSpeedBins):(max(meanSpeeds)-speedBinHalfWidth);

subplot(3,1,1:2);
plot([0 max(meanSpeeds)],[0 0],'--','Color',[.6 .6 .6]); hold on;
for powerN = 1:nPowers;
    power = powerList(powerN);

	means = [];
	stds  = [];
	Ns    = [];

	for binN = 1:length(speedBinCenters)
		binBottom = speedBinCenters(binN) - speedBinHalfWidth;
		binTop    = speedBinCenters(binN) + speedBinHalfWidth;
		ix = find((laserPowers == power)&...
		          (meanSpeeds >= binBottom)&...
				  (meanSpeeds <= binTop)&...
		          (dM.isOdor)&(laneSwitches(dM.lane))');
		if (length(ix) > 0)
			means(binN) = nanmean(pQ(ix));
			stds(binN)  =  nanstd(pQ(ix));
			  Ns(binN)  = length(ix);
		else
			means(binN) = 0;
			stds(binN)  = 0;
			  Ns(binN)  = 1;
		end

	end

	subplot(3,1,1:2);
	h = joeArea(speedBinCenters,means-stds./sqrt(Ns),means+stds./sqrt(Ns));
	set(h,'EdgeColor','none','FaceColor',pretty(nPowers - powerN + 1),...
		'FaceAlpha',.2); hold on;
	plot(speedBinCenters, means,'Color',pretty(nPowers - powerN + 1)); 
	if (powerN == nPowers)
		fillL = (speedBinCenters(1) - speedBinHalfWidth);
		fillR = (speedBinCenters(1) + speedBinHalfWidth);
		lims = ylim();
		fill([fillL fillL fillR fillR],[lims(1),lims(2), lims(2), lims(1)],'k','FaceColor','k','EdgeColor',...
			'none','FaceAlpha',.2);
		xlim([0 max(meanSpeeds)]);
		xlabel('Mean walking speed (mm/sec)');
		ylabel(plotQuantity);
	end
	
	subplot(3,1,3);
	plot(speedBinCenters,Ns,'Color',pretty(nPowers - powerN + 1)); hold on;
	if (powerN == nPowers)
		fillL = (speedBinCenters(1) - speedBinHalfWidth);
		fillR = (speedBinCenters(1) + speedBinHalfWidth);
		lims = ylim();
		fill([fillL fillL fillR fillR],[lims(1),lims(2), lims(2), lims(1)],'k','FaceColor','k','EdgeColor',...
			'none','FaceAlpha',.2);
		xlim([0 max(meanSpeeds)]);
		xlabel('Mean walking speed (mm/sec)');
		ylabel('N');
	end
	
end





