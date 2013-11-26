function openLoopPlots(fileList)

	
	speedLimit = 3;

	figure();
	nCols = 5;
	gateTime = 14.9;
	dXdTRange = [speedLimit Inf];

	colNum = 1;
	xRange = [15 Inf];
	openLoopPlot(fileList,nCols,colNum,gateTime,xRange,dXdTRange);
	colNum = 2;
	xRange = [5 15];
	openLoopPlot(fileList,nCols,colNum,gateTime,xRange,dXdTRange);
	colNum = 3;
	xRange = [-5 5];
	openLoopPlot(fileList,nCols,colNum,gateTime,xRange,dXdTRange);
	colNum = 4;
	xRange = [-15 -5];
	openLoopPlot(fileList,nCols,colNum,gateTime,xRange,dXdTRange);
	colNum = 5;
	xRange = [-Inf -15];
	openLoopPlot(fileList,nCols,colNum,gateTime,xRange,dXdTRange);

	figure();
	nCols = 5;
	gateTime = 14.9;
	dXdTRange = [-.5 .5]*speedLimit;

	colNum = 1;
	xRange = [15 Inf];
	openLoopPlot(fileList,nCols,colNum,gateTime,xRange,dXdTRange);
	colNum = 2;
	xRange = [5 15];
	openLoopPlot(fileList,nCols,colNum,gateTime,xRange,dXdTRange);
	colNum = 3;
	xRange = [-5 5];
	openLoopPlot(fileList,nCols,colNum,gateTime,xRange,dXdTRange);
	colNum = 4;
	xRange = [-15 -5];
	openLoopPlot(fileList,nCols,colNum,gateTime,xRange,dXdTRange);
	colNum = 5;
	xRange = [-Inf -15];
	openLoopPlot(fileList,nCols,colNum,gateTime,xRange,dXdTRange);
