function laserMasterPlot2(plotTitle, expList, useEpochs, useLanes)

    dM = makeDataMatrix(expList);
    
    nRows = 7;
    nCols = 3;

%% Velocity Autocorrelation  
rowN = 1:2;
colN = 1:2;
subplot(nRows,nCols,[(rowN(1)-1)*nCols + colN,(rowN(2)-1)*nCols + colN]);
plotVelocityAutocorrelation(expList, useEpochs, useLanes);
% Adjust bottom to prevent label collision
P = get(gca,'OuterPosition');
set(gca,'OuterPosition',P + [0 .07 0 -.07]);

%% Move title up
h = title(plotTitle,'HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',10);
Pos = get(h,'Position');
set(h,'Position',[7.5, Pos(2)+.05,Pos(3)]);

    
%% Mutual Information
rowN = 3:4;
colN = 1:2;
subplot(nRows,nCols,[(rowN(1)-1)*nCols + colN,(rowN(2)-1)*nCols + colN]);
plotMutualInformation(expList, useEpochs, useLanes);
% Adjust bottom to prevent label collision
P = get(gca,'OuterPosition');
set(gca,'OuterPosition',P+[0 .07 0 -.07]);

%% State lifetimes
rowN = 1:4;
colN = 3;
subplot(nRows,nCols,[(rowN(1)-1)*nCols + colN,(rowN(2)-1)*nCols + colN,(rowN(3)-1)*nCols + colN,(rowN(4)-1)*nCols + colN]);
plotStateLifetimes(expList, useEpochs, useLanes);
% Adjust bottom to prevent label collision
P = get(gca,'OuterPosition');
set(gca,'OuterPosition',P+[0 .07 0 -.07]);


%% Conditional probabilities over time
rowN = 5:7;
colN = 1:3;
for row = rowN
    for col = colN
        axesArray(col,row-rowN(1)+1) = subplot(nRows,nCols, (row-1)*nCols + col);
    end
end
plotCondProbTimes(expList,axesArray,useEpochs,useLanes);


