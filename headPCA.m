function headPCA()

timeSampleInterval = .1;

fileList = (4341+14*5):(4341+14*6-1);

allData = [];

orderList = 1:size(fileList,2);
for order = orderList
    fileNum = fileList(order);
    loadData(fileNum);
    
    bodyXs = resample(exp.wholeTrack.bodyX,0:timeSampleInterval:exp.wholeTrack.bodyX.Time(end));
    bodyYs = resample(exp.wholeTrack.bodyY,0:timeSampleInterval:exp.wholeTrack.bodyY.Time(end));
    headXs = resample(exp.wholeTrack.headX,0:timeSampleInterval:exp.wholeTrack.headX.Time(end));
    headYs = resample(exp.wholeTrack.headY,0:timeSampleInterval:exp.wholeTrack.headY.Time(end));

    for flyN = 1:8
        
        bodyX = bodyXs.Data(:,flyN);
        bodyY = bodyYs.Data(:,flyN);
        headX = headXs.Data(:,flyN);
        headY = headYs.Data(:,flyN);
    
        time = 0:timeSampleInterval:exp.wholeTrack.bodyX.Time(end);
        dXdT = smoothVelocityTrack(bodyX);
        dYdT = smoothVelocityTrack(bodyY);
        angle = atan2(headY,headX);
        unwrappedAngle = unwrap(angle);
        dAdT = diff(smooth(unwrappedAngle,5));
        
        allData = [allData; [bodyX+headX,bodyY+headY,[dXdT;0],[dYdT;0],angle,[dAdT;0]]];
        
        ix = find(abs(diff(angle)) > pi);
        angle(ix) = NaN;

        if (flyN == 1)
%             subplot(4,4,1:4);
%             plot(time,bodyX,'b'); hold on;
%             plot(time,bodyY,'g');
%             plot(time,angle*10,'r');
%             subplot(4,4,5:8);
%             plot(time,[dXdT;0],'b'); hold on;
%             plot(time,[dYdT;0],'g'); 
%             plot(time,[dAdT;0].*10,'m'); hold on;
            
        end
        
        
        
    end
    
end



% allData(:,[4,6]) = [];
zData = zscore(allData);
%zData = allData;
[coeff, scores, latent,tsquared,explained] = pca(zData);

disp(coeff);

% subplot(4,1,3:4);
% plot(time,scores(:,1),'r'); hold on;
% plot(time,scores(:,2),'g');
% plot(time,scores(:,3),'b');
% plot(time,scores(:,4),'m');
% 
% 
% figure();
% plot(cumsum(explained));
% 
% figure();
% colormap(hsv);
% scatter(scores(:,1),scores(:,2),4*ones(size(scores,1),1),scores(:,3));
% title('PCA');

% subplot(4,4,[9,10,11,13,14,15]);
subplot(1,5,1:4);
colormap(hsv);
scatter(allData(:,1),allData(:,2),ones(size(allData,1),1),allData(:,5));
xlabel('X (mm)');
ylabel('Y (mm)');

% Plot a colorwheel
hold on;
subplot(1,5,5);
rad = 1;
cover = .8;
angStep = .1;
for angle = -pi:angStep:pi
    h = fill([0 rad*cos(angle) rad*cos(angle+angStep)] ,[0 rad*sin(angle) rad*sin(angle+angStep)],angle);
    set(h,'EdgeColor','none'); hold on;
end
h = fill(cover*rad*cos([-pi:angStep:pi]),cover*rad*sin([-pi:angStep:pi]),[1 1 1]);
set(h,'EdgeColor','none'); hold on;
axis off;
axis equal;
text(0,0,'  Heading Angle','HorizontalAlignment','Center');



    
    
    
    
    
