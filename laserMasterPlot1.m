function laserMasterPlot1(plotTitle, expList, useEpochs,useLanes)

    dM = makeDataMatrix(expList);
    
    nRows = 8;
    nCols = 3;

%% Plot PI    
    
rowN = 1;
colN = 1;
subplot(nRows,nCols,(rowN-1)*nCols + colN);
% function laserPowerSeriesFlex(dM, useLanes, plotQuantity, travelThreshold, scatters, timeTrend, laneAvg, grandMean, LR)
    laserPowerSeriesFlex(dM,useLanes,'PI',20,'b',false,false,false,true,true,true);

    
rowN = 1;
colN = 2;
subplot(nRows,nCols,(rowN-1)*nCols + colN);
% function laserPowerSeriesFlex(dM, plotQuantity, travelThreshold, scatters, timeTrend, laneAvg, grandMean, LR)
    laserPowerSeriesFlex(dM,useLanes,'PI',20,'k',false,true,false,false,false,false);

% Move title up
h = title(plotTitle,'HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',10);
Pos = get(h,'Position');
set(h,'Position',[Pos(1),Pos(2)+.3,Pos(3)]);
    
rowN = 1;
colN = 3;
subplot(nRows,nCols,(rowN-1)*nCols + colN);
% function laserPowerSeriesFlex(dM, plotQuantity, travelThreshold, scatters, timeTrend, laneAvg, grandMean, LR)
    laserPowerSeriesFlex(dM,useLanes,'PI',20,'b',false,false,true,false,false,false);

    
    
%% Plot Decision based PI's     

rowN = 2;
colN = 1;
subplot(nRows,nCols,(rowN-1)*nCols + colN);
% function laserPowerSeriesFlex(dM, plotQuantity, travelThreshold, scatters, timeTrend, laneAvg, grandMean, LR)
    laserPowerSeriesFlex(dM,useLanes,'decPI',20,'b',false,false,false,true,true,true);

   
rowN = 2;
colN = 2;
subplot(nRows,nCols,(rowN-1)*nCols + colN);
% function laserPowerSeriesFlex(dM, plotQuantity, travelThreshold, scatters, timeTrend, laneAvg, grandMean, LR)
    laserPowerSeriesFlex(dM,useLanes,'decPI',20,'k',false,true,false,false,false,false);
    
rowN = 2;
colN = 3;
subplot(nRows,nCols,(rowN-1)*nCols + colN);
% function laserPowerSeriesFlex(dM, plotQuantity, travelThreshold, scatters, timeTrend, laneAvg, grandMean, LR)
    laserPowerSeriesFlex(dM,useLanes,'decPI',20,'b',false,false,true,false,false,false);    
    

%% Plot Number of decisions

rowN = 3;
colN = 1;
subplot(nRows,nCols,(rowN-1)*nCols + colN);
% function laserPowerSeriesFlex(dM, plotQuantity, travelThreshold, scatters, timeTrend, laneAvg, grandMean, LR)
    laserPowerSeriesFlex(dM,useLanes,'numDec',20,'b',false,false,false,true,true,true);

   
rowN = 3;
colN = 2;
subplot(nRows,nCols,(rowN-1)*nCols + colN);
% function laserPowerSeriesFlex(dM, plotQuantity, travelThreshold, scatters, timeTrend, laneAvg, grandMean, LR)
    laserPowerSeriesFlex(dM,useLanes,'numDec',20,'k',false,true,false,false,false,false);
    
rowN = 3;
colN = 3;
subplot(nRows,nCols,(rowN-1)*nCols + colN);
% function laserPowerSeriesFlex(dM, plotQuantity, travelThreshold, scatters, timeTrend, laneAvg, grandMean, LR)
    laserPowerSeriesFlex(dM,useLanes,'numDec',20,'b',false,false,true,false,false,false);      
    
    
    
%% Plot Distances    
    
rowN = 4;
colN = 1;
subplot(nRows,nCols,(rowN-1)*nCols + colN);
% function laserPowerSeriesFlex(dM, plotQuantity, travelThreshold, scatters, timeTrend, laneAvg, grandMean, LR)
    laserPowerSeriesFlex(dM,useLanes,'dTraveled',20,'b',false,false,false,true,true,true);
    
rowN = 4;
colN = 2;
subplot(nRows,nCols,(rowN-1)*nCols + colN);
% function laserPowerSeriesFlex(dM, plotQuantity, travelThreshold, scatters, timeTrend, laneAvg, grandMean, LR)
    laserPowerSeriesFlex(dM,useLanes,'dTraveled',20,'k',false,true,false,false,false,false);
    
rowN = 4;
colN = 3;
subplot(nRows,nCols,(rowN-1)*nCols + colN);
% function laserPowerSeriesFlex(dM, plotQuantity, travelThreshold, scatters, timeTrend, laneAvg, grandMean, LR)
    laserPowerSeriesFlex(dM,useLanes,'dTraveled',20,'b',false,false,true,false,false,false);
 
rowN = 5;
colN = 1:3;
subplot(nRows,nCols,(rowN-1)*nCols + colN);
laserPlotDensityMod(expList, useLanes);

rowN = 6;
colN = 1:3;
axesArray = [subplot(nRows,nCols,(rowN-1)*nCols + 1),...
             subplot(nRows,nCols,(rowN-1)*nCols + 2),...
             subplot(nRows,nCols,(rowN-1)*nCols + 3)];
laserPlotDensityStates(expList, useEpochs, useLanes, axesArray);

% State Transitions
rowN = 7:8;
colN = 1;
subplot(nRows,nCols,[(rowN(1)-1)*nCols + colN,(rowN(2)-1)*nCols + colN]);
AllStateProbs = plotStateTransitions(expList, useLanes);
P = get(gca,'OuterPosition');
set(gca,'OuterPosition',P .* [1 1 1.15 .95]);


% State transition baseline
rowN = 7:8;
colN = 2;
subplot(nRows,nCols,[(rowN(1)-1)*nCols + colN,(rowN(2)-1)*nCols + colN]);
plotStateTransitionsBL(AllStateProbs)

% State transition baseline
rowN = 7:8;
colN = 3;
subplot(nRows,nCols,[(rowN(1)-1)*nCols + colN,(rowN(2)-1)*nCols + colN]);
laserSpeedHistogram(expList, useEpochs, useLanes)






    
