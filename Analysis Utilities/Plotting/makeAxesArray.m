function axesArray = makeAxesArray(nAxes)

	figure;
	for axisN = 1:nAxes
		axesArray(axisN) = subplot(1,nAxes,axisN);
	end
