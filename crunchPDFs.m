function crunchPDFs()

baseName = '~/Desktop/Code/AnalysisFigures/';
outputDir = '~/Desktop/Code/PDFoutput/';
fileList = dir([baseName,'*.fig']);

for fileN = 1:length(fileList)

	fileName = fileList(fileN).name;
	figureHandles = hgload([baseName,fileName]);

	for figN = 1:length(figureHandles)
		
		figure(figureHandles(figN));
		saveTallPDF([num2str(figN),'.pdf']);
		
	end
	close all;

	cmd = ['pdftk'];
	for figN = 1:length(figureHandles)
		cmd = [cmd,' ',num2str(figN),'.pdf'];
	end
	cmd = [cmd,' cat output ',outputDir,fileName,'.pdf'];
	unix(cmd);
	
	for figN = 1:length(figureHandles)
		unix(['rm ',num2str(figN),'.pdf']);
	end

end



