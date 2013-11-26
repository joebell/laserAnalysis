function testSpeedSensitivity(Loff,Lon)


	speedRange = [1:.5:9]; % mm/s
	for speedN = 1:length(speedRange)
		speedN
		[PImean, PIstd] = predictPI(Loff,Lon,speedRange(speedN),.1);
		PImeans(speedN) = PImean;
		PIstds(speedN) = PIstd;
	end

	plot(speedRange,PImeans,'b'); hold on;
	plot(speedRange,PImeans+PIstds,'c');
	plot(speedRange,PImeans-PIstds,'c');

