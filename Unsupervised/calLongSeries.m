function [longSeq,alignment] = calLongSeries(fileList, flyList)

	resamplePeriod = .05;
	longSeq = [];
	alignment = [];

	for fileNn = 1:length(fileList)
		fileN = fileList(fileNn);

		loadData(fileN);

		trackLength = exp.wholeTrack.bodyX.Time(end);
		newTimeVector = 0:resamplePeriod:trackLength;
		alignSeg = zeros(length(newTimeVector),2);
		[LR, testPower] = leftOrRight(exp);

		alignSeg(1,1) = LR;
		alignSeg(1,2) = dsearchn(exp.laserPowers',testPower);

		bodyX = resample(exp.wholeTrack.bodyX, newTimeVector);
		bodyY = resample(exp.wholeTrack.bodyY, newTimeVector);
		headX = resample(exp.wholeTrack.headX, newTimeVector);
		headY = resample(exp.wholeTrack.headY, newTimeVector);

		for flyNn = 1:length(flyList)
			flyN = flyList(flyNn);

			dataChunk = [];
			dataChunk(:,1) = bodyX.Data(:,flyN);
			dataChunk(:,2) = bodyY.Data(:,flyN);
			dataChunk(:,3) = headX.Data(:,flyN);
			dataChunk(:,4) = headY.Data(:,flyN);

			longSeq = cat(1,longSeq, dataChunk);
			alignment = cat(1,alignment,alignSeg);
		end
	end





