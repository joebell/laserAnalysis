function plotContingentMiesenbock(expNum)

		epochList = [2:2:16];

		timeSampleInterval = .1;
		spaceDist = 60;

		loadData(expNum);

		bodyX = resample(exp.wholeTrack.bodyX,0:timeSampleInterval:exp.wholeTrack.bodyX.Time(end));
		headX = resample(exp.wholeTrack.headX,0:timeSampleInterval:exp.wholeTrack.headX.Time(end));
		tTrack = bodyX.Time;

		figure();
		for flyN = 1:8
			plot(tTrack./60,bodyX.data(:,flyN) + headX.data(:,flyN) - spaceDist*flyN); hold on;
			xlim([0 28]);
			plot(xlim(),[0 0] - spaceDist*flyN,'Color',[.7 .7 .7]);

			fill([0 2 2 0]+1,[-25 -25 0 0]-spaceDist*flyN,'b','EdgeColor','none','FaceColor','b',...
				'FaceAlpha',.2);
			fill([0 2 2 0]+5,[0 0 25 25]-spaceDist*flyN,'b','EdgeColor','none','FaceColor','b',...
				'FaceAlpha',.2);
			fill([0 1 1 0] +9,[-25 -25 0 0]-spaceDist*flyN,'b','EdgeColor','none','FaceColor','g',...
				'FaceAlpha',.2);
			fill([0 1 1 0]+11,[0 0 25 25]-spaceDist*flyN,'b','EdgeColor','none','FaceColor','g',...
				'FaceAlpha',.2);
			fill([0 1 1 0]+14,[-25 -25 0 0]-spaceDist*flyN,'b','EdgeColor','none','FaceColor','g',...
				'FaceAlpha',.2);
			fill([0 1 1 0]+16,[0 0 25 25]-spaceDist*flyN,'b','EdgeColor','none','FaceColor','g',...
				'FaceAlpha',.2);
			fill([0 2 2 0]+22,[-25 -25 0 0]-spaceDist*flyN,'b','EdgeColor','none','FaceColor','b',...
				'FaceAlpha',.2);
			fill([0 2 2 0]+26,[0 0 25 25]-spaceDist*flyN,'b','EdgeColor','none','FaceColor','b',...
				'FaceAlpha',.2);				
		end




		flyN = 9;
		plot(tTrack./60,mean(bodyX.data(:,:) + headX.data(:,:) ,2)*1 - spaceDist*flyN);
		plot(tTrack./60,sum(sign(bodyX.data(:,:) + headX.data(:,:)),2)*4 - spaceDist*flyN,'r');
		plot(xlim(),[0 0] - spaceDist*flyN,'Color',[.7 .7 .7]);
			fill([0 2 2 0]+1,[-25 -25 0 0]-spaceDist*flyN,'b','EdgeColor','none','FaceColor','b',...
				'FaceAlpha',.2);
			fill([0 2 2 0]+5,[0 0 25 25]-spaceDist*flyN,'b','EdgeColor','none','FaceColor','b',...
				'FaceAlpha',.2);
			fill([0 1 1 0] + 9,[-25 -25 0 0]-spaceDist*flyN,'b','EdgeColor','none','FaceColor','g',...
				'FaceAlpha',.2);
			fill([0 1 1 0]+11,[0 0 25 25]-spaceDist*flyN,'b','EdgeColor','none','FaceColor','g',...
				'FaceAlpha',.2);
			fill([0 1 1 0]+14,[-25 -25 0 0]-spaceDist*flyN,'b','EdgeColor','none','FaceColor','g',...
				'FaceAlpha',.2);
			fill([0 1 1 0]+16,[0 0 25 25]-spaceDist*flyN,'b','EdgeColor','none','FaceColor','g',...
				'FaceAlpha',.2);
			fill([0 2 2 0]+22,[-25 -25 0 0]-spaceDist*flyN,'b','EdgeColor','none','FaceColor','b',...
				'FaceAlpha',.2);
			fill([0 2 2 0]+26,[0 0 25 25]-spaceDist*flyN,'b','EdgeColor','none','FaceColor','b',...
				'FaceAlpha',.2);

		xlabel('Time (min)');
		ylabel('');
		set(gca,'YTick',[]);

		for epochNn = 1:length(epochList)
			epochN = epochList(epochNn);
			bodyXseg = resample(exp.epoch(epochN).track.bodyX,0:timeSampleInterval:exp.epoch(epochN).track.bodyX.Time(end));
			headXseg = resample(exp.epoch(epochN).track.headX,0:timeSampleInterval:exp.epoch(epochN).track.headX.Time(end));
			
			protLine = exp.protocolDesign{epochN};
			timeStart = protLine{1};

			totalPI = 0;
			totalDecPI = 0;
			for flyN = 1:8
				seg = bodyXseg.data(:,flyN) + headXseg.data(:,flyN);
				PI = (nnz(seg > 0) - nnz(seg < 0))./length(seg);
				[numL,numR] = computeDecPI(seg);
				if (numR + numL > 0)
					decPI = (numR - numL)./(numR + numL);
				else
					decPI = 0;
				end
				if (mod(epochN,4) > 0)
					PI = -PI;
					decPI = -decPI;
				end
				totalPI = totalPI + PI;
				totalDecPI = totalDecPI + decPI;

				text(timeStart,25 - spaceDist*flyN,[num2str(PI,2),' / ',num2str(decPI,2)],...
					'FontSize',8,...
					'HorizontalAlignment','left',...
					'VerticalAlignment','baseline');
			end

			text(timeStart,25 - spaceDist*9,[num2str(totalPI/8,2),' / ',num2str(totalDecPI/8,2)],...
					'FontSize',8,...
					'HorizontalAlignment','left',...
					'VerticalAlignment','baseline');

		end

		
