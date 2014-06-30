function printPDF(varargin)

	if (nargin > 0)
		reallyPrint = varargin{1};
	else
		reallyPrint = true;
	end
	
	if ~reallyPrint
		disp('Dry run - not actually printing:');
	end
		

	sourceDir = '~/PDF/';
	if size(dir([sourceDir,'printedList.mat'])) > 0
		load([sourceDir,'printedList.mat']);
	else
		printedList = {};
	end

	% For removing from print list
	% printedList((end-5):end) = [];

	PDFlist = dir([sourceDir,'*.pdf']);

	for n=1:length(PDFlist)
		if nnz(ismember(printedList,PDFlist(n).name)) == 0
			disp(['    Printing with: lpr ',sourceDir,PDFlist(n).name]);
			if reallyPrint
				unix(['lpr ',sourceDir,PDFlist(n).name],'-echo');
				printedList{end+1} = PDFlist(n).name;
			end
		end
	end

	save([sourceDir,'printedList.mat'],'printedList');


