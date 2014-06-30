function plotDirectedGraph(stateSeq, linkageThresh)

	circleSize = .05;
	tM = stateSeqTransMatrix(stateSeq,1);
	counts = countOccupancy(stateSeq);

	% Symmetrize transitionMatrix
	for i=1:size(tM,1)
		for j=1:size(tM,2)
			sM(i,j) = 1-(tM(i,j) + tM(j,i));
			if (i == j)
				sM(i,j) = 0;
			end
		end
	end

	[Y, e] = cmdscale(sM);
	xCoords = Y(:,1);
	yCoords = Y(:,2);
	circleScale = circleSize*max([xCoords(:);yCoords(:)]);

	for i=1:size(tM,1)
		for j=1:size(tM,2)
			% tM is (toState, fromState)
			if (i ~= j) 
		
				xSrc = xCoords(j); xDest = xCoords(i);	
			    xChange = xDest - xSrc;

				ySrc = yCoords(j); yDest = yCoords(i);	
			    yChange = yDest - ySrc;

				radius = 5;
				angle = atan2(yChange,xChange);
				radius = circleScale.*counts(i)/max(counts);
				arrowLength = sqrt(xChange.^2 + yChange.^2) - radius;
				yDest = ySrc + arrowLength*sin(angle);
			    xDest = xSrc + arrowLength*cos(angle);	

				colorVal = [1 1 1].*.9;

				drawarrow(xSrc,xDest,ySrc,yDest,.08*tM(i,j),colorVal);
			end
		end
	end

	for i=1:size(tM,1)
		for j=1:size(tM,2)
			% tM is (toState, fromState)
			if ((i ~= j) && (tM(i,j) > linkageThresh))
		
				xSrc = xCoords(j); xDest = xCoords(i);	
			    xChange = xDest - xSrc;

				ySrc = yCoords(j); yDest = yCoords(i);	
			    yChange = yDest - ySrc;

				radius = 5;
				angle = atan2(yChange,xChange);
				radius = circleScale.*counts(i)/max(counts);
				arrowLength = sqrt(xChange.^2 + yChange.^2) - radius;
				yDest = ySrc + arrowLength*sin(angle);
			    xDest = xSrc + arrowLength*cos(angle);	

				colorIX = tM(i,j)./max(tM(:));
				colorVal = colorScale(colorIX);

				drawarrow(xSrc,xDest,ySrc,yDest,.08*tM(i,j),colorVal);
			end
		end
	end


	for stateN = 1:size(tM,1)
		viscircles([xCoords(:),yCoords(:)],...
			circleScale.*counts./max(counts), 'EdgeColor','k');
	end



	axis equal;
	set(gca,'XTick',[],'YTick',[]);
	box on;

function drawarrow(x1,x2,y1,y2,len,colorValue)


	%DRAWARROW connecting two points with a line with arrowhead
	
	cita=pi/12; % default angle between the two sides of arrow is 30
	cos_cita=cos(cita);
	sin_cita=sin(cita);
	x=[x1 x2];
	y=[y1 y2];

	r=len/sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2)); % r is the ratio of the length of arrow side to the distance between the two points.

	hdl_line=line(x,y,'color',colorValue); % you can change the color of line here,default color is black

	p1_x=x2;
	p1_y=y2;

	p2_x=x2+r*(cos_cita*(x1-x2)-sin_cita*(y1-y2));
	p2_y=y2+r*(cos_cita*(y1-y2)+sin_cita*(x1-x2));
	p3_x=x2+r*(cos_cita*(x1-x2)+sin_cita*(y1-y2));
	p3_y=y2+r*(cos_cita*(y1-y2)-sin_cita*(x1-x2));

	% hdl_head=patch([p1_x p2_x p3_x],[p1_y p2_y p3_y],'k'); % you can change the color of arrow here,default color is black

function triplet = colorScale(colorValue)

	base = .5;
	if (colorValue > .5)
		scaleDiff = (colorValue - .5)/.5;
		triplet = [base+(1-base)*scaleDiff base base];
	else
		scaleDiff = (.5 - colorValue)/.5;
		triplet = [base base base+(1-base)*scaleDiff];
	end



