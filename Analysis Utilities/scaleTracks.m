% Returns a new experiment with tracks scaled in mm.  X tracks are centered
% at 0.  Y tracks have arbitrary offset.
%
% Also returns concatenated tracks from the whole experiment.
function newExp = scaleTracks(exp)

    cal = exp.trackingParams.calPoints;
    xMiddle = round((cal.topVent(1)+cal.bottomVent(1))/2);
    vCalDist = 175;  % In mm
    % Multiply pixels by this to get mm distance
    scaleToMM = vCalDist/(cal.bottomVent(2)-cal.topVent(2));
    
    newExp = exp;
    
    wholeTrack = [];
    wholeScaled = [];
    wholeVelocity = [];
    
    for epochN = 1:size(newExp.epoch,2)
        newExp.epoch(epochN).scaledTrack = newExp.epoch(epochN).track;
        xSegs = newExp.epoch(epochN).track(:,1,:);
        ySegs = newExp.epoch(epochN).track(:,2,:);
        newExp.epoch(epochN).scaledTrack(:,1,:) = (xSegs-xMiddle).*scaleToMM;
        newExp.epoch(epochN).scaledTrack(:,2,:) = (ySegs).*scaleToMM;
        % Add velocities
        newExp.epoch(epochN).velocity(:,:,:) = cat(1,zeros(1,2,8),...
            diff(newExp.epoch(epochN).scaledTrack(:,:,:),1,1)./...
            exp.acquisitionRate);
        % Concatenate into wholeTrack
        wholeTrack = cat(1,wholeTrack,newExp.epoch(epochN).track);
        wholeScaled = cat(1,wholeScaled,newExp.epoch(epochN).scaledTrack);
        wholeVelocity = cat(1,wholeVelocity,newExp.epoch(epochN).velocity);
    end
    
    newExp.wholeTrack = wholeTrack;
    newExp.wholeScaledTrack = wholeScaled;
    newExp.wholeVelocityTrack = wholeVelocity;