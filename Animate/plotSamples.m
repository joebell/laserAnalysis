function plotSamples(tA, tAIX, IXs, syncSamps, preSamps, postSamps)

	for plotN = 1:length(IXs)

		trackN = IXs(plotN);
		track = tA{trackN};

		syncSample = syncSamps(plotN);
		startSample = syncSample - preSamps;
		endSample   = syncSample + postSamps;
		if startSample < 1
			startSample = 1;
		end
		if endSample > size(track,1)
			endSample = size(track,1);
		end
		
		bodyPos = track(:,1);
		plot(([startSample:endSample] - syncSample)./20, bodyPos(startSample:endSample)); hold on;
	end

	
