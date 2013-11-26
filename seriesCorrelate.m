function GM = seriesCorrelate()

	travelThreshold = 5;

	expList = { '131010-152126-',...
				'131009-142932-',...
				'131009-121221-',...
				'131008-120759-',...
				'131007-174317-',...
				'131007-154403-',...
				'131007-114536-',...
				'131002-124259-',...
				'131001-182140-',...
				'131001-160234-',...
				'130930-164924-',...
				'130927-140058-',...
				'130926-'};

GM = [];

for expN = 1:length(expList)

	PS1 = 0;
	PS2 = 0;
	PS3 = 0;
	PS1LR = 0;
	PS2LR = 0;
	PS3LR = 0;
	cumConc = 0;
	cumExp = zeros(1,8);

	dM = makeDataMatrix(returnFileList(expList{expN}),2);
	nStim = length(dM.fileN)/8;
	for stimN = 1:min(nStim,2*16)

		ix = (stimN - 1)*8 + [1:8];
		if (dM.leftEpoch(ix(1)) == 1) 
			LR = 1;
		else
			LR = -1;
		end
		
		% Remove tracks under threshold
		ixx = find(dM.dTraveled(ix) < travelThreshold);
		ixwhole = ix;
		ix(ixx) = [];
		
		PI = nanmean(dM.PI(ix));
		conc = dM.conc(ix(1));
		
		GM(end+1,:) = [PI,stimN,conc, LR, PS1,PS2,PS3,PS1LR,PS2LR,PS3LR, cumConc, mean(cumExp)];
		
		PS3 = PS2;
		PS2 = PS1;
		PS1 = conc;

		PS3LR = PS2LR;
		PS2LR = PS1LR;
		PS1LR = LR;

		cumConc = cumConc + conc;
		cumExp = cumExp + (dM.PI(ixwhole)./2+.5).*conc;
		
	end

end
				
