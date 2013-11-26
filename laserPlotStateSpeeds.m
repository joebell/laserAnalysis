function laserPlotStateSpeeds(expList, useEpochs, lanesToUse, axesArray)

fontSize = 6;
timeSampleInterval = .1;
minTravelDistance = 5; % mm
% lanesToUse = [1:8];

xBins = -25:1:25;
xBinEdges = [xBins(1)-.5,xBins+.5];
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
    laserPowers(expNn) = max(exp.laserParams.*exp.laserFilter);
end
powerList = unique(laserPowers);
Npowers = size(powerList,2);

Ntot = cell(Nplots,Npowers,2,NxBins);

for expNn = 1:size(expList,2)
    expN = expList(expNn);
    loadData(expN);
    powerN = dsearchn(powerList',max(exp.laserParams.*exp.laserFilter));
	% Resample data
	bodyX = resample(exp.wholeTrack.bodyX,0:timeSampleInterval:exp.wholeTrack.bodyX.Time(end));
	headX = resample(exp.wholeTrack.headX,0:timeSampleInterval:exp.wholeTrack.headX.Time(end));
	tTrack = bodyX.Time;
    for fly=lanesToUse
        for epochNn = 1:1
			if (exp.laserParams(1) > exp.laserParams(2))
				topN = 1;
			elseif (exp.laserParams(1) < exp.laserParams(2))
				topN = 2;
			elseif (exp.laserParams(1) == exp.laserParams(2))
				topN = randi(2);
			end
            epochN = useEpochs(epochNn);
            xTrack = bodyX.Data(:,fly) + headX.Data(:,fly);
            dTraveled = sum(abs(diff(xTrack)));
            if (dTraveled > minTravelDistance) % Screen out stationary tracks
                stateSequence = identifyStates(xTrack);
				smoothVel = smoothVelocityTrack(xTrack);
				[n,XbinIdx] = histc(xTrack,xBinEdges);
                for stateN = statesList					
					for binN = 1:NxBins
						ix = find((XbinIdx == binN) & (stateSequence == stateN));
						existingVelList = Ntot{stateN,powerN,topN,binN};
						newVelList = smoothVel(ix);
						Ntot{stateN,powerN,topN,binN} = [existingVelList;newVelList];
					end		                  
                end
            else
                disp('Discarded stationary track.');
            end
        end
    end
end

for stateN = statesList
	for powerN = 1:Npowers
		for topN = 1:2
			for xBinN = 1:NxBins
				velList = Ntot{stateN,powerN,topN,xBinN};
				aVel = nanmean(velList);
				meanVel(stateN,powerN,topN,xBinN) = aVel;
			end
		end
	end
end




maxVel = max(meanVel(:));
for stateN = statesList
    axes(axesArray(stateN));
    for powerN = 1:Npowers
        plotColor = [powerN/Npowers 0 0];
        plot(xBins, -squeeze(meanVel(stateN,powerN,1,:)),'Color',plotColor);
        hold on;
        plot(xBins,  squeeze(meanVel(stateN,powerN,2,:)),'Color',plotColor);
    end
    title(stateDescriptions{stateN},'FontSize',fontSize);
    xlim([-25 25]);
    xlabel('X (mm)','FontSize',fontSize);
end
axes(axesArray(1));
ylabel('V (mm/sec)','FontSize',fontSize);

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
    






