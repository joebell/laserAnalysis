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

			forms = RTFWmakeFigures([sourceDir,figList(figN).name,'.fig']);
			forms{1}.allPDF([destDir,figList(figN).name,'.pdf']);
			forms{1}.close();

		end % if we're making PDFs
	end % for all the figures in the directory

		

