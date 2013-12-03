function savePDF(filenameOut,varargin)

	if nargin > 1
		highRes = varargin{1};
	else
		highRes = false;
	end

        set(gcf, 'Color', 'white');
        set(gcf, 'InvertHardcopy','off');
        set(gcf,'Units','pixels');
        scnsize = get(0,'ScreenSize');
        set(gcf,'Position',[1 1 scnsize(3) scnsize(4)]);
        set(gcf, 'PaperUnits', 'inches');
        set(gcf, 'PaperSize', [11 8.5])
        set(gcf, 'PaperPosition', [0 0 11 8.5]);
	
	if highRes
        	print(gcf, '-dpdf','-r300',filenameOut);
	else
		print(gcf,'-dpdf',filenameOut);
	end
