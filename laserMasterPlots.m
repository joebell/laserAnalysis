function laserMasterPlots(plotTitle, expList, useEpochs,useLanes, fileName)

    h1 = figure('visible','off');
    laserMasterPlot1(plotTitle, expList, useEpochs, useLanes);
    h2 = figure('visible','off');
    plotThumbnails(expList, plotTitle, useLanes, useEpochs)

%    saveMultiPage([h1,h2],['a',fileName],[false, true]);
%    close([h1,h2]);

    h3 = figure('visible','off');
    laserMasterPlot2(plotTitle, expList, useEpochs, useLanes);
%	h4 = figure();
%	sproutPlot(plotTitle, expList, useEpochs, useLanes, [1,3,5,7]);

%    saveMultiPage([h3,h4],['b',fileName],[false, false]);
%    close([h3,h4]);

	saveMultiPage([h1,h2,h3],['a',fileName],[false, true, false]);
	close([h1,h2,h3]);

	h4 = figure('visible','off');
	sproutPlot(plotTitle, expList, useEpochs, useLanes, [1,3,5,7]);
	saveTallPDF(['b',fileName]);
	close(h4);

	cmd = ['pdftk ',['a',fileName],' ',['b',fileName],' cat output ',fileName];
	system(cmd);
	system(['rm ','a',fileName]);
	system(['rm ','b',fileName]);
 	
%close all;
%clear all;
    
