function openLoopAvgPlots(fileList)

	speedLimit = 1;
	gateTime = 14.9;
	dXdTRanges = [speedLimit Inf; 0 speedLimit/2];
	XRanges = [15 Inf;5 15;-5 5;-15 -5; -Inf -15];

	figure();
	nRows = size(XRanges,1);
	nCols = size(dXdTRanges,1)*2;

	for rowN = 1:nRows
		for dXdTN = 1:(nCols/2)

			colN = (dXdTN-1)*2 + 1;
			subplot(nRows,nCols,(rowN-1)*nCols + colN);
				openLoopAvgPlot(fileList,gateTime,XRanges(rowN,:),dXdTRanges(dXdTN,:));
				ylabel('X (mm)');
			colN = (dXdTN-1)*2 + 2;
			subplot(nRows,nCols,(rowN-1)*nCols + colN);
				openLoopAvgSpeedPlot(fileList,gateTime,XRanges(rowN,:),dXdTRanges(dXdTN,:));
				ylabel('Speed (mm/s)');			

			pause(1);

		end
	end
