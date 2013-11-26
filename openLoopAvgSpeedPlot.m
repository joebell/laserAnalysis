%
function openLoopAvgSpeedPlot(fileList,gateTime,xRange,dXdTRange)


	loadData(fileList(1));
	Npowers = length(exp.laserPowers);

	if (Npowers == 4)
		prettyColors{1} = pretty(8);
		prettyColors{2} = pretty(5);
		prettyColors{3} = pretty(4);
		prettyColors{4} = pretty(1);
	else
		for n=1:8
			prettyColors{n} = pretty(9-n);
		end
	end

	timeSampleInterval = .1;
	time = 0:timeSampleInterval:30;
	
	allData = zeros(1,0,length(time));
	powersOfTraces = [];

	orderList = 1:size(fileList,2);
	for fileNn = orderList
		
		fileNum = fileList(fileNn);
		loadData(fileNum);
		
		laserPower = max(exp.laserParams);
		powerN = dsearchn(exp.laserPowers',laserPower);
			
		Xts = exp.wholeTrack.bodyX;
		bodyXs = resample(Xts,time);
		
        for flyN = 1:8

            bodyX = bodyXs.Data(:,flyN);
			dXdT = smoothVelocityTrack(bodyX);

			if (  (bodyX(round(gateTime/timeSampleInterval)) > xRange(1)) &&...
				  (bodyX(round(gateTime/timeSampleInterval)) < xRange(2)) &&...
			      ( dXdT(round(gateTime/timeSampleInterval)) > dXdTRange(1)) &&...
				  ( dXdT(round(gateTime/timeSampleInterval)) < dXdTRange(2)) )
	
					allData(1,end+1,:) = abs(dXdT(:));
					powersOfTraces(end+1) = powerN;

			end
			bodyX = -bodyX;
			dXdT  = -dXdT;
			if (  (bodyX(round(gateTime/timeSampleInterval)) > xRange(1)) &&...
				  (bodyX(round(gateTime/timeSampleInterval)) < xRange(2)) &&...
			      ( dXdT(round(gateTime/timeSampleInterval)) > dXdTRange(1)) &&...
				  ( dXdT(round(gateTime/timeSampleInterval)) < dXdTRange(2)) )
	
					allData(1,end+1,:) = abs(dXdT(:));
					powersOfTraces(end+1) = powerN;
			end
		end
	end

	for powerN=1:Npowers

		ix = find(powersOfTraces == powerN);
		Ntraces = length(ix);
		meanTrace = mean(allData(1,ix,:),2);
		stdTrace  =  std(allData(1,ix,:),0,2)./sqrt(Ntraces);
		h = joeArea(time(:)',meanTrace(:)'-stdTrace(:)',meanTrace(:)'+stdTrace(:)');
		set(h,'EdgeColor','none','FaceColor',prettyColors{powerN},'FaceAlpha',.3);
		hold on;
		plot(time(:),meanTrace(:),'Color',prettyColors{powerN}); hold on;

		xlim([10 30]); 
		ylim([0 12]); 
		line([1 1]*gateTime,ylim(),'LineStyle',':','Color',[1 0 0]*.75);
		fill([15 15 16 16] , [ylim(),fliplr(ylim())],'b','EdgeColor','none',...
			'FaceColor','b','FaceAlpha',.1);
		line(xlim(), [0 0],'Color',[1 1 1]*.85);
		
	end
