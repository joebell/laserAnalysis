function movieTracks(tA, tAIX, IXs, syncSamps, preSamps, postSamps)

	global currentSample;
	global flyHandles;
	global timeHandle;
	speed = 1; % samps/sec

	movieFig = figure();
	
	line([-25 25],[0 0],'Color','k','LineStyle',':'); hold on;
	line([0 0],[-2.5 2.5],'Color','k','LineStyle',':');

	line([-25 25],[-10 -10],'Color','k','LineStyle','--');
	xTime = -25 + 50*preSamps/(postSamps + preSamps);
	line(xTime*[1 1],1*-10 + [-1 1],'Color','k');

	axis tight;
	axis equal;
	axis off;

	currentSample = 0;
	timeHandle = drawTimeMarker(1, preSamps, postSamps);
	frameTimer = timer('ExecutionMode','fixedRate','Period',1/speed,...
			'TasksToExecute',preSamps + postSamps,...
			'TimerFcn',{@advanceTime,tA,IXs,syncSamps,preSamps,postSamps});

	start(frameTimer);


function advanceTime(obj, event, tA, IXs, syncSamps, preSamps, postSamps)

	global currentSample;
	global flyHandles;
	global timeHandle;

	for n = 1:length(flyHandles)
		if ishandle(flyHandles(n))
			delete(flyHandles(n));
		end
	end
	timeHandle = [];

	
	currentSample = currentSample + 1
	timeHandle = drawTimeMarker(currentSample, preSamps, postSamps);

	for trackN = 1:length(IXs)
		IX = IXs(trackN);
		sampN = syncSamps(trackN) - preSamps + currentSample;
		if sampN > 0
			track = tA{IX};
			point = track(sampN,:);
			drawFly(point,'b');
		end
	end

		

function h = drawTimeMarker(sampleTime, preSamps, postSamps)

	h = scatter(-25 + 50*sampleTime/(preSamps + postSamps),-10,64,'k');

	
function h = drawFly(posVector,plotColor)

	xRange = [posVector(1),posVector(1)+posVector(3)];
	yRange = [posVector(2),posVector(2)+posVector(4)];

	h(1) = line(xRange,yRange,'Color',plotColor);
	h(2) = scatter(xRange(2),yRange(2),16,plotColor);
