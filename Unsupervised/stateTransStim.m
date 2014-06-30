function transMatrix = stateTransStim(LR,stimN)

	load('testUnsupData.mat');
	startIX = 20*60;
	endIX   = 20*(60+30);

	baseIX = find((alignment(:,1) == LR) & (alignment(:,2) == stimN));

	someSeq = [];
	for baseN=1:length(baseIX)
		st = baseIX(baseN) + startIX;
		en = baseIX(baseN) + endIX;
		someSeq = [someSeq, newSeq(st:en)];
	end

	transMatrix = stateSeqTransMatrix(someSeq,1);



