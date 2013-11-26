%
function openLoopPlot(fileList,nCols,colNum,gateTime,xRange,dXdTRange)


	loadData(fileList(1));
	Npowers = length(exp.laserPowers);

	timeSampleInterval = .1;
	time = 0:timeSampleInterval:30;
	
	allData = zeros(Npowers,0,length(time));

	orderList = 1:size(fileList,2);
	for fileNn = orderList
		
		fileNum = fileList(fileNn);
		loadData(fileNum);
		
		laserPower = max(exp.laserParams);
		powerN = dsearchn(exp.laserPowers',laserPower);
		% subplot(Npowers,nCols,(powerN-1)*nCols+colNum);
			
		Xts = exp.wholeTrack.bodyX;
		%time = 0:timeSampleInterval:exp.wholeTrack.bodyX.Time(end);
		bodyXs = resample(Xts,time);
		
        for flyN = 1:8

            bodyX = bodyXs.Data(:,flyN);
			dXdT = smoothVelocityTrack(bodyX);

			if (  (bodyX(round(gateTime/timeSampleInterval)) > xRange(1)) &&...
				  (bodyX(round(gateTime/timeSampleInterval)) < xRange(2)) &&...
			      ( dXdT(round(gateTime/timeSampleInterval)) > dXdTRange(1)) &&...
				  ( dXdT(round(gateTime/timeSampleInterval)) < dXdTRange(2)) )
	
					%plot(time,bodyX,'Color',pretty(9-powerN)); 
					%xlim([13 30]); 
					%ylim([-30 30]); 
					%hold on;
					allData(powerN,end+1,:) = bodyX(:);
			end
			bodyX = -bodyX;
			dXdT  = -dXdT;
			if (  (bodyX(round(gateTime/timeSampleInterval)) > xRange(1)) &&...
				  (bodyX(round(gateTime/timeSampleInterval)) < xRange(2)) &&...
			      ( dXdT(round(gateTime/timeSampleInterval)) > dXdTRange(1)) &&...
				  ( dXdT(round(gateTime/timeSampleInterval)) < dXdTRange(2)) )
	
					%plot(time,bodyX,'Color',pretty(9-powerN)); 
					%hold on;
					allData(powerN,end+1,:) = bodyX(:);
			end
		end
	end

	for powerN=1:Npowers
		% subplot(Npowers,nCols,(powerN-1)*nCols+colNum);
		% subplot(1,nCols,colNum);

		meanTrace = mean(allData(powerN,:,:),2);
		stdTrace  =  std(allData(powerN,:,:),0,2)./sqrt(size(allData,2));
		h = joeArea(time(:)',meanTrace(:)'-stdTrace(:)',meanTrace(:)'+stdTrace(:)');
		set(h,'EdgeColor','none','FaceColor',pretty(9-powerN),'FaceAlpha',.3);
		hold on;
		plot(time(:),meanTrace(:),'Color',pretty(9-powerN)); hold on;

		xlim([10 30]); 
		ylim([-30 30]); 
		line([1 1]*gateTime,ylim(),'LineStyle',':','Color',[1 0 0]*.75);
		fill([15 15 16 16] , [ylim(),fliplr(ylim())],'b','EdgeColor','none',...
			'FaceColor','b','FaceAlpha',.1);
		line(xlim(), [0 0],'Color',[1 1 1]*.85);
		
	end
