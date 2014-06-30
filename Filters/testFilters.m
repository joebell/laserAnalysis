function testFilters()

	% It's a variable...
	exp = 0;

	fL = [];
	fL = [fL, fileListFromExpNum(3479)];
	fL = [fL, fileListFromExpNum(3480)];
	fL = [fL, fileListFromExpNum(3532)];
	fL = [fL, fileListFromExpNum(3534)];

	for fileNn = 1:length(fL)
		fileN = fL(fileNn);
		loadData(fileN);

		[LR, power] = leftOrRight(exp);
		LRlist(fileNn) = LR;
		powerNlist(fileNn) = dsearchn(exp.laserPowers',power);

	end

	figure;
	[allTP, allTC] = transProbs(fL,[1:3],[1:8]);
	image(allTP,'CDataMapping','scaled');

	figure;
	LRtargets = [-1,1];
	for powerN = 1:8
		for LRn = 1:2
			
			subFLn = find((LRlist == LRtargets(LRn)) & (powerNlist == powerN));
			subFL = fL(subFLn);

			[subTP, subTC] = transProbs(subFL,2,1:8);

			subplot(2,8,powerN + 8*(LRn - 1));
			image(subTP - allTP,'CDataMapping','scaled'); hold on;

		end
	end






