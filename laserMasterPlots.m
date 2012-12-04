function laserMasterPlots(plotTitle, expList, useEpochs,useLanes, fileName)

    h1 = figure();
    laserMasterPlot1(plotTitle, expList, useEpochs, useLanes);
    h2 = figure();
    plotThumbnails(expList, plotTitle, useLanes)
    h3 = figure();
    laserMasterPlot2(plotTitle, expList, useEpochs, useLanes);
    
    saveMultiPage([h1,h2,h3],fileName,[false, true, false]);
    close([h1,h2,h3]);
    
    
