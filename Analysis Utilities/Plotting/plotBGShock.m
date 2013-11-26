function plotBGShock(originX, originY, lEpoch)

    for flyN = 1:8
        yAdj = -(flyN-1)*60;
        if (lEpoch == 1)
            h = fill([.5 1.5 1.5 .5].*60+originX,[0 0 30 30]+yAdj+originY,'g'); hold on;
            set(h,'EdgeColor','none','FaceColor','g','FaceAlpha',.3);

            h = fill([2 2.5 2.5 2].*60+originX,[0 0 -30 -30]+yAdj+originY,'b'); hold on;
            set(h,'EdgeColor','none','FaceColor','b','FaceAlpha',.3);
        elseif (lEpoch == -1)
			h = fill([.5 1.5 1.5 .5].*60+originX,[0 0 -30 -30]+yAdj+originY,'g'); hold on;
            set(h,'EdgeColor','none','FaceColor','g','FaceAlpha',.3);

            h = fill([2 2.5 2.5 2].*60+originX,[0 0 30 30]+yAdj+originY,'b'); hold on;
            set(h,'EdgeColor','none','FaceColor','b','FaceAlpha',.3);
        end
    end
