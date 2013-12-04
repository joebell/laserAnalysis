function fixPlot1(fHandle)
	% Fix spacing issues
	children = get(fHandle,'Children');
	for n = 8:19
		set(children(n),'ActivePositionProperty','outerPosition');
		exPos = get(children(n),'OuterPosition');
		set(children(n),'OuterPosition', exPos.*[1 1 1 .93]);
	end

	for n = 1:7
		set(children(n),'ActivePositionProperty','outerPosition');
		exPos = get(children(n),'OuterPosition');
		set(children(n),'OuterPosition', exPos + [0 -.02 0 0]);
	end

	for n = 1:3
		set(children(n),'ActivePositionProperty','outerPosition');
		exPos = get(children(n),'OuterPosition');
		set(children(n),'OuterPosition', exPos + [0 -.02 0 0]);
	end
