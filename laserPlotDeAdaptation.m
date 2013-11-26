function laserPlotDeAdaptation(dM, plotQuantity)

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

	laserPowers = unique(dM.conc);
	laserDelays = unique(dM.adaptDelay);

	for powerN = 1:length(laserPowers)
		subplot(length(laserPowers),3,3*(powerN-1)+3);
		for delayN = 1:length(laserDelays)
    
			aPower = laserPowers(powerN);
			aDelay = laserDelays(delayN);

			ix = find((dM.conc == aPower)'&...
				(dM.adaptDelay == aDelay)&...
				(dM.isOdor));
			numFound = size(ix,2);
			pQs = pQ(ix);   
    
			means(delayN) = nanmean(pQs);
			stErrs(delayN) = nanstd(pQs)/sqrt(numFound);

		end
       	errorbar(laserDelays,means,stErrs,'Color',pretty(powerN),'LineWidth',.5); hold on;
		hold on;
		xlabel('Delay after adapting epoch (min)');
		ylabel(plotQuantity);
		title(['Test Power: ',num2str(aPower)]);
%		ylim([-.1 .7]);
		xlim([0 5]);
%		plot(xlim(),[0 0],'k--');
	end

	
