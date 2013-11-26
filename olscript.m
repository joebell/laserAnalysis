% olscript.m


list = returnFileList('130304-');
openLoopAvgPlots(list);
saveTallPDF('OL-42b82a.pdf');
close all;

list = returnFileList('130307-');
openLoopAvgPlots(list);
saveTallPDF('OL-Gr21a-BD.pdf');
close all;






