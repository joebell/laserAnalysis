function batchContingentMiesenbock(batchList)

	timeSampleInterval = .1;
	epochList = [2:2:16];

	for epochNn = 1:length(epochList)
		PIList{epochNn} = [];
		decPIList{epochNn} = [];
	end


	for fileNn = 1:length(batchList)

		loadData(batchList(fileNn));

		for epochNn = 1:length(epochList)
	
			epochN = epochList(epochNn);
			bodyXseg = resample(exp.epoch(epochN).track.bodyX,0:timeSampleInterval:exp.epoch(epochN).track.bodyX.Time(end));
			headXseg = resample(exp.epoch(epochN).track.headX,0:timeSampleInterval:exp.epoch(epochN).track.headX.Time(end));
			
			for flyN = 1:8
				seg = bodyXseg.data(:,flyN) + headXseg.data(:,flyN);
				PI = (nnz(seg > 0) - nnz(seg < 0))./length(seg);
				[numL,numR] = computeDecPI(seg);
				if (numR + numL > 0)
					decPI = (numR - numL)./(numR + numL);
				else
					decPI = 0;
				end
				if (mod(epochN,4) > 0)
					PI = -PI;
					decPI = -decPI;
				end

				alist = PIList{epochNn};
				blist = decPIList{epochNn};
				PIList{epochNn} = [alist,PI];
				decPIList{epochNn} = [blist,decPI];

			end
		end

	end

	figure();
	subplot(2,1,1);
	for epochNn = 1:length(epochList)
		list = PIList{epochNn};
		if ((epochNn < 3) || (epochNn > 6))
			scatter(epochNn+rand(length(list),1)./4,list,'.b'); hold on;
		else
			scatter(epochNn+rand(length(list),1)./4,list,'.g'); hold on;
		end
		meanPI(epochNn) = mean(list);
	end
	plot(meanPI);
	plot([.5 8.5],[0 0],'k'); xlim([.5 8.5]);
	ylabel('PI');

	subplot(2,1,2);
	for epochNn = 1:length(epochList)
		list = decPIList{epochNn};
		if ((epochNn < 3) || (epochNn > 6))
			scatter(epochNn+rand(length(list),1)./4,list,'.b'); hold on;
		else
			scatter(epochNn+rand(length(list),1)./4,list,'.g'); hold on;
		end
		meanDecPI(epochNn) = mean(list);
	end
	plot(meanDecPI);
	plot([.5 8.5],[0 0],'k'); xlim([.5 8.5]);
	ylabel('Dec PI');

	



