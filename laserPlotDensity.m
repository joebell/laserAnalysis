function laserPlotDensity(expList,lanesToUse)

fontSize = 6;
% lanesToUse = [1:8];

xBins = -25:1:25;
NxBins = size(xBins,2);
xSpan = xBins(end)-xBins(1);
vSpacing = 10;
vInterval = xSpan + vSpacing;

tBins = 0:10:6*60;
NtBins = size(tBins,2);
tSpan = tBins(end) - tBins(1);
hSpacing = 80;
hInterval = tSpan + hSpacing;

statesList = {[1,2,3],1,2,3};
Nplots = size(statesList,2);
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
        yOffset = (Nplots - plotN) * vInterval;
        
        jimage(tBins + xOffset, xBins + yOffset, 1-squeeze(Ntot(plotN,powerN,:,:))'./maxDensity,bone);
        hold on;
    end
end


set(gca,'XTick',[],'YTick',[],'ZTick',[]);



% Draw laser marks and LP legend
for powerN = 1:Npowers
    plotN = 1;
    xOffset = (powerN - 1) * hInterval;
    yOffset = (Nplots - plotN) * vInterval;
    text((3*60 + xOffset),...
        xBins(end) + 2 + yOffset,...
        ['LP = ',num2str(powerList(powerN))],...
        'HorizontalAlignment','center','VerticalAlignment','bottom',...
        'FontSize',fontSize);
    for plotN = 1:Nplots
        xOffset = (powerN - 1) * hInterval;
        yOffset = (Nplots - plotN) * vInterval;
        fill([1 1 3 3].*60 + xOffset,...
            2*[-1 0 0 -1] + xBins(1) - 1 + yOffset,...
            'r','FaceColor','r','EdgeColor','none','FaceAlpha',.3);
        fill([4 4 6 6].*60 + xOffset,...
            2*[0 1 1 0] + xBins(end) + 1 + yOffset,...
            'r','FaceColor','r','EdgeColor','none','FaceAlpha',.3);
    end
end


% Plot Y text
for plotN = 1:Nplots
    text(-20,(Nplots - plotN)*vInterval, stateDescriptions{plotN},...
        'HorizontalAlignment','right','VerticalAlignment','bottom','FontSize',fontSize);
end

box off;
axis tight;
set(gca,'Visible','off');
set(gcf,'Color','w');
freezeColors();



