classdef RTFWForm2 < formFig
    
    methods 
        function FF = RTFWForm2()
            FF.renderer = @highResPDF;
            FF.setTitle('RTFWForm2 Title');
            FF.gridExtent = [2,2];
            FF.setPaperSize([11 8.5]);
            FF.addPanel([1 1 2 2]);
        end
    end
end