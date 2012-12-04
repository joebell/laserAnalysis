function dataMatrix = makeDataMatrix(fileList) 

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
    exp.comment;
    scaledExp = scaleTracks(exp);
    
    leftEpochs = scaledExp.odorLeftEpochs;
    rightEpochs = scaledExp.odorRightEpochs;
    noneEpochs = scaledExp.noOdorEpochs;
    
    odorScores = [];
    odorDtraveled = [];
    for fly=1:8
        for epochN = leftEpochs
            scaledSeg = scaledExp.epoch(epochN).scaledTrack(:,1,fly);
            signSeg = sign(scaledSeg);
            corrects = nnz(find(signSeg == 1));
            incorrects = nnz(find(signSeg ~= 1));
            PI = -(corrects - incorrects)/(corrects + incorrects);
            trackDiffs = diff(scaledSeg);
            distanceTraveled = sum(abs(trackDiffs));
                        
            dataMatrix.fileN(end+1) = fileNum;
            dataMatrix.odor{end+1} = exp.odor;
            dataMatrix.conc(end+1,:) = exp.odorConc(:);
            dataMatrix.epochN(end+1) = epochN;
            dataMatrix.leftEpoch(end+1) = 1;
            dataMatrix.lane(end+1) = fly;
            dataMatrix.laneOdd(end+1) = (fly/2 ~= round(fly/2));
            dataMatrix.PI(end+1) = PI;
            dataMatrix.dTraveled(end+1) = distanceTraveled;
            dataMatrix.isOdor(end+1) = true;
            [numL,numR] = computeDecPI(scaledSeg);
            if (numL + numR) > 0
                dataMatrix.decPI(end+1) = (numL - numR)/(numL + numR);          
                dataMatrix.numDec(end+1) = numL + numR;   
            else
                dataMatrix.decPI(end+1) = NaN;          
                dataMatrix.numDec(end+1) = 0; 
            end
            
        end
        for epochN = rightEpochs
            scaledSeg = scaledExp.epoch(epochN).scaledTrack(:,1,fly);
            signSeg = sign(scaledSeg);
            corrects = nnz(find(signSeg == 1));
            incorrects = nnz(find(signSeg ~= 1));
            PI = (corrects - incorrects)/(corrects + incorrects);
            trackDiffs = diff(scaledSeg);
            distanceTraveled = sum(abs(trackDiffs));
            
            dataMatrix.fileN(end+1) = fileNum;
            dataMatrix.odor{end+1} = exp.odor;
            dataMatrix.conc(end+1,:) = exp.odorConc(:);
            dataMatrix.epochN(end+1) = epochN;
            dataMatrix.leftEpoch(end+1) = -1;
            dataMatrix.lane(end+1) = fly;
            dataMatrix.laneOdd(end+1) = (fly/2 ~= round(fly/2));
            dataMatrix.PI(end+1) = PI;
            dataMatrix.dTraveled(end+1) = distanceTraveled;
            dataMatrix.isOdor(end+1) = true;
            [numL,numR] = computeDecPI(scaledSeg);
            if (numL + numR) > 0
                dataMatrix.decPI(end+1) = (numR - numL)/(numL + numR);          
                dataMatrix.numDec(end+1) = numL + numR;   
            else
                dataMatrix.decPI(end+1) = NaN;          
                dataMatrix.numDec(end+1) = 0; 
            end
        end
        for epochN = noneEpochs
            scaledSeg = scaledExp.epoch(epochN).scaledTrack(:,1,fly);
            signSeg = sign(scaledSeg);
            corrects = nnz(find(signSeg == 1));
            incorrects = nnz(find(signSeg ~= 1));
            PI = (corrects - incorrects)/(corrects + incorrects);
            trackDiffs = diff(scaledSeg);
            distanceTraveled = sum(abs(trackDiffs));
            
            dataMatrix.fileN(end+1) = fileNum;
            dataMatrix.odor{end+1} = 'none';
            dataMatrix.conc(end+1,:) = 0;
            dataMatrix.epochN(end+1) = epochN;
            dataMatrix.leftEpoch(end+1) = 0;
            dataMatrix.lane(end+1) = fly;
            dataMatrix.laneOdd(end+1) = (fly/2 ~= round(fly/2));
            dataMatrix.PI(end+1) = PI;
            dataMatrix.dTraveled(end+1) = distanceTraveled;
            dataMatrix.isOdor(end+1) = false;
            [numL,numR] = computeDecPI(scaledSeg);
            if (numL + numR) > 0
                dataMatrix.decPI(end+1) = (numL - numR)/(numL + numR);          
                dataMatrix.numDec(end+1) = numL + numR;   
            else
                dataMatrix.decPI(end+1) = NaN;          
                dataMatrix.numDec(end+1) = 0; 
            end
        end
    end
end     


        
        