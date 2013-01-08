function laserMasterPlots(plotTitle, expList, useEpochs,useLanes, fileName)

    h1 = figure();
    laserMasterPlot1(plotTitle, expList, useEpochs, useLanes);
    h2 = figure();
    plotThumbnails(expList, plotTitle, useLanes)
    h3 = figure();
    laserMasterPlot2(plotTitle, expList, useEpochs, useLanes);
	h4 = figure();
	sproutPlot(plotTitle, expList, useEpochs, useLanes, [1,3,5,7]);
	
    
    saveMultiPage([h1,h2,h3,h4],fileName,[false, true, false, false]);
    close([h1,h2,h3,h4]);
    
    
