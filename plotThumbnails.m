function plotThumbnails(dM, expList, useLanes)

    
    timeSampleInterval = .1;
	fontSize = 6;
    
    numPoints = size(dM.PI,2);
    laserPowers = dM.conc(:,1)';
    powerList = unique(laserPowers);
    nPowers = size(powerList,2);
    nReps = ceil(size(expList,2)/nPowers);
	zeroRepIdx = 1;

	usePowers = 1:nPowers;

	repNumbers = ones(2,nPowers);
	repNumbers(2,:) = repNumbers(2,:) + 1;
           

    for expN = expList
        
        loadData(expN);
		[lEpoch, testPower] = leftOrRight(exp); 
        powerN = dsearchn(powerList', testPower);
        %repN = 2*ceil((expN - expList(1) + 1)/(2*nPowers))-1;
        
        	if (lEpoch == 1)
				repN = repNumbers(1,powerN);
				repNumbers(1,powerN) = repNumbers(1,powerN) + 2;
            elseif (lEpoch == -1)
                repN = repNumbers(2,powerN);
				repNumbers(2,powerN) = repNumbers(2,powerN) + 2;
            end

		if sum(powerN == usePowers) > 0
        
		    originX = (repN-1)*60*4;
		    originY = -(powerN-1)*9*60;
		    text(originX,originY+20,num2str(expN),'FontSize',fontSize,...
		        'HorizontalAlignment','left','VerticalAlignment','bottom');
		    hold on;
			if isfield(exp,'trainingEpochs')
		    	plotBGShock(originX,originY,lEpoch);
			else
				plotBG(originX,originY,lEpoch);
			end
		    % Resample data
		    bodyX = resample(exp.wholeTrack.bodyX,0:timeSampleInterval:exp.wholeTrack.bodyX.Time(end));
		    headX = resample(exp.wholeTrack.headX,0:timeSampleInterval:exp.wholeTrack.headX.Time(end));
		    tTrack = bodyX.Time;
		    for flyN=useLanes
		        yAdj = -(flyN-1)*60;
		        xTrack = bodyX.Data(:,flyN) + headX.Data(:,flyN);           
		        plot(tTrack+originX,xTrack+yAdj+originY,'Color',pretty(flyN));
		    end
		end
    end
    
    for powerN = 1:nPowers
        aPower = powerList(powerN);
        originY = -(powerN-1)*9*60;
        text(-60,originY-4*60,['LP= ',num2str(aPower)],'HorizontalAlignment','right',...
            'FontSize',fontSize+2);
    end
   
    % Clean up axes	
    set(gca,'Visible','off','XTick',[],'YTick',[],'ZTick',[]);
	axis tight;
    set(gcf,'Color','w');
	set(gca,'OuterPosition' ,[0 0 1 1],'LooseInset',[.08 .01 .01 .03]);


    
    
    
