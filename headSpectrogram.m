function headSpectrogram() 

timeSampleInterval = .02;

fileList = (4341+14*5):(4341+14*6-1);
fileList = 4341+14*5;

allData = [];

orderList = 1:size(fileList,2);
for order = orderList
    fileNum = fileList(order);
    loadData(fileNum);
    
    bodyXs = resample(exp.wholeTrack.bodyX,0:timeSampleInterval:exp.wholeTrack.bodyX.Time(end));
    bodyYs = resample(exp.wholeTrack.bodyY,0:timeSampleInterval:exp.wholeTrack.bodyY.Time(end));
    headXs = resample(exp.wholeTrack.headX,0:timeSampleInterval:exp.wholeTrack.headX.Time(end));
    headYs = resample(exp.wholeTrack.headY,0:timeSampleInterval:exp.wholeTrack.headY.Time(end));

    for flyN = 1:4
        
        bodyX = bodyXs.Data(:,flyN);
        bodyY = bodyYs.Data(:,flyN);
        headX = headXs.Data(:,flyN);
        headY = headYs.Data(:,flyN);
    
        time = 0:timeSampleInterval:exp.wholeTrack.bodyX.Time(end);
        dXdT = smoothVelocityTrack(bodyX);
        dYdT = smoothVelocityTrack(bodyY);
        
        angle = atan2(headY,headX);
        unwrappedAngle = unwrap(angle);
        lowPass = 10; % Hz
        sampleRate = 1/timeSampleInterval;
        [b a] = butter(2, lowPass/(sampleRate/2),'low');
        smoothUnwrapped = filtfilt(b,a,unwrappedAngle);
        dAdT = diff(smoothUnwrapped);
        smoothAngle = mod(smoothUnwrapped + pi,2*pi) - pi;
        
        allData = [allData; [bodyX+headX,bodyY+headY,[dXdT;0],[dYdT;0],angle,[dAdT;0]]];
        
        ix = find(abs(diff(smoothAngle)) > pi);
        smoothAngle(ix) = NaN;
        ix = find(abs(diff(angle)) > pi);
        angle(ix) = NaN;


        
            subplot(8,1,flyN*2 - 1);
            plot(time,bodyX,'b'); hold on;
            % plot(time,bodyY,'g');
            plot(time,[dAdT;0]*25/(pi*.05),'c');
            plot(time,smoothAngle*25/pi,'m');
            
            % plot(time,angle*25/pi,'r');
            xlim([0 time(end)]);
            ylim([-25 25]);
            
            subplot(8,1,flyN*2);
            nTimeBins = 400;
            freqBins = [.01:.01:lowPass];
            timeBin = round(size(time,2)/(nTimeBins/2))*2;
            [S, F, T, P] = spectrogram(dAdT,timeBin,timeBin/2,freqBins,1/timeSampleInterval);
            % P = log10(P);
            P = (P - min(P(:)))/(max(P(:)) - min(P(:)));
            P = (P - mean(P(:))) / (3*std(P(:))) + .5;
            colormap(jet);
            jimage(T,F,P,jet);
            xlim([0 time(end)]);
            ylim([freqBins(1) freqBins(end)]);
            caxis auto;
        
        
    end
    
end

