function seriesAnalyze(gM)

figure;
	powerList = unique(gM(:,3));
	for powerN = 1:length(powerList)

		subplot(3,3,powerN);
		ix = find((gM(:,3) == powerList(powerN))   & (gM(:,2) <= 32)); % & (gM(:,2) <= 16)
		subGM = gM(ix,:);


		x = subGM(:,12);
		y = subGM(:,1);
		scatter(x,y,'b.'); hold on;
		fitObj = fit(x,y,'poly1');
		plot(fitObj); legend('off');
%		scatter((subGM(ixDiff,5)),subGM(ixDiff,1),'r.');
		title(['LP = ',num2str(powerList(powerN))]);
		xlim([0 400]); % 
		ylim([-1 1]);
		xlabel('Light exposure (AU)');
		ylabel('PI');
	end


	
