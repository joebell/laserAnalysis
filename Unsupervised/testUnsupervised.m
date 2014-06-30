function testUnsupervised()

% Initial quantization and trans matrix
if (false)
	fL = fileListFromExpNum(3479);
%	fL = [fL, fileListFromExpNum(3480)];
%	fL = [fL, fileListFromExpNum(3532)];
%	fL = [fL, fileListFromExpNum(3534)];
	[mDV,alignment] = normalizeTracks(fL, [1:8]);
	stateSeq = quantizeMDV(mDV, 2);
	newSeq = stateSeq;
	save('testUnsupData.mat','stateSeq','newSeq','mDV','alignment');
end

	% Get ready for entry into loop
	load('testUnsupData.mat');
	nStates = max(newSeq);
	lag = 1;
	transMatrix = stateSeqTransMatrix(newSeq,lag);

while (nStates > 16)
	nStates
	similarityMap = mapTransSimilarity(transMatrix);
	disp('Mapped sim...');
	nStates = round(nStates*.95) ;
	newSeq = remapStates(similarityMap, newSeq, nStates);
	disp('Remapped...');
	transMatrix = stateSeqTransMatrix(newSeq,lag);
	disp('Re-transitioned...');

	save('testUnsupData.mat','stateSeq','newSeq','mDV','alignment');
	disp('Saved...');
	if (true)
		close all;
		if (nStates < 100)
			plotDirectedGraph(newSeq,.05);
			pause(.5);
		elseif (nStates < 800)
			image(log(transMatrix),'CDataMapping','scaled');
			pause();
		end
	end

end
