function [numL,numR] = computeDecPI(scaledSeg)

    positionCategory = zeros(size(scaledSeg,1),1);
    
    cix = find((scaledSeg >= -5)&(scaledSeg <= 5));
    lix = find((scaledSeg < -5));
    rix = find((scaledSeg >  5));
    
    positionCategory(cix) =  0;
    positionCategory(lix) = -1;
    positionCategory(rix) =  1;
    
    thisSample = positionCategory(1:(end-1));
    nextSample = positionCategory(2:end);
    
    lDecIx = find((thisSample == 0)&(nextSample == -1));
    rDecIx = find((thisSample == 0)&(nextSample ==  1));
    numL = size(lDecIx,1);
    numR = size(rDecIx,1);
    
    
    
    