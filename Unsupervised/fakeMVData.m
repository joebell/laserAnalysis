function dataMatrix = fakeMVData(nObs, nSDim, nODim)

	dataMatrix = randn(nObs,nODim);

	sourceVectors = randn(nSDim,nODim);

	for obsN = 1:nObs
		weights = 10*randn(1,nSDim); %(%10*(randi(2,1,nSDim)-1);
		dataMatrix(obsN,:) = dataMatrix(obsN,:) + weights*sourceVectors;
	end



