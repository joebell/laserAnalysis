function laserMasterPlots(plotTitle, expList, useEpochs,useLanes, fileName)

    baseDir = '~/FigureOutput/';

    h1 = figure('visible','off');
    laserMasterPlot1(plotTitle, expList, useEpochs, useLanes);
    set(h1,'visible','off');

    h2 = figure('visible','off');
    plotThumbnails(expList, plotTitle, useLanes, useEpochs);
    set(h2,'visible','off');

    h3 = figure('visible','off');
    laserMasterPlot2(plotTitle, expList, useEpochs, useLanes);
    set(h3,'visible','off');
    
    h4 = figure('visible','off');
    sproutPlot(plotTitle, expList, useEpochs, useLanes, [1,3,5,7]);
    set(h4,'visible','off');

    h5 = figure('visible','off);
    laserMasterPlot5(expList,useEpochs,useLanes);
    set(h5,'visible','off');

    hgsave([h1,h2,h3,h4,h5],[baseDir,fileName,'.fig']);
    close all;
