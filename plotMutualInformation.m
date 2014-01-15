function I = plotMutualInformation(expList, useEpochs, useLanes)

    exp = 0; % Ensure compiler knows exp is a variable loaded from the data file

timeSampleInterval = .1;
% timeLags = [0:1:60,65:5:150];
timeLags = [0:1:10,20:10:150];

    for expNn = 1:size(expList,2)
        expN = expList(expNn);
        loadData(expN);
		[lEpoch, testPower] = leftOrRight(exp);
        laserPowers(expNn) = testPower;
    end
    powerList = unique(laserPowers);
    Npowers = size(powerList,2);


I = zeros(Npowers, size(timeLags,2),3,3);
% For each time lag
for timeLagN = 1:size(timeLags,2);  
    disp(['MI T: ',num2str(timeLagN)]);
    timeLag = timeLags(timeLagN);
    NC = zeros(Npowers, 3);
    NT = zeros(Npowers, 3);
    PC = zeros(Npowers, 3);
    PT = zeros(Npowers, 3);
    JC = zeros(Npowers, 3,3);
    JT = zeros(Npowers, 3,3);
    % Load all the files
    for expNn = 1:size(expList,2)
        expN = expList(expNn);
        loadData(expN);

		[lEpoch, testPower] = leftOrRight(exp);
        powerN = dsearchn(powerList',testPower);

        for laneN = useLanes
            for epochN = useEpochs
                bodyX = resample(exp.epoch(epochN).track.bodyX,0:timeSampleInterval:exp.epoch(epochN).track.bodyX.Time(end));
                headX = resample(exp.epoch(epochN).track.headX,0:timeSampleInterval:exp.epoch(epochN).track.headX.Time(end));
                tTrack = bodyX.Time;
                
                aTrack = bodyX.Data(:,laneN) + headX.Data(:,laneN);
                stateSequence = identifyStates(aTrack);
                nowSequence = stateSequence((1+timeLag):end);
                prevSequence = stateSequence(1:(end-timeLag));
                for nowState = 1:3
                    NC(powerN, nowState) = NC(powerN, nowState) + nnz(nowSequence == nowState);
                    NT(powerN, nowState) = NT(powerN, nowState) + size(nowSequence,1);
                end
                for prevState = 1:3
                    PC(powerN, prevState) = PC(powerN, prevState) + nnz(prevSequence == prevState);
                    PT(powerN, prevState) = PT(powerN, prevState) + size(prevSequence,1);
                end
                for nowState = 1:3
                    for prevState = 1:3
                        JC(powerN, nowState,prevState) = JC(powerN, nowState,prevState) + ...
                            nnz((nowSequence == nowState) & ...
                               (prevSequence == prevState));
                        JT(powerN, nowState,prevState) = JT(powerN, nowState,prevState) + size(prevSequence,1);                    
                    end
                end
            end
        end
    end
    
    % After we've cycled through all the experiments, collect the
    % probabilities
    % If timeLag = 0, show the self entropy
    if (timeLag == 0)
        for powerN = 1:Npowers
        for nowState = 1:3
            Pnow = NC(powerN, nowState) / NT(powerN, nowState);
            marginalI = Pnow * log2(1/Pnow);
            I(powerN, timeLagN,nowState,nowState) = I(powerN, timeLagN,nowState,nowState) + marginalI;
        end
        end
    else
        for powerN = 1:Npowers
        for nowState = 1:3
            for prevState = 1:3
                Pnow = NC(powerN, nowState)/NT(powerN, nowState);
                Pprev = PC(powerN, prevState)/PT(powerN, prevState);
                Pjoint = JC(powerN, nowState,prevState)/JT(powerN, nowState,prevState);

                marginalI = Pjoint*log2(Pjoint/(Pnow*Pprev));
%                 if marginalI < 0
%                     marginalI
%                     nowState
%                     prevState
%                     Pnow
%                     Pprev
%                     Pjoint
%                 end
                I(powerN, timeLagN,nowState,prevState) = I(powerN, timeLagN,nowState,prevState) + marginalI;
            end
        end
        end
    end

end

    % Plot it
    for powerN = 1:Npowers
        totalI = sum(sum(I(powerN,:,:,:),3),4);
        plot(-timeLags'./10, totalI,'Color',[powerN/Npowers 0 0]); hold on;
        line([-timeLags(1)./10,-timeLags(end)./10],[totalI(1) totalI(1)],...
            'LineStyle','--','Color',[powerN/Npowers 0 0]);
    end
    box on;
    xlabel('Time lag (sec)');
    ylabel('Mutual information with prior state (bits)');
        

        
        
