function statePIPredictions(ASC, dM, epochList, laneList)

	Nchunks = size(ASC,6);
	Npowers = size(ASC,1);

	% Plot the real data
	laserPowerSeriesFlex(dM,laneList,'PI',5,'k',false,true,false,false,false,false);
	laserPowers = unique(dM.conc);

	% Predict PI, plot on top
    chunkWidth = .75;
    for powerN = 1:Npowers
		for timeChunk = 1:Nchunks
			[laserOffProb,laserOnProb] = getTransitionModel(ASC,timeChunk,powerN);
            [PImean, PIstd] = predictPI(laserOffProb,laserOnProb);
            PImeans(powerN,timeChunk) = PImean;
            PIstds(powerN,timeChunk) = PIstd;
        end
        xScale = laserPowers(end)/(Npowers-1);
        xVals = (powerN-1)*xScale + ([1:Nchunks] - Nchunks/2)/Nchunks*chunkWidth*xScale;
        plot(xVals,PImeans(powerN,:),'bo-'); hold on;
    end
	ylabel('{\color{black}PI    }{\color{blue}Predicted PI}');

