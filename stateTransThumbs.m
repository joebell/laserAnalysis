function stateTransThumbs(ASC)

    exp = 0; % Ensure compiler knows exp is a variable loaded from the data file

	cLim = .15;

	subplot(3,6,1);
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
		subplot(3,6,(toState - 1)*6 + fromState + 3);
		image(squeeze(allOffProbs(:,:,toState,fromState) - meanVal),'CDataMapping','scaled');
		set(gca,'YDir','reverse','XTick',[],'YTick',[]);
		caxis([-1 1].*cLim);
		title(' '); xlabel(' '); ylabel({' ',' '});
		freezeColors();

		% Plot Laser Ons on left
		subplot(3,6,(toState - 1)*6 + fromState);	
		image(squeeze(allOnProbs(:,:,toState,fromState) - meanVal),'CDataMapping','scaled');
		set(gca,'YDir','reverse','XTick',[],'YTick',[],'XColor','r','YColor','r','LineWidth',1);
		caxis([-1 1].*cLim);
		title(' '); xlabel(' '); ylabel({' ',' '});
		freezeColors();
	end
	end

	subplot(3,6,13);
	xlabel(['{\color{black}Power \rightarrow}']);
	ylabel({'{\color{black}\leftarrow Time  }','{\color{black}{\itP}{( \rightarrow )}}'});
	subplot(3,6,1);
	title('{\itP}{(...| \leftarrow, L-on)}');
	subplot(3,6,2);
	title('{\itP}{(...| \oslash, L-on)}');
	subplot(3,6,3);
	title('{\itP}{(...| \rightarrow, L-on)}');
	subplot(3,6,4);
	title('{\itP}{(...| \leftarrow, L-off)}');
	subplot(3,6,5);
	title('{\itP}{(...| \oslash, L-off)}');
	subplot(3,6,6);
	title('{\itP}{(...| \rightarrow, L-off)}');
	
	subplot(3,6,1);
	ylabel({' ','{\color{black}{\itP}{( \leftarrow )}}'});
	subplot(3,6,7);
	ylabel({' ','{\color{black}{\itP}{( \oslash )}}'});

