function [LR, testPower] = leftOrRight(exp)

	laserParams = exp.laserParams;

	% If this is a temperature compensated trial, use
	% the field that tells us what side the ref. blue 
	% is on.
	if isfield(exp,'refSide')
		LR = exp.refSide;
		if (LR == 1)
			testPower = laserParams(1);
		elseif (LR == -1)
			testPower = laserParams(2);
		end
		return;
	end

	% If there's no red laser in the data set
	if (length(laserParams) == 2)
		if laserParams(1) > laserParams(2)
			LR = 1;
			testPower = laserParams(1);
		elseif laserParams(2) > laserParams(1)
			LR = -1;
			testPower = laserParams(2);
		elseif laserParams(1) == laserParams(2)
			ix = randi(2);
			LR = 3 - 2*ix;
			testPower = laserParams(ix);
		end
	end

	% If it's a red laser trial, pick relative to blue laser.
	if (length(laserParams) == 4)
		if laserParams(3) == 1
			LR = 1;
			testPower = laserParams(1);
		elseif laserParams(4) == 1
			LR = -1;
			testPower = laserParams(2);
		end
	end

	testPower = testPower*exp.laserFilter;

