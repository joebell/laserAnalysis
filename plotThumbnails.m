function plotThumbnails(expList, title, useLanes)
    
    timeSampleInterval = .1;
    
    dM = makeDataMatrix(expList);
    numPoints = size(dM.PI,2);
    laserPowers = dM.conc(:,1)';
    powerList = unique(laserPowers);
    nPowers = size(powerList,2);
    nReps = ceil(size(expList,2)/nPowers);
	zeroRepIdx = 1;
           

    for expN = expList
        
        loadData(expN);
 
        powerN = dsearchn(powerList', max(exp.laserParams.*exp.laserFilter));
        repN = 2*ceil((expN - expList(1) + 1)/(2*nPowers))-1;
        
        	if (exp.laserParams(1) > exp.laserParams(2))
                lEpoch = 1;
            elseif (exp.laserParams(2) > exp.laserParams(1))
                lEpoch = -1;
                repN = repN + 1;
            elseif (exp.laserParams(1) == exp.laserParams(2))
                repN = zeroRepIdx;
				zeroRepIdx = zeroRepIdx + 1;
				if (mod(repN,2) == 1)
					lEpoch = 1;
				else
					lEpoch = -1;
				end
            end
        
        originX = (repN-1)*60*4;
        originY = -(powerN-1)*9*60;
        text(originX,originY+20,num2str(expN),'FontSize',6,...
            'HorizontalAlignment','left','VerticalAlignment','bottom');
        hold on;
        plotBG(originX,originY,lEpoch);
        % Resample data
        bodyX = resample(exp.wholeTrack.bodyX,0:timeSampleInterval:exp.wholeTrack.bodyX.Time(end));
        headX = resample(exp.wholeTrack.headX,0:timeSampleInterval:exp.wholeTrack.headX.Time(end));
        tTrack = bodyX.Time;
        for flyN=useLanes
            yAdj = -(flyN-1)*60;
            xTrack = bodyX.Data(:,flyN) + headX.Data(:,flyN);           
            plot(tTrack+originX,xTrack+yAdj+originY,'Color',pretty(flyN));
        end
        set(gca,'XTick',[],'YTick',[],'ZTick',[]);
        box off;
        axis tight;
    end
    
    for powerN = 1:nPowers
        aPower = powerList(powerN);
        originY = -(powerN-1)*9*60;
        text(-60,originY-4*60,['LP= ',num2str(aPower)],'HorizontalAlignment','right',...
            'FontSize',8);
    end
    
    text((nReps)*60*4/2,90,title,'HorizontalAlignment','center',...
        'FontSize',10,'VerticalAlignment','bottom');
    set(gcf,'Color','w');
    set(gca,'Visible','off');


    
    
    
