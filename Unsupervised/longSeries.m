function longSeq = longSeries(fileList, flyList)

	resamplePeriod = .05;
	longSeq = [];

	for fileNn = 1:length(fileList)
		fileN = fileList(fileNn);

		loadData(fileN);

		trackLength = exp.wholeTrack.bodyX.Time(end);
		newTimeVector = 0:resamplePeriod:trackLength;
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
		end
	end





