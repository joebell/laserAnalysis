function similarityMap = mapTransSimilarity(transMatrix)

	D = pdist(transMatrix','correlation');
	similarityMap = squareform(D);
	save('simMap.mat','similarityMap');

