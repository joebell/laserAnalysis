function listDMOrder(dM)

	nExp = length(dM.fileN)/8;
	travelThreshold = 5;

	powerList = unique(dM.conc);

	prevPowers = [zeros(8,1);dM.conc];
	prevPowers((end-7):end) = [];
	powerScatter = [];

	for powerN = 1:length(powerList)
		for powerNPrev = 1:length(powerList)

			ix = find((dM.conc == powerList(powerN)) &...
			 (prevPowers == powerList(powerNPrev))&...
			 (dM.dTraveled' > travelThreshold));
			ixBase = find(dM.conc == powerList(powerN)&...
				(dM.dTraveled' > travelThreshold))	;		
			powerMatrix(powerNPrev,powerN) = mean(dM.PI(ix));
			powerScatter(end+1,:) = [powerNPrev, mean(dM.PI(ix))];

		end
	end

	ix = find(isnan(powerMatrix));
	powerMatrix(ix) = -1;

	figure;
	image(powerMatrix,'CDataMapping','scaled');
	set(gca,'YDir','normal');
	xlabel('Power');
	ylabel('Prev Power');

	figure;
	scatter(powerScatter(:,1),powerScatter(:,2),'b.');


	for expN = 1:nExp

		ix = (expN - 1)*8 + [1:8];
		if (dM.leftEpoch(ix(1)) == 1) 
			LR = 'L';
		else
			LR = 'R';
		end
		ixx = find(dM.dTraveled(ix) < travelThreshold);
		ix(ixx) = [];
		disp(['LP: ', num2str(mean(dM.conc(ix)')),LR,...
			' # ',num2str(length(ix)),...
			' PI: ',num2str(mean(dM.PI(ix))),...
			' decPI: ',num2str(nanmean(dM.decPI(ix))),...
			' dT: ',num2str(mean(dM.dTraveled(ix)))]);


	end
