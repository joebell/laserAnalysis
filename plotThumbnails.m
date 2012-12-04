function plotThumbnails(expList, title, useLanes)
    
    dM = makeDataMatrix(expList);
    numPoints = size(dM.PI,2);
    laserPowers = dM.conc(:,1)';
    powerList = unique(laserPowers);
    nPowers = size(powerList,2);
    nReps = ceil(size(expList,2)/nPowers);
           

    for expN = expList
        
        loadData(expN);
        exp.comment; 
        scaledExp = scaleTracks(exp);
        powerN = dsearchn(powerList', exp.laserPower);
        repN = ceil((expN - expList(1) + 1)/nPowers);

        originX = (repN-1)*60*7;
        originY = -(powerN-1)*9*60;
        text(originX,originY+20,num2str(expN),'FontSize',6,...
            'HorizontalAlignment','left','VerticalAlignment','bottom');
        hold on;
        plotBG(originX,originY); 
        for flyN=useLanes
            yAdj = -(flyN-1)*60;
            time = (1:(size(scaledExp.wholeScaledTrack,1))).*scaledExp.acquisitionRate;
            plot(time+originX,scaledExp.wholeScaledTrack(:,1,flyN)+yAdj+originY,'Color',pretty(flyN));
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
    
    text((nReps)*60*7/2,90,title,'HorizontalAlignment','center',...
        'FontSize',10,'VerticalAlignment','bottom');
    set(gcf,'Color','w');
    set(gca,'Visible','off');


    
    
    
