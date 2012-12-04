function saveMultiPage(figList,fileName, landscape)


if exist(fileName) 
    delete(fileName);
end
for figN = 1:size(figList,2)
    
    tempFilename = [num2str(figN),'.pdf'];
    
    figure(figList(figN));
   
        set(gcf, 'Color', 'white');
        set(gcf, 'InvertHardcopy','off');
        set(gcf,'Units','pixels');
        scnsize = get(0,'ScreenSize');
        set(gcf,'Position',[1 1 scnsize(3) scnsize(4)]);
        set(gcf, 'PaperUnits', 'inches');
        if landscape(figN)
            set(gcf, 'PaperSize', [11 8.5])
            set(gcf, 'PaperPosition', [0 0 11 8.5]);
        else
            set(gcf, 'PaperSize', [8.5 11])
            set(gcf, 'PaperPosition', [0 0 8.5 11]);
        end
    if figN == 1    
        print(gcf, '-dpdf','-r300',fileName);
    else
        print(gcf, '-dpdf','-r300',tempFilename);
        append_pdfs(fileName, tempFilename);
        delete(tempFilename);
    end    
    
end