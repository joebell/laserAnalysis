function fillHandle = joeArea(xVals, yBottom, yTop)

    fullX = [xVals,fliplr(xVals)];
    fullY = [yTop,fliplr(yBottom)];
    
    fillHandle = fill(fullX,fullY,'r');
