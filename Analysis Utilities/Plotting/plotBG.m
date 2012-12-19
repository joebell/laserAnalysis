function plotBG(originX, originY, lEpoch)

    for flyN = 1:8
        yAdj = -(flyN-1)*60;
        if (lEpoch == 1)
            h = fill([1 3 3 1].*60+originX,[0 0 -30 -30]+yAdj+originY,'r'); hold on;
            set(h,'EdgeColor','none','FaceColor','r','FaceAlpha',.3);
        elseif (lEpoch == -1)
            h = fill([1 3 3 1].*60+originX,[0 0 30 30]+yAdj+originY,'r'); hold on;
            set(h,'EdgeColor','none','FaceColor','r','FaceAlpha',.3);
        end
    end