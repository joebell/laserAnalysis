function findSyllables(fL, flyList)

	sampleTime = .05;
	longSeq = longSeries(fL,flyList);

	bodyX = longSeq(:,1);
	bodyY = longSeq(:,2);
	headAngle = atan2(longSeq(:,4),longSeq(:,3));

	smoothBodyX = smooth(bodyX, 10);
	smoothBodyY = smooth(bodyY, 10);
	smoothBodyX20 = smooth(bodyX, 20);
	smoothBodyY20 = smooth(bodyY, 20);
	smoothBodyX40 = smooth(bodyX, 40);
	smoothBodyY40 = smooth(bodyY, 40);
	smoothBodyX80 = smooth(bodyX, 80);
	smoothBodyY80 = smooth(bodyY, 80);

	smoothUnwrappedAngle = smooth(unwrap(headAngle), 10);
	smoothUnwrappedAngle20 = smooth(unwrap(headAngle), 20);
	smoothUnwrappedAngle40 = smooth(unwrap(headAngle), 40);
	smoothUnwrappedAngle80 = smooth(unwrap(headAngle), 80);

	bodydX = [diff(smoothBodyX);0]./sampleTime;
	bodydY = [diff(smoothBodyY);0]./sampleTime;

	bodydX20 = [diff(smoothBodyX20);0]./sampleTime;
	bodydX40 = [diff(smoothBodyX40);0]./sampleTime;
	bodydX80 = [diff(smoothBodyX80);0]./sampleTime;
	bodydY20 = [diff(smoothBodyY20);0]./sampleTime;
	bodydY40 = [diff(smoothBodyY40);0]./sampleTime;
	bodydY80 = [diff(smoothBodyY80);0]./sampleTime;

	dAngle = [diff(smoothUnwrappedAngle) ; 0]./sampleTime;
	smoothAngle = mod(smoothUnwrappedAngle,2*pi) - pi;

	travelAngle = atan2(bodydY, bodydX);

	normBodydX = 2*bodydX ./ (max(bodydX(:)) - min(bodydX(:)));
	normBodydY = 2*bodydY ./ (max(bodydX(:)) - min(bodydX(:)));
	normBodydX20 = 2*bodydX20 ./ (max(bodydX20(:)) - min(bodydX20(:)));
	normBodydY20 = 2*bodydY20 ./ (max(bodydX20(:)) - min(bodydX20(:)));
	normBodydX40 = 2*bodydX40 ./ (max(bodydX40(:)) - min(bodydX40(:)));
	normBodydY40 = 2*bodydY40 ./ (max(bodydX40(:)) - min(bodydX40(:)));
	normBodydX80 = 2*bodydX80 ./ (max(bodydX80(:)) - min(bodydX80(:)));
	normBodydY80 = 2*bodydY80 ./ (max(bodydX80(:)) - min(bodydX80(:)));

	normAngle = smoothAngle./pi;
	normDAngle = 2*dAngle ./ (max(dAngle(:)) - min(dAngle(:)));
	normTravelAngle = travelAngle/pi;


%	plot(normBodydX,'r'); hold on;
%	plot(normBodydY,'g');
%	plot(normAngle,'b');
%	plot(normDAngle,'m');
%	plot(normTravelAngle,'k');

	multiDimVector(:,1) = normBodydX;
	multiDimVector(:,2) = normBodydY;
	multiDimVector(:,3) = normAngle;
	multiDimVector(:,4) = normDAngle;
	multiDimVector(:,5) = normTravelAngle;
	multiDimVector(:,6) = smoothBodyX./25;
	multiDimVector(:,7) = smoothBodyY./25;

	multiDimVector(:,8) = normBodydX20;
	multiDimVector(:,9) = normBodydY20;
	multiDimVector(:,10) = normBodydX40;
	multiDimVector(:,11) = normBodydY40;
	multiDimVector(:,12) = normBodydX80;
	multiDimVector(:,13) = normBodydY80;

	windowSize = 10;
	testWindowStarts = 1:windowSize/1:(size(multiDimVector,1) - windowSize);
	for testWindowStartN = 1:100%length(testWindowStarts)
		testWindowStartN
		testWindowStart = testWindowStarts(testWindowStartN);
		testSnippet = multiDimVector(testWindowStart:(testWindowStart+windowSize),:);
		
		totalC = zeros(size(multiDimVector,1) ,1);
		for dim = 1:size(multiDimVector,2)
			[c, lags] = xcorr(testSnippet(:,dim),multiDimVector(:,dim));
			totalC = totalC + c(size(multiDimVector,1):-1:1);
		end
		corrMap(testWindowStartN, :) = (totalC - mean(totalC))./std(totalC);
	end

	subplot(3,1,1:2);
	image(corrMap,'CDataMapping','scaled','XData',[1:size(multiDimVector,1)].*sampleTime);
	subplot(3,1,3);

	diffCorrMap = abs(diff(corrMap,1));
	sumCorr = sum(diffCorrMap,1);
	plot([1:length(sumCorr)].*sampleTime,sumCorr);
