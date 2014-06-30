function [transProbs, transCount] = transProbs(fileList, epochList, flyList)

	resamplePeriod = .05;
	smoothTime = .5;
	tP = 0;

	posDensity = [];
	speedDensity = [];
	angleDensity = [];
	maxStates = 100; lag = 1;
	transCount  = zeros(maxStates,maxStates);

	for fileNn = 1:length(fileList)
		fileN = fileList(fileNn);

		loadData(fileN);

		for epochNn = 1:length(epochList)
			epochN = epochList(epochNn);

			track = exp.epoch(epochN).track;
			trackLength = track.bodyX.Time(end);
			newTimeVector = 0:resamplePeriod:trackLength;
			
			bodyXts = resample(track.bodyX, newTimeVector);
			bodyYts = resample(track.bodyY, newTimeVector);
			headXts = resample(track.headX, newTimeVector);
			headYts = resample(track.headY, newTimeVector);
			for flyNn = 1:length(flyList)
				flyN = flyList(flyNn);
				bodyX = smooth(bodyXts.Data(:,flyN),...
									smoothTime/resamplePeriod);
				bodyY = smooth(bodyYts.Data(:,flyN),...
									smoothTime/resamplePeriod);
				headX = smooth(headXts.Data(:,flyN),...
									smoothTime/resamplePeriod);
				headY = smooth(headYts.Data(:,flyN),...
									smoothTime/resamplePeriod);
				headAngle = atan2(headY,headX);
				bodydX = [diff(bodyX);0]./resamplePeriod;
				bodydY = [diff(bodyY);0]./resamplePeriod;
				bodySpeed = sqrt(bodydX.^2 + bodydY.^2);
	
				flyN = flyList(flyNn);
				[flyPosDensity, posBins] = histc(bodyX,...
												[-Inf,-15,-5, 5,15,Inf]);
				[flySpeedDensity, speedBins] = histc(bodySpeed,...
												[-Inf,2,6,12,Inf]);

				[flyAngleDensity, radBins] = histc(cos(headAngle),...
											[-Inf,cos(7*pi/8),cos(5*pi/8),...
											cos(3*pi/8),cos(pi/8),Inf]);

				% Nb. come back to this to fix over-binning from histc
				stateSeq = posBins + (speedBins-1).*(5) + (radBins-1).*(5*4);
				
				if size(posDensity,1) > 0
					posDensity = posDensity + flyPosDensity;
					speedDensity = speedDensity + flySpeedDensity;
					angleDensity = angleDensity + flyAngleDensity;
				else
					posDensity = flyPosDensity;
					speedDensity = flySpeedDensity;
					angleDensity = flyAngleDensity;
				end

				for state1 = 1:maxStates
					state1IX = find(stateSeq == state1);
					otherState1 = state1IX + lag;
					ix = find(otherState1 < 1); otherState1(ix) = [];
					ix = find(otherState1 > length(stateSeq));
						otherState1(ix) = [];
					n1 = hist(stateSeq(otherState1),[1:maxStates]);
					transCount(:,state1) = transCount(:,state1) + n1(:);
				end

			end

		end
	end

	for state1 = 1:maxStates

		transProbs(:,state1) = transCount(:,state1)./sum(transCount(:,state1));

	end

		

