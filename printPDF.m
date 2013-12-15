function printPDF()

	sourceDir = '~/PDF/';
	load([sourceDir,'printedList.mat']);

	% For removing from print list
	% printedList((end-5):end) = [];

	PDFlist = dir([sourceDir,'*.pdf']);

	for n=1:length(PDFlist)
		if nnz(ismember(printedList,PDFlist(n).name)) == 0
			disp(['Printing with: lpr ',sourceDir,PDFlist(n).name]);
			unix(['lpr ',sourceDir,PDFlist(n).name],'-echo');
			printedList{end+1} = PDFlist(n).name;
		end
	end

	save([sourceDir,'printedList.mat'],'printedList');


