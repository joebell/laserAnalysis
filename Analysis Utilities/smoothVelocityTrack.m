function smoothVel = smoothVelocityTrack(scaledTrack)

    sampleTime = .1;
    smoothSamples = 5;

    smoothTrack = smooth(scaledTrack,smoothSamples);  
    smoothVel = diff(smoothTrack)./sampleTime;