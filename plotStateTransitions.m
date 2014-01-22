function AllStateProbs = plotStateTransitions(expList, useLanes, useEpochs)

    exp = 0; % Ensure compiler knows exp is a variable loaded from the data file

    fontSize = 10;
    useColormap = fireAndIce();
	timeSampleInterval = .1;
    
    countThreshold = 10;     % Don't show probabilities based on fewer counts
    
    xBins = -25:1:25;
    NxBins = size(xBins,2);
    xSpan = xBins(end) - xBins(1);
    hSpacing = 10;
    hInterval = xSpan + hSpacing;
    
    for expNn = 1:size(expList,2)
        expN = expList(expNn);
        loadData(expN);
		[lEpoch, testPower] = leftOrRight(exp);
        laserPowers(expNn) = testPower;
    end
    powerList = unique(laserPowers);
    Npowers = size(powerList,2);
    pBinsL = (1:Npowers) - .5;
    pBinsR = (-1:-1:-Npowers) + .5;
    pSpan = pBinsL(end)-pBinsR(end);
    vSpacing = 3;  % Laser powers
    vInterval = pSpan + vSpacing;
       
    % Zero out the state counts       
    AllStateCounts = zeros(Npowers,2,3,NxBins,3); % Left
    
    for expNn = 1:size(expList,2)
		% disp(expNn);
        expN = expList(expNn);
        loadData(expN);
		[lEpoch, testPower] = leftOrRight(exp);
        powerN = dsearchn(powerList',testPower);

		for epochN = useEpochs

		    % Resample data
			bodyX = resample(exp.epoch(epochN).track.bodyX,0:timeSampleInterval:exp.epoch(epochN).track.bodyX.Time(end));
			headX = resample(exp.epoch(epochN).track.headX,0:timeSampleInterval:exp.epoch(epochN).track.headX.Time(end));
			tTrack = bodyX.Time;
	
		    
		    % Get the current left and right counts
		    StateCountsL = squeeze(AllStateCounts(powerN,1,:,:,:));
		    StateCountsR = squeeze(AllStateCounts(powerN,2,:,:,:));
		    
		    for laneN = useLanes
		        
				if (lEpoch == 1)
				    % Do left epoch
				    % Resample data
					xTrack = bodyX.Data(:,laneN) + headX.Data(:,laneN);
				    stateSequence = identifyStates(xTrack);
				    nextState = stateSequence(2:end);
				    thisState = stateSequence(1:(end-1));
				    for fromState = 1:3
				        for toState = 1:3
				            ix = find((thisState == fromState)&(nextState == toState));
				            xLocs = xTrack(ix);
				            xBinIndices = dsearchn(xBins',xLocs);
				            if (size(xBinIndices,1) > 0)
				                for xBinIndexN=1:size(xBinIndices,1)
				                    xBinIndex = xBinIndices(xBinIndexN);
				                    StateCountsL(fromState,xBinIndex,toState) =...
				                        StateCountsL(fromState,xBinIndex,toState)+1;
				                end
				            end
				        end
				    end
				end
            
				if (lEpoch == -1)
				    % Do right epoch
				    xTrack = bodyX.Data(:,laneN) + headX.Data(:,laneN);
				    stateSequence = identifyStates(xTrack);
				    nextState = stateSequence(2:end);
				    thisState = stateSequence(1:(end-1));
				    for fromState = 1:3
				        for toState = 1:3
				            ix = find((thisState == fromState)&(nextState == toState));
				            xLocs = xTrack(ix);
				            xBinIndices = dsearchn(xBins',xLocs);
				            if (size(xBinIndices,1) > 0)
				                for xBinIndexN=1:size(xBinIndices,1)
				                    xBinIndex = xBinIndices(xBinIndexN);
				                    StateCountsR(fromState,xBinIndex,toState) =...
				                        StateCountsR(fromState,xBinIndex,toState)+1;
				                end
				            end
				        end
				    end
				 end
			end
            
        end
        
        % Store the state counts back in the ASC
        AllStateCounts(powerN,1,:,:,:) = StateCountsL;
        AllStateCounts(powerN,2,:,:,:) = StateCountsR;
        
    end
    
    
    % Normalize counts
    for powerN = 1:Npowers    
        StateCountsL = squeeze(AllStateCounts(powerN,1,:,:,:));
        StateCountsR = squeeze(AllStateCounts(powerN,2,:,:,:));
        LStateProbs = []; RStateProbs = [];
        for fromState = 1:3
            for xBinN = 1:NxBins
                % Don't record probability if it's based on too few samples
                sumCounts = sum(StateCountsL(fromState,xBinN,:));
                if sumCounts > countThreshold
                    LStateProbs(fromState,xBinN,:) = ...
                        StateCountsL(fromState,xBinN,:)./sumCounts;
                else
                    LStateProbs(fromState,xBinN,:) = [NaN,NaN,NaN];
                end
                sumCounts = sum(StateCountsR(fromState,xBinN,:));
                if sumCounts > countThreshold
                    RStateProbs(fromState,xBinN,:) = ...
                        StateCountsR(fromState,xBinN,:)./sumCounts;
                else
                    RStateProbs(fromState,xBinN,:) = [NaN,NaN,NaN];
                end
            end
        end
        AllStateProbs(powerN,1,:,:,:) = LStateProbs;
        AllStateProbs(powerN,2,:,:,:) = RStateProbs;
    end
    
    % Subtract baseline from probabilities
    BaseProbs = (AllStateProbs(1,1,:,:,:) + AllStateProbs(1,2,:,:,:))./2;
    for powerN=1:Npowers
        DiffProbs(powerN,1,:,:,:) = AllStateProbs(powerN,1,:,:,:) - BaseProbs;
        DiffProbs(powerN,2,:,:,:) = AllStateProbs(powerN,2,:,:,:) - BaseProbs;
    end
    % Compute scaling factor.  Set Pdiff = probScale @ 1, -probScale @ 0.
    probScale = max(abs([max(DiffProbs(:)),min(DiffProbs(:))]));
    
    % Plot the images
    colormap(useColormap);
    for fromState = 1:3
        for toState = 1:3
            
            xOffset = (fromState - 1)*hInterval;
            yOffset = (3 - toState)*vInterval;
            
            % Scale images to cmap, plot them
            jimage(xOffset + xBins,yOffset + pBinsL,...
              squeeze(DiffProbs(:,1,fromState,:,toState))./probScale + .5,useColormap);
            hold on;
            jimage(xOffset + xBins,yOffset + pBinsR,...
              squeeze(DiffProbs(:,2,fromState,:,toState))./probScale + .5,useColormap);
        end
    end   

    
    % Horizontal lines
    for toState = 1:3
        for fromState = 1:3
        
            xOffset = (fromState - 1)*hInterval;
            yOffset = (3 - toState)*vInterval;
        
            line(xOffset + [xBins(1) - 1, xBins(end) + 1], (yOffset + 1)*[1 1],'Color',[1 1 1]);
            line(xOffset + [xBins(1) - 1, xBins(end) + 1], (yOffset + -1)*[1 1],'Color',[1 1 1]);
        end
    end
    
    
    % Laser triangles
    for toState = 1:3
    for fromState = 1:3
        
        xOffset = (fromState - 1)*hInterval;
        yOffset = (3 - toState)*vInterval;
              
        % Left triangle    
        p1x = xBins(1)-1; p2x = xBins(1) - 1; p3x = xBins(1) - 5;
        p1y = 1;          p2y = Npowers;      p3y = Npowers;
        
        fill(xOffset+[p1x p2x p3x],yOffset+[p1y p2y p3y],'r',...
            'EdgeColor','none','FaceColor','r','FaceAlpha',.3);
        % Right triangle
        p1x = xBins(end)+1; p2x = xBins(end) + 1; p3x = xBins(end) + 5;
        p1y = -1;            p2y = -Npowers;      p3y = -Npowers;
        
        fill(xOffset+[p1x p2x p3x],yOffset+[p1y p2y p3y],'r',...
            'EdgeColor','none','FaceColor','r','FaceAlpha',.3);

    end
    end
    
    
    % Draw xScale
    for fromState = 1:3
        toState = 3;
        
        xOffset = (fromState - 1)*hInterval;
        yOffset = (3 - toState)*vInterval;
        
        leftPoint = xOffset + xBins(1);
        midPoint    = xOffset + 0;
        rightPoint = xOffset + xBins(end);
        baseLine = yOffset - Npowers - 1;
        
        line([leftPoint-1 rightPoint+1],[baseLine baseLine],'Color','k');
        line([1 1].*leftPoint,[-1 1].*.5 + baseLine,'Color','k');
        text(leftPoint,-1*1 + baseLine,num2str(xBins(1)),...
            'HorizontalAlignment','center','VerticalAlignment','top',...
            'FontSize',fontSize);
        line([1 1].*midPoint,[-1 1].*.5 + baseLine,'Color','k');
        text(midPoint,-1*1 + baseLine,'0 mm',...
            'HorizontalAlignment','center','VerticalAlignment','top',...
            'FontSize',fontSize);
        line([1 1].*rightPoint,[-1 1].*.5 + baseLine,'Color','k');
        text(rightPoint,-1*1 + baseLine,num2str(xBins(end)),...
            'HorizontalAlignment','center','VerticalAlignment','top',...
            'FontSize',fontSize);

    end
    
    
        
    % Text annotation top
    for fromState = 1:3
        toState = 1;
        
        xOffset = (fromState - 1)*hInterval;
        yOffset = (3 - toState)*vInterval;
               
        topPoint = yOffset + Npowers+1;
        centPoint = xOffset;
        if fromState == 1
            text(centPoint,topPoint,'{\itP}{( ... | \leftarrow )}',...
            'HorizontalAlignment','center','VerticalAlignment','bottom',...
            'FontSize',fontSize,'FontName','arial');
        elseif fromState == 2
            text(centPoint,topPoint,'{\itP}{( ... | \oslash )}',...
            'HorizontalAlignment','center','VerticalAlignment','bottom',...
            'FontSize',fontSize,'FontName','arial');
        else
            text(centPoint,topPoint,'{\itP}{( ... | \rightarrow )}',...
            'HorizontalAlignment','center','VerticalAlignment','bottom',...
            'FontSize',fontSize,'FontName','arial');
        end
    end
    % Text annotation left
    for toState = 1:3
        fromState = 1;
        
        xOffset = (fromState - 1)*hInterval;
        yOffset = (3 - toState)*vInterval;
        
        midPoint = yOffset;
        leftPoint = xOffset + xBins(1) - 4;

        if toState == 1
            text(leftPoint,midPoint,'{\itP}{( \leftarrow | ... )}',...
            'HorizontalAlignment','right','VerticalAlignment','middle',...
            'FontSize',fontSize,'FontName','arial');
        elseif toState == 2
            text(leftPoint,midPoint,'{\itP}{( \oslash | ... )}',...
            'HorizontalAlignment','right','VerticalAlignment','middle',...
            'FontSize',fontSize,'FontName','arial');
        else
            text(leftPoint,midPoint,'{\itP}{( \rightarrow | ... )}',...
            'HorizontalAlignment','right','VerticalAlignment','middle',...
            'FontSize',fontSize,'FontName','arial');
        end
    end

    % Plot a colorbar
    useColormap = fireAndIce();
    Npowers = 8;
    fromState = 3;
    toState = 3;
    xOffset = (fromState - 1)*hInterval;
    yOffset = (3 - toState)*vInterval;
    
    yIdx = 1:101;
    Nidx = size(yIdx,2);
    cbar(1,:) = (yIdx-1)./(yIdx(end)-1);
    cbar(2,:) = (yIdx-1)./(yIdx(end)-1);
    xBars = xOffset+xBins(end)+8+[0,1];
    yBars = yOffset+[-Npowers:2*Npowers/(Nidx-1):Npowers];
    jimage(xBars,yBars,cbar',useColormap);
    
    text(xOffset + xBins(end) + 10, yOffset+Npowers, num2str(probScale,2),...
            'HorizontalAlignment','left','VerticalAlignment','middle',...
            'FontSize',fontSize);
    text(xOffset + xBins(end) + 10, yOffset, '0',...
            'HorizontalAlignment','left','VerticalAlignment','middle',...
            'FontSize',fontSize);
    text(xOffset + xBins(end) + 10, yOffset-Npowers, num2str(-probScale,2),...
            'HorizontalAlignment','left','VerticalAlignment','middle',...
            'FontSize',fontSize);    
    
    
    % Clean up plot
    axis tight;
    set(gca,'Visible','off');
    set(gcf,'Color','w');
	freezeColors();
    
    
    

    
 
                            
                            
                            
                            
                            
                            
