function stateSequence = identifyStates(scaledTrack)
  
    vThresh = 3;            % mm/sec
    sampleTime = .1;        % sec
    minStateDuration = 4;   % samples
    filterMinStates = true; % Remove short states
    
    smoothVel = smoothVelocityTrack(scaledTrack);

    % Define the state sequence
    stateSequence = ones(size(smoothVel,1),1)*2;
    ix = find(smoothVel < -vThresh);
        stateSequence(ix) = 1;
    ix = find(smoothVel > vThresh);
        stateSequence(ix) = 3;
    
    % Remove very short occupancy states
    % Replace with half of state on each side
    % Change sample is aligned to the first different
    % point
    
    if (filterMinStates)
        
    keepRemoving = true;
    while (keepRemoving)
        stChange = cat(1,0,diff(stateSequence));
        chPoints = find(abs(stChange) > 0);
        chLengths = diff(chPoints);
        % Find the shortest transition length
        [shortest,ix] = min(chLengths);
        if (shortest < minStateDuration)
            % Remove the transition at the midpoint of
            % the short state
            chPoint = chPoints(ix);
            nextChPoint = chPoints(ix+1);
            midPoint = round((chPoint+nextChPoint)/2);
            originState = stateSequence(chPoint-1);
            destState = stateSequence(nextChPoint);
            stateSequence(chPoint:midPoint) = originState;
            stateSequence(midPoint:nextChPoint) = destState;
        else
            % Stop removing short transitions
            keepRemoving = false;
        end
    end
    
    end
    
    
    
