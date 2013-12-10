classdef RTFWForm4 < formFig
    
    methods 
        function FF = RTFWForm4()
            FF.renderer = @highResPDF;
            FF.setTitle('RTFWForm4 Title');

            FF.gridExtent = [7,21];

            FF.addPanel([1 1 4 3]);
            FF.addPanel([1 3 4 5]);
            FF.addPanel([1 5 4 7]);
            FF.addPanel([1 7 4 9]);
            
            FF.addPanel([1 9 4 13]);
            FF.addPanel([1 13 4 15]);
            FF.addPanel([1 15 4 21]);
            
            FF.addPanel([4 1 7 9]);
            FF.addPanel([4 9 7 13]);
            FF.addPanel([4 13 7 15]);
            


            %FF.addPanel([4 13 7 19]);
            for col = 0:2
                for row = 0:2
                    FF.addPanel([4+col 15+2*row 5+col 17+2*row]);
                end
            end

        end
    end
end