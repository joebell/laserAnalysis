function plot2DTraces()

	useEpochs = 2;
	timeSampleInterval = .05;
	plotLength = round(60/timeSampleInterval);    % Samples
	filterCorner = .1;
	plotTimeRange = [0,25]; % Sec
	meanTravel = figure();

	%fileList = returnFileList('130408-172049-');
	fileList = returnFileList('130515-');

	allData = [];

	loadData(fileList(1));
	nPowers = length(exp.laserPowers);

	velFig = figure();

	for powerN = 1:nPowers
		figure();
		subplot(5,4,1); nSubs = 20; subN = 1;
		meanX = zeros(600,1);
		meanY = zeros(600,1);
		dataList = [];
		
		nFound = 0;
		for fileNn = 1:length(fileList)

			loadData(fileList(fileNn));
			% If this file has the power that we're doing now
			pIx = dsearchn(exp.laserPowers',max(exp.laserParams));
			if (pIx == powerN)
				for epochN = useEpochs
        
					bodyXs = resample(exp.epoch(epochN).track.bodyX,0:timeSampleInterval:exp.epoch(epochN).track.bodyX.Time(end));
					bodyYs = resample(exp.epoch(epochN).track.bodyY,0:timeSampleInterval:exp.epoch(epochN).track.bodyY.Time(end));
					headXs = resample(exp.epoch(epochN).track.headX,0:timeSampleInterval:exp.epoch(epochN).track.headX.Time(end));
					headYs = resample(exp.epoch(epochN).track.headY,0:timeSampleInterval:exp.epoch(epochN).track.headY.Time(end));

					for flyN = 1:4
						subplot(5,4,subN); hold on;
						subN = subN + 1; if (subN > nSubs) subN = 1; end
						bodyX = bodyXs.Data(:,flyN);
						bodyY = bodyYs.Data(:,flyN);
						headX = headXs.Data(:,flyN);
						headY = headYs.Data(:,flyN);
						time = 0:timeSampleInterval:exp.wholeTrack.bodyX.Time(end);
						if ((flyN == 2) || (flyN == 4))
							bodyX = -bodyX;
							headX = -headX;
						end
						if (exp.laserParams(2) > exp.laserParams(1))
							bodyY = -bodyY;
							headY = -headY;
						end
						X = bodyX + headX;
						Y = bodyY + headY;
						dX = [diff(X);0].*(1/timeSampleInterval);
						dY = [diff(Y);0].*(1/timeSampleInterval);
						dataList = [dataList,[X;Y;dX;dY;time]];
						sSample = dsearchn(time',plotTimeRange(1));
						eSample = dsearchn(time',plotTimeRange(2));

						
							meanX(1:length(bodyX)) = meanX(1:length(bodyX)) + bodyX + headX;
							meanY(1:length(bodyX)) = meanY(1:length(bodyX)) + bodyY + headY;
							nFound = nFound + 1;

						plot(bodyX(sSample:eSample) + headX(sSample:eSample),...
							 bodyY(sSample:eSample) + headY(sSample:eSample),...
							 'Color',pretty(flyN)); hold on;
						plot(bodyX(sSample)+headX(sSample),bodyY(sSample)+headY(sSample),...
							'og');
						plot(bodyX(eSample)+headX(eSample),bodyY(eSample)+headY(eSample),...
							'or');
						axis equal;
						xlim([-35 35]);
						ylim([-22 22]);
					end
				end
			end

			figure(velFig);
			

		end
		figure(meanTravel); hold on;
		if (nPowers == 8)
			plot(meanX(1:end-3)./nFound,meanY(1:end-3)./nFound,'Color',pretty(9-powerN));
		else
			plot(meanX(1:end-3)./nFound,meanY(1:end-3)./nFound,'Color',pretty(10-2*powerN));	
		end		
		plot(meanX(1)./nFound,meanY(1)./nFound,'og');
		plot(meanX(end-3)./nFound,meanY(end-3)./nFound,'or');
		axis equal; 



	end
		

