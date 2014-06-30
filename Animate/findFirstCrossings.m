function [IXs, syncSamps] = findFirstCrossings(tA,tAIX, powerRange, LRrange, presRange, laneList)

	IXs = [];
	syncSamps = [];
	keyEpochStart = 1200; % samples
	keyEpochEnd   = 1800;

	for trackN = 1:length(tAIX)

		powerN = tAIX(trackN,1);
		powerNOK = ismember(powerN, powerRange);

		LR = tAIX(trackN,2);
		LROK = ismember(LR, LRrange);

		presN = tAIX(trackN,3);
		presNOK = ismember(presN, presRange);

		laneN = tAIX(trackN, 4);
		laneNOK	= ismember(laneN, laneList);

		if (powerNOK && LROK && presNOK && laneNOK)
			IXs(end+1) = trackN;
		end
	end


	removeList = [];
	for IXn = 1:length(IXs)
		trackN = IXs(IXn);

		LR = tAIX(trackN, 2);
		xFactor = -LR;

		track = tA{trackN};
		Xvals = xFactor*(track(:,1) + track(:,3));

		firstLight = find(Xvals(keyEpochStart:keyEpochEnd) > 0,1);
		if isempty(firstLight)
			syncSamps(IXn) = 0;
			removeList(end+1) = IXn;
		else
			syncSamps(IXn) = firstLight + keyEpochStart;
		end
	end

	IXs(removeList) = [];
	syncSamps(removeList) = [];




		
