function crunchPDF()

	sourceDir = '~/FigureOutput/';
	destDir = '~/PDF/';

	figList = dir([sourceDir,'*.fig']);
	PDFlist = dir([destDir,'*.pdf']);

    % Remove the file extensions so we can find exact matches
    for figN=1:length(figList)
        figList(figN).name = strrep(figList(figN).name,'.fig','');
    end
    for PDFN=1:length(PDFlist)
        PDFlist(PDFN).name = strrep(PDFlist(PDFN).name,'.pdf','');
    end

	for figN=1:length(figList)
		% Only crunch if there's not a matching PDF for the name
		if nnz(ismember({PDFlist.name},figList(figN).name)) == 0

            disp(['Crunching PDF: ',figList(figN).name,'.pdf']);

            % Make a temp PDF for each panel
            catCMD = 'pdftk ';
            handles = hgload([sourceDir,figList(figN).name,'.fig']);
            for panelN = 1:length(handles)
                figure(handles(panelN));
                set(handles(panelN),'Visible','on');
                if (panelN == 2)
                    savePDF('t2.pdf',true);
				elseif (panelN == 1)
					fixPlot1(handles(panelN));
					saveTallPDF(['t',num2str(panelN),'.pdf'],true);
                else
                    saveTallPDF(['t',num2str(panelN),'.pdf'],true);
                end
                catCMD = [catCMD,'t',num2str(panelN),'.pdf '];
				close(handles(panelN));
            end
            close all;


            
            % Concatenate them with pdftk
            catCMD = [catCMD,' cat output ',destDir,figList(figN).name,'.pdf'];
            unix(catCMD);

            % Remove the temp files
            for panelN = 1:length(handles);
                rmCMD = ['rm t',num2str(panelN),'.pdf'];
                unix(rmCMD);
            end

		end % if we're making PDFs
	end % for all the figures in the directory

		

