% Predicts PI from static transition matrices
function [PImean, PIstd] = predictPI(varargin)

	if nargin < 2
		laserOnProb =  [.93,.01,.02;...
						.05,.98,.05;
						.02,.01,.93];
		laserOffProb = [.93,.01,.02;...
						.05,.98,.05;
						.02,.01,.93];
		speedMean = 6; % mm/sec
		speedStd  = 3;
		NtoSample = 100;
	elseif (nargin == 2)
		laserOffProb = varargin{1};
		laserOnProb  = varargin{2};
		speedMean = 6; % mm/sec
		speedStd  = 3;
		NtoSample = 100;
	elseif (nargin == 3)
		laserOffProb = varargin{1};
		laserOnProb = varargin{2};
		NtoSample = varargin{3};
		speedMean = 6;
		speedStd = 3;
	elseif (nargin == 4)
		laserOffProb = varargin{1};
		laserOnProb  = varargin{2};
		speedMean = varargin{3};
		speedStd  = varargin{4};
		NtoSample = 100;
	elseif (nargin == 5)
		laserOffProb = varargin{1};
		laserOnProb = varargin{2};
		speedMean = varargin{3};
		speedStd = varargin{4};
		NtoSample = varargin{5};
	end

	sampleInterval = .1;
	duration = 30;
	arenaBounds = [-25 25];

	for flyN = 1:NtoSample
		
		% Initialize fly to random position and speed
		xi = rand()*(arenaBounds(2)-arenaBounds(1)) + arenaBounds(1);
		statei = randi(3);
		speed = abs(speedStd*randn() + speedMean);

		% Calculate a trace
		nTimePoints = round(duration./sampleInterval);
		for t=[1:nTimePoints]
			posTrace(t) = xi;
			[xi, statei] = stepFly(xi, statei, speed);
		end
		% plot(posTrace); hold on;
		PI(flyN) = calcPI(posTrace);
	end
	
	PImean = mean(PI);
	PIstd  = std(PI);





	
	function [xo, stateo] = stepFly(xi, statei, speed)

		% Evolve the position
		if (statei == 1)
			xo = xi - speed*sampleInterval;
		elseif (statei == 2)
			xo = xi;
		elseif (statei == 3)
			xo = xi + speed*sampleInterval;
		end
		if (xo < arenaBounds(1)) 
			xo = arenaBounds(1); 
		end
		if (xo > arenaBounds(2)) 
			xo = arenaBounds(2); 
		end

		% Find the next state we'll be in
		% Don't allow further walking past the wall
		if (xi < 0)
			transProbs = laserOnProb(:,statei);
			if (xo == arenaBounds(1))
				transProbs(1) = 0;
			end
		else
			transProbs = laserOffProb(:,statei);
			if (xo == arenaBounds(2))
				transProbs(3) = 0;
			end
		end

		probBoundaries = cumsum(transProbs);
		randSeed = rand();
		if (randSeed < probBoundaries(1)/probBoundaries(3))
			stateo = 1;
		elseif (randSeed < probBoundaries(2)/probBoundaries(3))
			stateo = 2;
		else
			stateo = 3;
		end
	end

	function PI = calcPI(posTrace)
		PI = (nnz(find(posTrace < 0)) - nnz(find(posTrace >= 0)))./length(posTrace);
	end

end

	
