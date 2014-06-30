function [multiDimVector, alignment] = normalizeTracks(fL, flyList)

	sampleTime = .05;
	[longSeq,alignment] = calLongSeries(fL,flyList);

	bodyX = longSeq(:,1);
	bodyY = longSeq(:,2);
	headAngle = atan2(smooth(longSeq(:,4),10),smooth(longSeq(:,3),10));

	smoothBodyX = smooth(bodyX, 10);
	smoothBodyY = smooth(bodyY, 10);

	unwrappedHeadAngle = unwrap(headAngle);

	bodydX = [diff(smoothBodyX);0]./sampleTime;
	bodydY = [diff(smoothBodyY);0]./sampleTime;

	dAngle = [diff(unwrappedHeadAngle) ; 0]./sampleTime;
	travelAngle = atan2(bodydY, bodydX);

	travelSpeed = sqrt(bodydX.^2 + bodydY.^2);

	multiDimVector(:,1) = smoothBodyX;
	multiDimVector(:,2) = smoothBodyY;
	multiDimVector(:,3) = bodydX;
	multiDimVector(:,4) = bodydY;
	multiDimVector(:,5) = headAngle;
	% multiDimVector(:,6) = dAngle;
	% multiDimVector(:,7) = travelAngle;
	% multiDimVector(:,8) = travelSpeed;

	for dim=1:size(multiDimVector,2)

		multiDimVector(:,dim) = (multiDimVector(:,dim) - mean(multiDimVector(:,dim)))./...
		                              std(multiDimVector(:,dim));
	end


