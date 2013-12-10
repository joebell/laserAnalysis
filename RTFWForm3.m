classdef RTFWForm3 < formFig
    
    methods 
        function FF = RTFWForm3()
            FF.renderer = @highResPDF;
            FF.setTitle('RTFWForm3 Title');
            FF.gridExtent = [7,13];

            offsetVal = [0 0 0 0]; FF.addPanel([1 1 3 4]+offsetVal);
            offsetVal = [2 0 2 0]; FF.addPanel([1 1 3 4]+offsetVal);
            offsetVal = [4 0 4 0]; FF.addPanel([1 1 3 4]+offsetVal);
            
            offsetVal = [0 3 0 3]; FF.addPanel([1 1 4 4]+offsetVal);
            offsetVal = [3 3 3 3]; FF.addPanel([1 1 4 4]+offsetVal);
   
            for row = 7:9
                for col = 1:6
                    FF.addPanel([0 0 1 1]+[col row col row]);
                end
            end
            
            FF.addPanel([1 10 7 13]);     

        end
    end
end