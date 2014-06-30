function projSummary()

	travelThresh = 50;
	nFlies = 4;

	% Up to date through 39, plot #29
	genoList = {{'42b ; 92a Unstarved -W',4},... 
				{'42b ; 92a +W',5}, ...
				{'56a ; Gr63a +W',6},...
				{'85a ; 56a +W',7},...
				{'Ctrl +W OLFH',8,13},...
				{'56a ; Gr63a -W',9}...
				{'Gr63a +W',10},...
				{'Ctrl -W OLFH',11,12},...
				{'42a ; 56a +W OLFH',14},...
				{'42a ; 56a +W CLFF',16},...
				{'42a ; 56a -W CLFF',17},...
				{'Ctrl -W CLFF',18,20},...
				{'Bl ; Ir64a -W CLFF',19},...
				{'83b -W CLFF',21,24},...
				{'85a II -W OLFH',22},...
				{'83b -W OLFH',23,25},...
				{'83b +W OLFH',26},...
				{'83b +W CLFF',27},...
				{'83b -W OLFH 1 ant.',28},...
				{'83b -W CLFF 1 ant.', 29},...
				{'Gr63a/Gr63a -W OLFH',30},...
				{'42b ; 67b -W OLFH',31,32},...
				{'42a ; 67b -W OLFH',33},...
				{'67d -W OLFH',34},...
				{'22a -W OLFH',35},...
				{'Ctrl +W CLFF',36},...
				{'42b ; 67b +W OLFH',37},...
				{'67d -W CLFF',38},...
				{'67d +W CLFF',39},...
				}; % 29

for genoN = 1:length(genoList)

	row = genoList{genoN};
	genoName = row{1}
	expNs = row(2:end);

	PI = [];
	decPI = [];

	for expNn = 1:length(expNs)
		expN = expNs{expNn};
		
		fL = fileListFromExpNum(expN);
		dM = makeDataMatrix(fL,2);
		laserPowers = dM.conc(:,1)';
		powerList = unique(laserPowers);

		for flyN = [1:nFlies]
			for powerN = 1:length(powerList)
				power = powerList(powerN);

				ix = find((laserPowers == power)&...
						  (dM.dTraveled > travelThresh)&...
						  (dM.isOdor)&...
						  (dM.lane == flyN));
				PI((expNn - 1)*nFlies + flyN,powerN) = nanmean(dM.PI(ix));
				decPI((expNn - 1)*nFlies + flyN,powerN) = nanmean(dM.decPI(ix));
			end
		end
	end

	summaryResults{genoN} = {genoName,PI,decPI};
end

save('projSummaryResults.mat','summaryResults');

		


