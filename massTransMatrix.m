function allData = massTransMatrix()


expStrings = {'131125-213550-',...	% Gr21a
		'131125-104607-',...	% 67d
		'131124-190203-',...	% Ir40a
		'131124-100739-',...	% Gr21a
		'131123-185824-',...	% 82a
		'131123-102032-',... *  % 42a  [1:112]
		'131122-170337-',...	% 10a
		'131122-081610-',...	% 82a
		'131120-084805-',...	% 42a [1:64]
		'131118-211908-',...	% 22a [17:80]
		'131118-161931-',...	% 83b [17:80]
		'131118-082031-',...	% 22a 
		'131115-160246-',...	% 92a
		'131115-082259-',...	% 22a
		'131114-153336-',...	% Ctrl [65:128]
		'131114-075347-',...	% 42b [65:128]
		'131113-160252-',...	% 83b [65:128]
		};

[expNums{1:17}]    = deal([1:128]);
expNums{6} = [1:112]; expNums{9} = [1:64];
expNums{10} = [17:80]; expNums{11} = [17:80];
expNums{15} = [65:128]; expNums{16} = [65:128]; expNums{17} = [65:128];
genotypes  = {2,7,12,2,8,4,1,8,4,3,9,3,10,3,11,5,9};
NtoSample = 500;

allData = [];

% For each file in the list do some analysis
for expN = 1:length(expStrings)

	genotype = genotypes{expN};
	expList = returnFileList(expStrings{expN});
	dM = makeDataMatrix(expList(expNums{expN}),2);
	ASC = getStateTransitionCounts(expList(expNums{expN}),1:8,2);
	Nchunks = size(ASC,6);
	laserPowers = unique(dM.conc);
	Npowers = length(laserPowers);

	for timeChunk = 1:Nchunks
	for powerN = 1:Npowers

		[laserOff,laserOn] = getTransitionModel(ASC,timeChunk,powerN);
		[estPI,estPIstd] = predictPI(laserOff,laserOn,NtoSample);	
		PI = getPI(dM, powerN, timeChunk);
		allData(:,end+1) = [laserOff(:);laserOn(:);powerN;timeChunk;PI;estPI;genotype;expN];


	end
	end

end

save('massTransData.mat','allData');

function meanPI = getPI(dM, powerN, timeChunk)

	laserPowers = unique(dM.conc);
	Npowers = length(laserPowers);
	powerNumbers = dsearchn(laserPowers,dM.conc);

	ix = find(powerNumbers == powerN);
	PIlist = dM.PI(ix);

	meanPI = mean(PIlist((timeChunk-1)*16 + [1:16]));


		
