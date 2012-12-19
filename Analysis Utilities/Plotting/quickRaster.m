function h = quickRaster(bottom,top,timePoints)

	timePoints = timePoints(:)';
	nPoints = size(timePoints,2);

	x = ones(1,nPoints).*bottom;
	y = ones(1,nPoints).*top;
	z = x.*NaN;

	c = [x;y;z];
	yVals = c(:);
	c = [timePoints;timePoints;timePoints];
	xVals = c(:);

	h = plot(xVals,yVals);
