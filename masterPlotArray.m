function plotArray = masterPlotArray(fileList,epochList,laneList)

	% First crunch some data structures we'll reuse
	dM = makeDataMatrix(fileList, epochList);
	f = figure('Visible','off');
	AllStateProbs = plotStateTransitions(fileList,laneList,epochList);
	stateTransAx = gca;
	ASC = getStateTransitionCounts(fileList,laneList,epochList);

	% Generate the power series
	pQList = {'PI','decPI','numDec','dTraveled'};
	flagList = {[false,false,false,true,true,true],...
				[false,true,false,false,false,false],...
				[false,false,true,false,false,false]};
	plotN = 1;
	for pQ = pQList
		for fV = flagList
			f = figure('Visible','off');
			laserPowerSeriesFlex(dM,laneList,pQ,5,'b',fV(1),fV(2),...
									fV(3),fV(4),fV(5),fV(6));
			plotArray(plotN) = gca;
			plotN = plotN + 1;
		end
	end

	% Plot space-time density
	f = figure('Visible','off');
	laserPlotDensityMod(fileList,laneList);
	plotArray(plotN) = gca; plotN = plotN + 1;

	% Plot state density
	f = figure('Visible','off');
	axAr = [subplot(1,3,1),subplot(1,3,2),subplot(1,3,3)];
	laserPlotDensityStates(fileList, epochList, laneList, axAr);
	plotArray(plotN) = axAr(1); plotN = plotN + 1;
	plotArray(plotN) = axAr(2); plotN = plotN + 1;
	plotArray(plotN) = axAr(3); plotN = plotN + 1;

	% We plotted state transitions above to get ASP, copy it 
	% into the array here.
	plotArray(plotN) = stateTransAx; plotN = plotN + 1;

