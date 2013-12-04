function allData = massTransMatrix(expList,genotypeStrings)

NtoSample = 500;

allData = [];

% For each file in the list do some analysis
for expNn = 1:length(expList)
	expN = expList(expNn);
	genotypeN = getGenotype(genotypeStrings);
	displayOn = false;
	fileList = fileListFromExpNum(expN,displayOn);
	dM = makeDataMatrix(fileList,2);
	ASC = getStateTransitionCounts(fileList,1:8,2);
	Nchunks = size(ASC,6);
	laserPowers = unique(dM.conc);
	Npowers = length(laserPowers);

	for timeChunk = 1:Nchunks
	for powerN = 1:Npowers

		[laserOff,laserOn] = getTransitionModel(ASC,timeChunk,powerN);
		[estPI,estPIstd] = predictPI(laserOff,laserOn,NtoSample);	
		PI = getPI(dM, powerN, timeChunk);
		allData(:,end+1) = [laserOff(:);laserOn(:);powerN;timeChunk;PI;estPI;genotypeN;expN];

	end
	end

end

save(['~/massTransData',num2str(expList(1)),'-',num2str(expList(end)),'.mat'],'allData');

function meanPI = getPI(dM, powerN, timeChunk)

	laserPowers = unique(dM.conc);
	Npowers = length(laserPowers);
	powerNumbers = dsearchn(laserPowers,dM.conc);

	ix = find(powerNumbers == powerN);
	PIlist = dM.PI(ix);

	meanPI = mean(PIlist((timeChunk-1)*16 + [1:16]));


		
