function [tA, tAIX] = assembleTrackArray(fL, useLanes)

	resamplePeriod = .05;
	smoothTime = .2;

	exp = [];
	tA = {};
	tAIX = [];

	leftPres  = zeros(8,1);
	rightPres = zeros(8,1);
		
	for fileNumN = 1:length(fL)
		fileNum = fL(fileNumN);

		loadData(fileNum);
		[LR, power] = leftOrRight(exp);
		powerN = dsearchn(exp.laserPowers',power);

		if LR == 1
			rightPres(powerN) = rightPres(powerN) + 1;
			presN = rightPres(powerN);
		elseif LR == -1
			leftPres(powerN) = leftPres(powerN) + 1;
			presN = leftPres(powerN);
		end

		track = exp.wholeTrack;
		trackLength = track.bodyX.Time(end);
		newTimeVector = 0:resamplePeriod:trackLength;

		bodyXts = resample(track.bodyX, newTimeVector);
		bodyYts = resample(track.bodyY, newTimeVector);
		headXts = resample(track.headX, newTimeVector);
		headYts = resample(track.headY, newTimeVector);

		for laneNn = 1:length(useLanes)
			laneN = useLanes(laneNn);

			bodyX = smooth(bodyXts.Data(:, laneN),smoothTime/resamplePeriod);
			bodyY = smooth(bodyYts.Data(:, laneN),smoothTime/resamplePeriod);
			headX = smooth(headXts.Data(:, laneN),smoothTime/resamplePeriod);
			headY = smooth(headYts.Data(:, laneN),smoothTime/resamplePeriod);

			tAentryIX = [powerN, LR, presN, laneN];

			tAIX(end+1,:) = [powerN, LR, presN, laneN];
			tA{end+1} = [bodyX, bodyY, headX, headY];

		end

	end

