function [dM,ASC] = compareStateTransitionModels(varargin)

	if nargin == 3
		expList = varargin{1};
		useLanes = varargin{2};
		useEpochs = varargin{3};
		dM = makeDataMatrix(expList,2);  
		ASC = getStateTransitionCounts(expList, useLanes, useEpochs);
	elseif nargin == 2;
		dM = varargin{1};
		ASC = varargin{2};
	end

	laserPowerSeriesFlex(dM,1:8,'PI',20/4,'k',false,true,false,false,false,false);

	powers = unique(dM.conc);
	Npowers = length(powers);
	Nchunks = size(ASC,6);

	chunkWidth = .75;

	for powerN = 1:Npowers
		for timeChunk = 1:Nchunks

			[laserOffProb,laserOnProb] = getTransitionModel(ASC,timeChunk,powerN);

			[PImean, PIstd] = predictPI(laserOffProb,laserOnProb);
			PImeans(powerN,timeChunk) = PImean;
			PIstds(powerN,timeChunk) = PIstd;
		end

		xScale = powers(end)/(Npowers-1);
		xVals = (powerN-1)*xScale + ([1:Nchunks] - Nchunks/2)/Nchunks*chunkWidth*xScale;
		plot(xVals,PImeans(powerN,:),'bo-'); hold on;

	end
