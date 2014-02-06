%fLPP0  = returnFileList('131201-094854');

%dMPP0  = makeDataMatrix(fLPP0,2);

pQ = 'PI'; 

plotColor = 'r'; %dM = dMPP0;
laserPowerSeriesFlex(dM,1:8,pQ,20/4,plotColor,false,true,false,false,false,false);

%laserPowerSeriesFlex(dM,1:8,pQ,20/4,plotColor,false,false,false,true,true,false);
