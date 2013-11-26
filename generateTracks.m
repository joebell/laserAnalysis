function generateTracks()

	load('AllStateProbs.mat');

	useTurnProb  = true;
	useSpeedHist = false;

	nFlies = 8;
	nReps  = 8;
	nStims = 8;

	exp.comment = 'This is a simulation';
	exp.nullEpochs = [1 3];
	exp.leftEpochs = 2;
	exp.rightEpochs = [];
	exp.nEpochs = 3;
	exp.experimentName = [datestr(now,'YYmmDD-HHMMss-'),'simulationSeries'];
	exp.laserPowers = 1:nStims;
	exp.odor = 'none';
	exp.laserFilter = 1;
	exp.laserParams = [0,0];
	
	baselineMatrix = squeeze(AllStateProbs(1,1,:,:,:) + AllStateProbs(1,2,:,:,:))./2;


	
	for repN = 1:nReps
	for stimN = 1:nStims	
	for LR = 1:2		
	for flyN = 1:nFlies
		
		% Stim # , L or R , From State, X, To State 
		testMatrix = squeeze(AllStateProbs(stimN, LR, :, :, :));
		% Clean-up turn histogram by enforcing boundaries
		% Meh, just don't allow over-running bins...
		
		startPos = rand()*50 - 25; startState = randi(3); duration = 60; sampleRate = 10;
		baselineTrack(:, flyN) = stepTrack(startPos, startState, baselineMatrix, duration, sampleRate); 

		testTrack(:,flyN) = stepTrack(baselineTrack(end,flyN),randi(3),testMatrix,30,sampleRate);

		postTrack(:,flyN) = stepTrack(testTrack(end,flyN),randi(3), baselineMatrix,60,sampleRate);

	end

		if (LR == 1)
			exp.laserParams = [stimN, 0];
		else
			exp.laserParams = [0, stimN];
		end

		exp.epoch(1).track.bodyX = timeseries(baselineTrack   ,([1:size(baselineTrack,1)]-1)./sampleRate);
		exp.epoch(1).track.headX = timeseries(baselineTrack.*0,([1:size(baselineTrack,1)]-1)./sampleRate);

		exp.epoch(2).track.bodyX = timeseries(testTrack   ,([1:size(testTrack,1)]-1)./sampleRate);
		exp.epoch(2).track.headX = timeseries(testTrack.*0,([1:size(testTrack,1)]-1)./sampleRate);

		exp.epoch(3).track.bodyX = timeseries(postTrack   ,([1:size(postTrack,1)]-1)./sampleRate);
		exp.epoch(3).track.headX = timeseries(postTrack.*0,([1:size(postTrack,1)]-1)./sampleRate);
		
		% Save data
		filename = ['RSIM',datestr(now,'yymmdd'),'/','RSIM', datestr(now,'yymmdd'),'-',datestr(now,'HHMMSS'),'.mat'];
		expName  = exp.experimentName;
		% Use evalc to suppress commandline output
		T = evalc('saveExperimentData(expName,filename, ''exp'')');
		listRecent(0);


	end
	end
	end
		

function aTrack = stepTrack(startPos, startState, transMatrix, duration, sampleRate)

	% Replace missing matrix elements with 0
	ix = isnan(transMatrix);
	transMatrix(ix) = 0;
	for n = 1:3
		for m = 1:51
			if sum(transMatrix(n,m,:)) < 1
				transMatrix(n,m,1:3) = [.3,.4,.3];
			end
		end
	end

	defaultSpeed = 6; % mm/sec

	aTrack = [];
	currentPos = startPos;
	currentState = startState;
	for simTime = 0:(1/sampleRate):duration
		
		% Probabilistically update current state
		posBin = dsearchn([-25:1:25]',currentPos);
		randSeed = rand();
		pTrans = squeeze(transMatrix(currentState,posBin,:));
		transCutoffs = cumsum(pTrans);
		if (randSeed < transCutoffs(1))
			currentState = 1;
			vel = defaultSpeed;
		elseif (randSeed <= transCutoffs(2))
			currentState = 2;
			vel = 0;
		else
			currentState = 3;
			vel = -defaultSpeed;
		end
		
		% Integrate speed to get position
		currentPos = currentPos + vel/sampleRate;
		if (currentPos < -25)
			currentPos = -25;
%			currentState = 2;
		elseif (currentPos > 25)
			currentPos = 25;
%			currentState = 2;
		end

		% Store the position to the track
		aTrack(end+1) = currentPos;

	end
		
