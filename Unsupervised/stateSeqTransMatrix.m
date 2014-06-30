function transMatrix = stateSeqTransMatrix(stateSeq, lag)

	maxState = max(stateSeq);
	transMatrix = zeros(maxState,maxState);

	for state1 = 1:maxState

		state1IX = find(stateSeq == state1);
		otherState1 = state1IX + lag;
		ix = find(otherState1 < 1); otherState1(ix) = [];
		ix = find(otherState1 > length(stateSeq)); otherState1(ix) = [];

		n1 = hist(stateSeq(otherState1),[1:maxState]);
		transMatrix(:,state1) = n1(:)./sum(n1(:));

	end



