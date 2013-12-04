function laserMasterPlot5(fileList, useEpochs, useLanes)

	cLim = .15;

	subplot(6,6,1);
	ASC = getStateTransitionCounts(fileList,useLanes,useEpochs);
	Nchunks = size(ASC,6);
	Npowers = size(ASC,1);

	allProbs = [];
	for chunkN = 1:Nchunks
	for powerN = 1:Npowers
		[offProb,onProb] = getTransitionModel(ASC,chunkN,powerN);
		for fromState = 1:3
		for toState = 1:3 
			allOffProbs(chunkN,powerN,toState,fromState) = offProb(toState,fromState);
			allOnProbs( chunkN,powerN,toState,fromState) =  onProb(toState,fromState);
		end
		end
	end
	end

	colormap(fireAndIce);
	for fromState = 1:3
	for toState = 1:3
		meanVal = mean(mean([squeeze(allOffProbs(:,:,toState,fromState)),...
				     squeeze( allOnProbs(:,:,toState,fromState))]));
		% Plot Laser Offs on RIGHT
		subplot(6,6,(toState - 1)*6 + fromState + 3);
		image(squeeze(allOffProbs(:,:,toState,fromState) - meanVal),'CDataMapping','scaled');
		set(gca,'YDir','reverse','XTick',[],'YTick',[],'XColor','r','YColor','r','LineWidth',3);
		caxis([-1 1].*cLim);
		axis off;
		% Plot Laser Ons on left
		subplot(6,6,(toState - 1)*6 + fromState);	
		image(squeeze(allOnProbs(:,:,toState,fromState) - meanVal),'CDataMapping','scaled');
		set(gca,'YDir','reverse','XTick',[],'YTick',[],'XColor','r','YColor','r','LineWidth',3);
		caxis([-1 1].*cLim);
	end
	end

	subplot(6,6,13);
	xlabel(['{Power \rightarrow}']);
	ylabel({'{\leftarrow Time  }','{\itP}{( \rightarrow )}'});
	subplot(6,6,1);
	title('{\itP}{(...| \leftarrow, L-on)}');
	subplot(6,6,2);
	title('{\itP}{(...| \oslash, L-on)}');
	subplot(6,6,3);
	title('{\itP}{(...| \rightarrow, L-on)}');
	subplot(6,6,4);
	title('{\itP}{(...| \leftarrow, L-off)}');
	subplot(6,6,5);
	title('{\itP}{(...| \oslash, L-off)}');
	subplot(6,6,6);
	title('{\itP}{(...| \rightarrow, L-off)}');
	
	subplot(6,6,1);
	ylabel({' ','{\itP}{( \leftarrow )}'});
	subplot(6,6,7);
	ylabel({' ','{\itP}{( \oslash )}'});

	subplot(6,6,19:36);
	dM = makeDataMatrix(fileList,useEpochs);
	laserPowerSeriesFlex(dM,useLanes,'PI',5,'k',false,true,false,false,false,false);
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

