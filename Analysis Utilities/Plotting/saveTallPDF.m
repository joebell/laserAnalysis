function saveTallPDF(filenameOut)


        set(gcf, 'Color', 'white');
        set(gcf, 'InvertHardcopy','off');
        set(gcf,'Units','pixels');
        scnsize = get(0,'ScreenSize');
        set(gcf,'Position',[1 1 scnsize(3) scnsize(4)]);
        set(gcf, 'PaperUnits', 'inches');
        set(gcf, 'PaperSize', [8.5 11])
        set(gcf, 'PaperPosition', [0 0 8.5 11]);

        print(gcf, '-dpdf','-r300',filenameOut);
