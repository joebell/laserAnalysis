function [laserOffProb,laserOnProb] = getTransitionModel(ASC,timeChunk,powerN)

			% Indexing constants
			laserL = 1;
			laserR = 2;
			arenaLength = size(ASC,4);
			endExclude = 5;	% Bins
			leftSide = (1+endExclude):ceil(arenaLength/2);
			rightSide = ceil(arenaLength/2):(arenaLength-endExclude); % Exclude ends

			for fromState = 1:3
			for toState = 1:3

				% In laser
				Lside = ASC(powerN,laserL,fromState,leftSide,1:3,timeChunk);
				Rside = ASC(powerN,laserR,4-fromState,rightSide,1:3,timeChunk);
				allStates = sum(Lside(:)) + sum(Rside(:));
				Lside = ASC(powerN,laserL,fromState,leftSide,toState,timeChunk);
				Rside = ASC(powerN,laserR,4-fromState,rightSide,4-toState,timeChunk);
				thisState = sum(Lside(:)) + sum(Rside(:));
				laserOnProb(toState,fromState) = thisState/allStates;

				% Out of laser
				Lside = ASC(powerN,laserR,4-fromState,leftSide,1:3,timeChunk);
				Rside = ASC(powerN,laserL,fromState,rightSide,1:3,timeChunk);
				allStates = sum(Lside(:)) + sum(Rside(:));
				Lside = ASC(powerN,laserR,4-fromState,leftSide,4-toState,timeChunk);
				Rside = ASC(powerN,laserL,fromState,rightSide,toState,timeChunk);
				thisState = sum(Lside(:)) + sum(Rside(:));
				laserOffProb(toState,fromState) = thisState/allStates;

			end
			end
