function masterPlotArray(fileName,plotTitle,fileList,epochList,laneList)
	baseDir = '~/FigureOutput/';
	AC = axesContainer(plotTitle);

	% First crunch some data structures we'll reuse
	dM = makeDataMatrix(fileList, epochList);
	ASC = getStateTransitionCounts(fileList,laneList,epochList);

	% Generate the power series
	pQList = {'PI','decPI','numDec','dTraveled'};
	flagList = {[false,false,false,true,true,true],...
				[false,true,false,false,false,false],...
				[false,false,true,false,false,false]};
	for pQn = 1:length(pQList)
		for fVn = 1:length(flagList)
			pQ = pQList{pQn};
			fV = flagList{fVn};
			f = figure('Visible','off');
			laserPowerSeriesFlex(dM,laneList,pQ,5,'b',fV(1),fV(2),...
									fV(3),fV(4),fV(5),fV(6));
			AC.addAxis(gca);
		end
	end

	% Plot space-time density
	f = figure('Visible','off');
	laserPlotDensityMod(fileList,laneList);
	AC.addAxis(gca);

	% Plot state density
	f = figure('Visible','off');
	axAr = [subplot(1,3,1),subplot(1,3,2),subplot(1,3,3)];
	laserPlotDensityStates(fileList, epochList, laneList, axAr);
	AC.addAxis(axAr(1)); AC.addAxis(axAr(2)); AC.addAxis(axAr(3));

	% We plotted state transitions above to get ASP, copy it 
	% into the array here.
	f = figure('Visible','off');
	AllStateProbs = plotStateTransitions(fileList,laneList,epochList);
	AC.addAxis(gca);

	% Plot baseline state transitions
	f = figure('Visible','off');
	plotStateTransitionsBL(AllStateProbs);
	AC.addAxis(gca);

	% Plot speed histogram
	f = figure('Visible','off');
	laserSpeedHistogram(fileList,epochList,laneList);
	AC.addAxis(gca);

	% Plot the thumbnails
	f = figure('Visible','off');
	plotThumbnails(fileList,'',laneList,epochList);
	AC.addAxis(gca);

	% Plot velocity autocorrelation
	f = figure('Visible','off');
	plotVelocityAutocorrelation(fileList,epochList,laneList);
	AC.addAxis(gca);

	% Plot Mutual Information
	f = figure('Visible','off');
	plotMutualInformation(fileList,epochList,laneList);
	AC.addAxis(gca);

	% Plot State Lifetimes
	f = figure('Visible','off');
	plotStateLifetimes(fileList,epochList,laneList);
	AC.addAxis(gca);

	% Plot Conditional Probability of Transitions with Time
	f = figure('Visible','off');
	for row = 1:3
		for col = 1:3
			axesArray(col,row) = subplot(3,3,(row-1)*3 + col);
		end
	end
	plotCondProbTimes(fileList,axesArray,epochList,laneList);
	for row = 1:3
		for col = 1:3
			AC.addAxis(axesArray(col,row));
		end
	end

	% Plot sprout plots
	f = figure('Visible','off'); powerList = [1,4,6,8];
	sproutPlot('',fileList,epochList,laneList,powerList);
	AC.addAxis(subplot(4,1,1)); 
	AC.addAxis(subplot(4,1,2));
	AC.addAxis(subplot(4,1,3)); 
	AC.addAxis(subplot(4,1,4));

	% Plot Model Thumbnails
	f = figure('Visible','off');
	stateTransThumbs(ASC);	
	for row = 1:3
		for col = 1:6
			AC.addAxis(subplot(3,6,(row-1)*6 + col));
		end
	end
	
	% Plot PI vs. Model Predictions
	f = figure('Visible','off');
	statePIPredictions(ASC,dM,epochList,laneList);
	AC.addAxis(gca);


	% Save it!
	hgsave(AC.axesList,[baseDir,fileName,'.fig']);
	close all;
