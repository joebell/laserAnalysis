function newSeq = remapStates(similarityMap, stateSeq, nStates)

	% Z = linkage(1./(similarityMap + .001));
	Z = linkage(similarityMap);
	T = cluster(Z,'maxclust',nStates);	

	newSeq = zeros(1,length(stateSeq));
	for stateN = 1:length(T)

		ix = find(stateSeq == stateN);
		newSeq(ix) = T(stateN);

	end
