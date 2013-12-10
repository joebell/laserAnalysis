classdef RTFWForm1 < formFig
    
    methods 
        function FF = RTFWForm1()
            FF.renderer = @highResPDF;
            FF.setTitle('RTFWForm1 Title');
            FF.gridExtent = [4,7];
            offsetVal = [0 1 0 1]*0;
                FF.addPanel([1 1 2 2]+offsetVal);
                FF.addPanel([2 1 3 2]+offsetVal);
                FF.addPanel([3 1 4 2]+offsetVal);
            offsetVal = [0 1 0 1]*1;
                FF.addPanel([1 1 2 2]+offsetVal);
                FF.addPanel([2 1 3 2]+offsetVal);
                FF.addPanel([3 1 4 2]+offsetVal);
            offsetVal = [0 1 0 1]*2;
                FF.addPanel([1 1 2 2]+offsetVal);
                FF.addPanel([2 1 3 2]+offsetVal);
                FF.addPanel([3 1 4 2]+offsetVal);
            offsetVal = [0 1 0 1]*3;
                FF.addPanel([1 1 2 2]+offsetVal);
                FF.addPanel([2 1 3 2]+offsetVal);
                FF.addPanel([3 1 4 2]+offsetVal);  
                
            FF.addPanel([1 5 4 7]);
        end
    end
end