function ASC = getStateTransitionCounts(expList, useLanes, useEpochs)


	timeSampleInterval = .1;
    
    xBins = -25:1:25;
    NxBins = size(xBins,2);
    xSpan = xBins(end) - xBins(1);
    
    for expNn = 1:size(expList,2)
        expN = expList(expNn);
        loadData(expN);
        laserPowers(expNn) = max(exp.laserParams.*exp.laserFilter);
    end
    powerList = unique(laserPowers);
    Npowers = size(powerList,2);

	nPerPower = zeros(Npowers,1);
	nPerChunk = 2;
	maxChunks = ceil(length(expList)/(Npowers*nPerChunk));
       
    % Zero out the state counts   
    % [PowerN, [LaserL|LaserR], [From],[X],[To],[TimeChunk]    
    ASC = zeros(Npowers,2,3,NxBins,3,maxChunks); % Left
    
    for expNn = 1:size(expList,2)

        expN = expList(expNn);
        loadData(expN);

        powerN = dsearchn(powerList',max(exp.laserParams.*exp.laserFilter));
		if length(exp.laserParams) <= 2
			if (exp.laserParams(1) > exp.laserParams(2))
				lEpoch = 1;
			elseif (exp.laserParams(1) < exp.laserParams(2))
				lEpoch = 2;
			elseif (exp.laserParams(1) == exp.laserParams(2))
				lEpoch = randi(2);
			end
		else
			if (exp.laserParams(3) == 1)
				lEpoch = 1;
			elseif (exp.laserParams(4) == 1)
				lEpoch = 2;
			end
		end

		nPerPower(powerN) = nPerPower(powerN) + 1;
		chunkN = ceil(nPerPower(powerN)/nPerChunk);

		for epochN = useEpochs

		    % Resample data
			bodyX = resample(exp.epoch(epochN).track.bodyX,0:timeSampleInterval:exp.epoch(epochN).track.bodyX.Time(end));
			headX = resample(exp.epoch(epochN).track.headX,0:timeSampleInterval:exp.epoch(epochN).track.headX.Time(end));
			tTrack = bodyX.Time;
			    
		    for laneN = useLanes
		        
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
				                    ASC(powerN,lEpoch,fromState,xBinIndex,toState,chunkN) = ...
 										ASC(powerN,lEpoch,fromState,xBinIndex,toState,chunkN) + 1;
				                end
				            end
				        end
				    end
            
				
			 end     
        end
    end
    
    
 
    

    
    
    

    
 
                            
                            
                            
                            
                            
                            
