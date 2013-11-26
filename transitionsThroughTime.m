function ASC = transitionsThroughTime(varargin)

	if nargin == 1
		ASC = varargin{1};
	else
		expList = varargin{1};
		useLanes = varargin{2};
		useEpochs = varargin{3};
		ASC = getStateTransitionCounts(expList, useLanes, useEpochs)
	end
	
	axisLabels = {'Toward','Stop','Away'};
    % Constants for indexing
	arenaLength = size(ASC,4);
	leftSide = 1:ceil(arenaLength/2);
	rightSide = ceil(arenaLength/2):arenaLength;
	laserL = 1;
	laserR = 2;

 	% [PowerN, [LaserL|LaserR], [From],[X],[To],[TimeChunk]  

	for fromState = 1:3
	for toState = 1:3
	for powerN = 1:size(ASC,1)
		
		for timeChunk = 1:size(ASC,6)
			% In laser
			Lside = ASC(powerN,laserL,fromState,leftSide,1:3,timeChunk);
			Rside = ASC(powerN,laserR,4-fromState,rightSide,1:3,timeChunk);
			allStates(timeChunk) = sum(Lside(:)) + sum(Rside(:));
			Lside = ASC(powerN,laserL,fromState,leftSide,toState,timeChunk);
			Rside = ASC(powerN,laserR,4-fromState,rightSide,4-toState,timeChunk);
			thisState(timeChunk) = sum(Lside(:)) + sum(Rside(:));
		end
		subplot(3,6,getSubplotN(toState,fromState,1)); hold on;
		plot(thisState./allStates,'Color',pretty(9-powerN));
		xlim([0 5]);
		set(gca,'XTick',[]);
		title(['P(',axisLabels{toState},'|',axisLabels{fromState},')']);

		for timeChunk = 1:size(ASC,6)
			% Out of laser
			Lside = ASC(powerN,laserR,4-fromState,leftSide,1:3,timeChunk);
			Rside = ASC(powerN,laserL,fromState,rightSide,1:3,timeChunk);
			allStates(timeChunk) = sum(Lside(:)) + sum(Rside(:));
			Lside = ASC(powerN,laserR,4-fromState,leftSide,4-toState,timeChunk);
			Rside = ASC(powerN,laserL,fromState,rightSide,toState,timeChunk);
			thisState(timeChunk) = sum(Lside(:)) + sum(Rside(:));
		end
		subplot(3,6,getSubplotN(toState,fromState,0)); hold on;
		plot(thisState./allStates,'Color',pretty(9-powerN));
		xlim([0 5]);
		set(gca,'XTick',[]);
		title(['P(',axisLabels{toState},'|',axisLabels{fromState},')']);

	end
	end
	end

	

	function spN = getSubplotN(toState,fromState,InLaserHalf)

		spN = fromState + (1 - InLaserHalf)*3 + (toState - 1)*6;
