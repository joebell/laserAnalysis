function plotBG(originX, originY)

    for flyN = 1:8
        yAdj = -(flyN-1)*60;
        h = fill([1 3 3 1].*60+originX,[0 0 -30 -30]+yAdj+originY,'r'); hold on;
        set(h,'EdgeColor','none','FaceColor','r','FaceAlpha',.3);
        h = fill([4 6 6 4].*60+originX,[0 0 30 30]+yAdj+originY,'r'); hold on;
        set(h,'EdgeColor','none','FaceColor','r','FaceAlpha',.3);
    end