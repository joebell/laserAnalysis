function laserPlotDensityMod(expList,lanesToUse)

timeSampleInterval = .1;
fontSize = 6;
% lanesToUse = [1:8];

xBins = -25:1:25;
NxBins = size(xBins,2);
xSpan = xBins(end)-xBins(1);
hSpacing = 15;
hInterval = xSpan + hSpacing;

tBins = 0:10:3*60;
NtBins = size(tBins,2);
tSpan = tBins(end) - tBins(1);
vSpacing = 80;
vInterval = tSpan + vSpacing;

statesList = {[1,2,3],[1,2,3]};
%Nplots = size(statesList,2);
Nplots = 2; % Plot L and R separately
stateMultiplierList = [1,1,1,1]; % For scaling state histograms
stateDescriptions = {'Laser L','Laser R'};

for expNn = 1:size(expList,2)
    expN = expList(expNn);
    loadData(expN);
    laserPowers(expNn) = max(exp.laserParams.*exp.laserFilter);
end
powerList = unique(laserPowers);
Npowers = size(powerList,2);

Ntot = zeros(Nplots, Npowers, NtBins, NxBins);

for expNn = 1:size(expList,2)
    expN = expList(expNn);
    loadData(expN);
	if (exp.laserParams(1) > exp.laserParams(2))
		plotN = 1;
	elseif (exp.laserParams(2) > exp.laserParams(1))
		plotN = 2;
	elseif (exp.laserParams(1) == exp.laserParams(2))
		plotN = randi(2);
	end
		powerN = dsearchn(powerList',max(exp.laserParams.*exp.laserFilter));
		% Resample data
		bodyX = resample(exp.wholeTrack.bodyX,0:timeSampleInterval:exp.wholeTrack.bodyX.Time(end));
		headX = resample(exp.wholeTrack.headX,0:timeSampleInterval:exp.wholeTrack.headX.Time(end));
		tTrack = bodyX.Time;
		for fly=lanesToUse
			% Resample data
			xTrack = bodyX.Data(:,fly) + headX.Data(:,fly);
		    stateSequence = identifyStates(xTrack);       
		    % for plotN = 1:Nplots
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
		    % end
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
		if plotN == 1
		    fill(2*[-1 0 0 -1] + xBins(1) - 1 + xOffset,...
		        -[1 1 3 3].*60 + yOffset,...
		        'r','FaceColor','r','EdgeColor','none','FaceAlpha',.3);
		elseif plotN == 2
		    fill(2*[0 1 1 0] + xBins(end) + 1 + xOffset,...
		        -[1 1 3 3].*60 + yOffset,...
		        'r','FaceColor','r','EdgeColor','none','FaceAlpha',.3);
		end
        
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
	arrowLength = 1;
    line(axisMiddle.*[1 1],[25 -arrowLength*60],'Color','k');
    line(axisMiddle + ticLength.*[-1 1],[0 0],'Color','k');
    text(axisMiddle - 2*ticLength,0,'t = 0','FontSize',fontSize,...
        'HorizontalAlignment','right');
    line(axisMiddle + ticLength.*[-1, 0, 1],-arrowLength*60 + [25 0 25],'Color','k');
    
	
    yOffset = -(Nplots - 1) * vInterval;
    axisBottom = yOffset -3*60 - 35;
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



