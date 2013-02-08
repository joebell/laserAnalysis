
%list = returnFileList('130121-091352-');
%dM83b = makeDataMatrix(list(15:end));
%list = returnFileList('130121-161700-');
%dM92a = makeDataMatrix(list(17:end));
%list = returnFileList('130122-091053-');
%dMCtrl = makeDataMatrix(list(14:end));
%list = returnFileList('130122-224253-');
%dM42a = makeDataMatrix(list(17:end));
%list1 = returnFileList('130123-092300-');
%list2 = returnFileList('130123-133715-');
%dM22a = makeDataMatrix([list1(17:end),list2(17:end)]);
%list = returnFileList('130123-201653-');
%dM42b67b = makeDataMatrix(list(17:end));

pQ = 'dTraveled';

laserPowerSeriesFlex(dM83b,1:8,pQ,20,pretty(5),false,false,false,true,true,false);
laserPowerSeriesFlex(dM92a,1:8,pQ,20,pretty(3),false,false,false,true,true,false);
laserPowerSeriesFlex(dMCtrl,1:8,pQ,20,'k',false,false,false,true,true,false);
laserPowerSeriesFlex(dM42a,1:8,pQ,20,pretty(4),false,false,false,true,true,false);
laserPowerSeriesFlex(dM42b67b,1:8,pQ,20,pretty(1),false,false,false,true,true,false);


return;



startNum = 19;

listCtrl1 = returnFileList('130102-172600-');
listCtrl2 = returnFileList('130104-090500-');
list10a1 = returnFileList('130108-1'); 
list10a2 = returnFileList('130110-1');
list22a = returnFileList('130109-'); 
list42b = returnFileList('130103-072200-');
list67b = returnFileList('130107-082000-');
list67d = returnFileList('130107-160300-');
list82a = returnFileList('130103-151600-');
list92a = returnFileList('130103-230000-');
list92aBlock1 = returnFileList('130111-09');
listCtrlBlock1 = returnFileList('130114-101500-');
list92aBlock2 = returnFileList('130115-095600-');
list83b = returnFileList('130102-083000-');

dMCtrl = makeDataMatrix( [listCtrl1(startNum:end),listCtrl2(startNum:end)] );
dM10a  = makeDataMatrix( [list10a1(startNum:end),list10a2(startNum:end)] );
dM22a  = makeDataMatrix( list22a(startNum:end) );
dM42b  = makeDataMatrix( list42b(startNum:end) );
dM67b  = makeDataMatrix( list67b(startNum:end) );
dM67d  = makeDataMatrix( list67d(startNum:end) );
dM82a  = makeDataMatrix( list82a(startNum:end) );
dM92a  = makeDataMatrix( list92a(startNum:end) );
dM92aB1 = makeDataMatrix( list92aBlock1 );
dMCtrlB1 = makeDataMatrix( listCtrlBlock1 );
dM92aB2 = makeDataMatrix( list92aBlock2 );
dM83b = makeDataMatrix(list83b);

dM92aB1a = makeDataMatrix( list92aBlock1(1:63) );     
dM92aB1b = makeDataMatrix( list92aBlock1(64:126) );     

dMCtrlB1a = makeDataMatrix( listCtrlBlock1(1:64) );
dMCtrlB1b = makeDataMatrix( listCtrlBlock1(65:128) );


laserPowerSeriesFlex(dMCtrl,1:8,'PI',20,'k'     ,false,false,false,true,true,false);
laserPowerSeriesFlex(dM10a,1:8,'PI',20,pretty(1),false,false,false,true,true,false);
laserPowerSeriesFlex(dM22a,1:8,'PI',20,pretty(2),false,false,false,true,true,false);
laserPowerSeriesFlex(dM42b,1:8,'PI',20,pretty(3),false,false,false,true,true,false);
laserPowerSeriesFlex(dM67b,1:8,'PI',20,pretty(4),false,false,false,true,true,false);
laserPowerSeriesFlex(dM67d,1:8,'PI',20,pretty(5),false,false,false,true,true,false);
laserPowerSeriesFlex(dM82a,1:8,'PI',20,pretty(6),false,false,false,true,true,false);
laserPowerSeriesFlex(dM92a,1:8,'PI',20,pretty(7),false,false,false,true,true,false);
