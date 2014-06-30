function similarity = transProbSimilarity(stateSequence, state1, state2, stateLag)

	maxState = max(stateSequence);

	state1IX = find(stateSequence == state1);
	state2IX = find(stateSequence == state2);

	otherState1 = state1IX + stateLag;
	otherState2 = state2IX + stateLag;

	ix = find(otherState1 < 1); otherState1(ix) = [];
   	ix = find(otherState1 > length(stateSequence)); otherState1(ix) = [];
	ix = find(otherState2 < 1); otherState2(ix) = [];
   	ix = find(otherState2 > length(stateSequence)); otherState2(ix) = [];


	n1 = hist(stateSequence(otherState1), [1:maxState]);
	n2 = hist(stateSequence(otherState2), [1:maxState]);

	p1 = n1./sum(n1);
	p2 = n2./sum(n2);

	similarity = p1*p2';
	if (isnan(similarity))
		similarity = 0;
	end

