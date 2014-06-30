function dataMatrix = makeDataMatrix(fileList, useEpochs) 

resamplePeriod = .1; % Resample data on this interval (sec)

dataMatrix.fileN = [];
dataMatrix.odor = {};
dataMatrix.conc = [];
dataMatrix.epochN = [];
dataMatrix.leftEpoch = [];
dataMatrix.lane = [];
dataMatrix.laneOdd = [];
dataMatrix.PI = [];
dataMatrix.dTraveled = [];
dataMatrix.isOdor = [];
dataMatrix.decPI = [];          % PI from decision count
dataMatrix.numDec = [];         % Number of decisions made

orderList = 1:size(fileList,2);
for order = orderList
    fileNum = fileList(order);
    loadData(fileNum);
    % exp.comment;
    
	epochsToUse = useEpochs;
    % epochsToUse  = [exp.leftEpochs,exp.rightEpochs];
	% epochsToUse = exp.trainingEpochs;
    % noneEpochs = exp.nullEpochs;
    
    odorScores = [];
    odorDtraveled = [];


	for epochN = epochsToUse

		% Resample the timeseries objects, add bodyX + headX
		epochLength = exp.epoch(epochN).track.bodyX.Time(end);
		newTimeVector = 0:resamplePeriod:epochLength;
		bodyX = resample(exp.epoch(epochN).track.bodyX,newTimeVector);
		headX = resample(exp.epoch(epochN).track.headX,newTimeVector);
		scaledSegs = bodyX.Data + headX.Data;

		for fly=1:size(scaledSegs,2)
		    
				scaledSeg = scaledSegs(:,fly);

				% 
				signSeg = sign(scaledSeg);
				rightSides = nnz(find(signSeg == 1));
				leftSides = nnz(find(signSeg ~= 1));
				[lEpoch, testConc] = leftOrRight(exp);
				if (lEpoch == 1)
					PI = (leftSides - rightSides)/(leftSides + rightSides);
				elseif (lEpoch == -1)
					PI =  (rightSides - leftSides)/(leftSides + rightSides);
				end

		        trackDiffs = diff(scaledSeg);
		        distanceTraveled = sum(abs(trackDiffs));
	                    
		        dataMatrix.fileN(end+1) = fileNum;
		        dataMatrix.odor{end+1} = exp.odor;
		        dataMatrix.conc(end+1,1) = testConc;
		        dataMatrix.epochN(end+1) = epochN;
		        dataMatrix.leftEpoch(end+1) = lEpoch;
		        dataMatrix.lane(end+1) = fly;
		        dataMatrix.laneOdd(end+1) = mod(fly,2);
		        dataMatrix.PI(end+1) = PI;
		        dataMatrix.dTraveled(end+1) = distanceTraveled;
		        dataMatrix.isOdor(end+1) = true;
		        [numL,numR] = computeDecPI(scaledSeg);
		        if (numL + numR) > 0
					if (lEpoch == 1)
		            	dataMatrix.decPI(end+1) = (numL - numR)/(numL + numR); 
					elseif (lEpoch == -1)
						dataMatrix.decPI(end+1) = (numR - numL)/(numL + numR); 
					end         
		            dataMatrix.numDec(end+1) = numL + numR;   
		        else
		            dataMatrix.decPI(end+1) = NaN;          
		            dataMatrix.numDec(end+1) = 0; 
		        end
            
        end
     end
end     


        
        
