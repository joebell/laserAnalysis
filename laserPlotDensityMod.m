function laserPlotDensityMod(expList,lanesToUse)

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

statesList = {[1,2,3],1,2,3};
%Nplots = size(statesList,2);
Nplots = 1; % Only plot All States plot
stateMultiplierList = [1,1,1,1]; % For scaling state histograms
stateDescriptions = {'All States','Walking L','Stopped','Walking R'};

for expNn = 1:size(expList,2)
    expN = expList(expNn);
    loadData(expN);
    laserPowers(expNn) = exp.laserPower;
end
powerList = unique(laserPowers);
Npowers = size(powerList,2);

Ntot = zeros(Nplots, Npowers, NtBins, NxBins);

for expNn = 1:size(expList,2)
    expN = expList(expNn);
    loadData(expN);
    powerN = dsearchn(powerList',exp.laserPower);
    scaledExp = scaleTracks(exp);
    for fly=lanesToUse
        xTrack = scaledExp.wholeScaledTrack(:,1,fly);
        stateSequence = identifyStates(xTrack);
        tTrack = (1:size(xTrack,1))'.*exp.acquisitionRate;
        for plotN = 1:Nplots
            states = statesList{plotN};
            stateMultiplier = stateMultiplierList(plotN);
            targetStates = zeros(size(stateSequence,1),1);
            for stateN=1:size(states,2)
                state = states(stateN);
                targetStates = (targetStates | (stateSequence == state));
            end
            ix = find(targetStates);
            N(1,1,:,:) = hist3([tTrack(ix),xTrack(ix)],{tBins,xBins});
            Ntot(plotN,powerN,:,:) = Ntot(plotN,powerN,:,:) + N.*stateMultiplier;
        end
    end
end

maxDensity = max(Ntot(:));
colormap(gca, 'bone');
for plotN = 1:Nplots
    for powerN = 1:Npowers
        
        xOffset = (powerN - 1) * hInterval;
        yOffset = -(plotN-1) * vInterval;
        
        jimage(xBins + xOffset, -tBins + yOffset, 1-squeeze(Ntot(plotN,powerN,:,:))./maxDensity,bone);
        hold on;
    end
end


set(gca,'XTick',[],'YTick',[],'ZTick',[]);



% Draw laser marks and LP legend
for powerN = 1:Npowers
    plotN = 1;
    xOffset = (powerN - 1) * hInterval;
    yOffset = -(plotN - 1) * vInterval;
    text(xOffset,...
        2 + yOffset,...
        ['LP = ',num2str(powerList(powerN))],...
        'HorizontalAlignment','center','VerticalAlignment','bottom',...
        'FontSize',fontSize);
    for plotN = 1:Nplots
        xOffset = (powerN - 1) * hInterval;
        yOffset = -(plotN - 1) * vInterval;
        fill(2*[-1 0 0 -1] + xBins(1) - 1 + xOffset,...
            -[1 1 3 3].*60 + yOffset,...
            'r','FaceColor','r','EdgeColor','none','FaceAlpha',.3);
        fill(2*[0 1 1 0] + xBins(end) + 1 + xOffset,...
            -[4 4 6 6].*60 + yOffset,...
            'r','FaceColor','r','EdgeColor','none','FaceAlpha',.3);
        
    end
end

if (Nplots > 1)
% Plot Y text
    for plotN = 1:Nplots
        text(xBins(1) - 10,-(plotN-1)*vInterval - 3*60, stateDescriptions{plotN},...
            'HorizontalAlignment','right','VerticalAlignment','bottom','FontSize',fontSize);
    end
end

axis tight;
xlims = xlim();
xlim([xlims(1)-15,xlims(2)]);
ylims = ylim();
ylim([ylims(1)-80 ylims(2)]);

    ticLength = 2;
    axisMiddle = xBins(1) - 10;
    line(axisMiddle.*[1 1],[25 -6*60],'Color','k');
    line(axisMiddle + ticLength.*[-1 1],[0 0],'Color','k');
    text(axisMiddle - 2*ticLength,0,'t = 0','FontSize',fontSize,...
        'HorizontalAlignment','right');
    line(axisMiddle + ticLength.*[-1, 0, 1],-6*60 + [25 0 25],'Color','k');
    
    axisBottom = -6*60 - 35;
    ticLength = 15;
    line([xBins(1)-5 xBins(end)+5],axisBottom + [0 0],'Color','k');
    line([0 0]+xBins(1),axisBottom + ticLength.*[-1 1],'Color','k');
    line([0 0]+xBins(end),axisBottom + ticLength.*[-1 1],'Color','k');
    line([0 0],axisBottom + ticLength.*[-1 1],'Color','k');
    text(xBins(1),axisBottom-30,num2str(xBins(1)),'HorizontalAlignment','center',...
        'VerticalAlignment','top','FontSize',fontSize);
    text(xBins(end),axisBottom-30,num2str(xBins(end)),'HorizontalAlignment','center',...
        'VerticalAlignment','top','FontSize',fontSize);
    text(0,axisBottom-30,'0 mm','HorizontalAlignment','center',...
        'VerticalAlignment','top','FontSize',fontSize);




box off;
%axis tight;
set(gca,'Visible','off');
set(gcf,'Color','w');
freezeColors();



