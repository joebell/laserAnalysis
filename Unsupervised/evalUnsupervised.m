function evalUnsupervised()

cScale = .5;

load('testUnsupData.mat');
baseL = stateSeqTransMatrix(newSeq,1);
baseR = baseL;

		for stimN = 1:8

			colormap(fireAndIce);
			
			subplot(2,8, stimN);
			testL = stateTransStim(1,stimN);
			image(testL - baseL,'CDataMapping','scaled');
			caxis([-1 1].*cScale);
			set(gca,'XTick',[],'YTick',[]);

			subplot(2,8, 8 + stimN);
			testR = stateTransStim(-1,stimN);
			image(testR - baseR,'CDataMapping','scaled');
			caxis([-1 1].*cScale);
			set(gca,'XTick',[],'YTick',[]);
		end

