function laserPlotDensityStates(expList,useEpochs, lanesToUse, axesArray)

fontSize = 6;
% lanesToUse = [1:8];

xBins = -25:1:25;
NxBins = size(xBins,2);
xSpan = xBins(end)-xBins(1);
hSpacing = 15;
hInterval = xSpan + hSpacing;

tBins = 0:10:6*60;
NtBins = size(tBins,2);
tSpan = tBins(end) - tBins(1);
vSpacing = 80;
vInterval = tSpan + vSpacing;

statesList = [1,2,3];
Nplots = size(statesList,2);
stateDescriptions = {'Walking L','Stopped','Walking R'};

for expNn = 1:size(expList,2)
    expN = expList(expNn);
    loadData(expN);
    laserPowers(expNn) = exp.laserPower;
end
powerList = unique(laserPowers);
Npowers = size(powerList,2);

Ntot = zeros(Nplots, Npowers, 2, NxBins);

for expNn = 1:size(expList,2)
    expN = expList(expNn);
    loadData(expN);
    powerN = dsearchn(powerList',exp.laserPower);
    scaledExp = scaleTracks(exp);
    for fly=lanesToUse
        for epochNn = 1:2
            epochN = useEpochs(epochNn);
            xTrack = scaledExp.epoch(epochN).scaledTrack(:,1,fly);
            stateSequence = identifyStates(xTrack);
            for stateN = statesList
                ix = find(stateSequence == stateN);
                N(1,1,1,:) = hist(xTrack(ix),xBins);
                Ntot(stateN,powerN,epochNn,:) = Ntot(stateN,powerN,epochNn,:) + N;
            end
        end
    end
end


maxDensity = max(Ntot(:));
for stateN = statesList
    axes(axesArray(stateN));
    for powerN = 1:Npowers
        plotColor = [powerN/Npowers 0 0];
        plot(xBins, -squeeze(Ntot(stateN,powerN,1,:))./maxDensity,'Color',plotColor);
        hold on;
        plot(xBins, squeeze(Ntot(stateN,powerN,2,:))./maxDensity,'Color',plotColor);
    end
    title(stateDescriptions{stateN},'FontSize',fontSize);
    xlim([-25 25]);
    xlabel('X (mm)','FontSize',fontSize);
end
axes(axesArray(1));
ylabel('P','FontSize',fontSize);

ylims1 = ylim();
axes(axesArray(3));
ylims3 = ylim();
allLims = [ylims1,ylims3];
maxLims13 = max(abs(allLims));


    
    axes(axesArray(1));
    maxLims = maxLims13*1.1;
    ylim([-maxLims maxLims]);
    ylims = ylim();
    topBarBottom = ylims(2) - (ylims(2)-ylims(1))/20;
    bottomBarTop = ylims(1) + (ylims(2)-ylims(1))/20;
    fill([-25 0 0 -25],[ylims(1) ylims(1) bottomBarTop bottomBarTop],'r',...
        'EdgeColor','none','FaceColor','r','FaceAlpha',.3);
    fill([25 0 0 25],[ylims(end) ylims(end) topBarBottom topBarBottom],'r',...
        'EdgeColor','none','FaceColor','r','FaceAlpha',.3);
    line([-25 25],[0 0],'Color','k','LineStyle','--');
    
    set(gca,'YTickMode','manual');
    set(gca,'YTick',[-maxLims,0,maxLims]);
    set(gca,'YTickLabel',[maxLims,0,maxLims]);
    % set(gca,'YTickLabel',abs(yTicks));
    set(gca,'FontSize',fontSize);    
    set(gca,'ZTick',[]);
    
    axes(axesArray(2));
    maxLims = max(abs(ylim()));
    ylim([-maxLims maxLims]);
    ylims = ylim();
    topBarBottom = ylims(2) - (ylims(2)-ylims(1))/20;
    bottomBarTop = ylims(1) + (ylims(2)-ylims(1))/20;
    fill([-25 0 0 -25],[ylims(1) ylims(1) bottomBarTop bottomBarTop],'r',...
        'EdgeColor','none','FaceColor','r','FaceAlpha',.3);
    fill([25 0 0 25],[ylims(end) ylims(end) topBarBottom topBarBottom],'r',...
        'EdgeColor','none','FaceColor','r','FaceAlpha',.3);
    line([-25 25],[0 0],'Color','k','LineStyle','--');
    
    set(gca,'YTickMode','manual');
    set(gca,'YTick',[-maxLims,0,maxLims]);
    set(gca,'YTickLabel',[maxLims,0,maxLims]);
    % set(gca,'YTickLabel',abs(yTicks));
    set(gca,'FontSize',fontSize);    
    set(gca,'ZTick',[]);
    
    axes(axesArray(3));
    maxLims = maxLims13*1.1;
    ylim([-maxLims maxLims]);
    ylims = ylim();
    topBarBottom = ylims(2) - (ylims(2)-ylims(1))/20;
    bottomBarTop = ylims(1) + (ylims(2)-ylims(1))/20;
    fill([-25 0 0 -25],[ylims(1) ylims(1) bottomBarTop bottomBarTop],'r',...
        'EdgeColor','none','FaceColor','r','FaceAlpha',.3);
    fill([25 0 0 25],[ylims(end) ylims(end) topBarBottom topBarBottom],'r',...
        'EdgeColor','none','FaceColor','r','FaceAlpha',.3);
    line([-25 25],[0 0],'Color','k','LineStyle','--');
    
    set(gca,'YTickMode','manual');
    set(gca,'YTick',[-maxLims,0,maxLims]);
    set(gca,'YTickLabel',[maxLims,0,maxLims]);
    % set(gca,'YTickLabel',abs(yTicks));
    set(gca,'FontSize',fontSize);    
    set(gca,'ZTick',[]);
    






