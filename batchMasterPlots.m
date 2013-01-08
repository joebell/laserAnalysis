function batchMasterPlots()

% laserMasterPlots(plotTitle, expList, useEpochs, useLanes, fileName)

% laserMasterPlots('121004a - ChR-wt 25%ND 3do', 1612:1659, [2,4], [1,3,5,7], '121004a-ChR-wt.pdf');
% laserMasterPlots('121004a - ChR-83b 25%ND 3do', 1612:1659, [2,4], [2,4,6,8], '121004a-ChR-83b.pdf');
% laserMasterPlots('121004b - ChR-wt 25%ND 3do', 1660:1731, [2,4], [1,3,5,7], '121004b-ChR-wt.pdf');
% laserMasterPlots('121004b - ChR-83b 25%ND 3do', 1660:1731, [2,4], [2,4,6,8], '121004b-ChR-83b.pdf');
% 
% laserMasterPlots('121005 - ChR-wt 25%ND 3do', 1732:1779, [2,4], [1,3,5,7], '121005-ChR-wt.pdf');
% laserMasterPlots('121005 - ChR-83b 25%ND 3do', 1732:1779, [2,4], [2,4,6,8], '121005-ChR-83b.pdf');
% 
% laserMasterPlots('121008a - ChR-wt 25%ND 6do',  1780:1851, [2,4], [1,3,5,7], '121008a-ChR-wt.pdf');
% laserMasterPlots('121008a - ChR-83b 25%ND 6do', 1780:1851, [2,4], [2,4,6,8], '121008a-ChR-83b.pdf');
% laserMasterPlots('121008b - ChR-wt 25%ND 5do',  1852:1923, [2,4], [1,3,5,7], '121008b-ChR-wt.pdf');
% laserMasterPlots('121008b - ChR-83b 25%ND 5do', 1852:1923, [2,4], [2,4,6,8], '121008b-ChR-83b.pdf');
% 
% laserMasterPlots('121009 - ChR-83b 6do', 1924:1995, [2,4], [1:8], '121009-ChR-83b.pdf');
% 
% laserMasterPlots('121011 - ChR-wt 2do',  1996:2067, [2,4], [1,3,5,7], '121011-ChR-wt.pdf');
% laserMasterPlots('121011 - ChR-42b 2do', 1996:2067, [2,4], [2,4,6,8], '121011-ChR-42b.pdf');
% 
% laserMasterPlots('121015a - ChR-wt 6do',  2068:2141, [2,4], [1,3,5,7], '121015a-ChR-wt.pdf');
% laserMasterPlots('121015a - ChR-42b 6do', 2068:2141, [2,4], [2,4,6,8], '121015a-ChR-42b.pdf');
% laserMasterPlots('121015b - ChR-wt 6do',  2142:2213, [2,4], [1,3,5,7], '121015b-ChR-wt.pdf');
% laserMasterPlots('121015b - ChR-42b 6do', 2142:2213, [2,4], [2,4,6,8], '121015b-ChR-42b.pdf');
% 
% laserMasterPlots('121016a - ChR-83b 9do unstarved', 2214:2285, [2,4], [1,3,5,7], '121016a-ChR-83b-unst.pdf');
% laserMasterPlots('121016a - ChR-83b 9do starved',   2214:2285, [2,4], [2,4,6,8], '121016a-ChR-83b-star.pdf');
% laserMasterPlots('121016b - NorpA/y; ChR/+ ; ChR/+ 9do 0%ND', 2286:2357, [2,4], [1,3,5,7], '121016b-ChR-wt.pdf');
% laserMasterPlots('121016b - wtD 9do 0%ND'                   , 2286:2357, [2,4], [2,4,6,8], '121016b-wtD.pdf');
% 
% laserMasterPlots('121017 - ChR-83b 9do Humid', 2358:2533, [2,4], [1:8], '121017-ChR-83b-Humid.pdf');
% 
% laserMasterPlots('121022a - ChR-42b 7do Humid', 2534:2633, [2,4], [1:8], '121022a-ChR-42b-Humid.pdf');
% laserMasterPlots('121022b - ChR-42b 7do Humid', 2634:2753, [2,4], [1:8], '121022b-ChR-42b-Humid.pdf');
 
% laserMasterPlots('121023a - ChR-42b 8do Dry', 2754:2825, [2,4], [1:8], '121023a-ChR-42b-Dry.pdf');
% laserMasterPlots('121023b - ChR-42b 8do Dry', 2826:2925, [2,4], [1:8], '121023b-ChR-42b-Dry.pdf');
% 
% laserMasterPlots('121024a - ChR-42b 9do Humid', 2926:3025, [2,4], [1:8], '121024a-ChR-42b-Humid.pdf');
% laserMasterPlots('121024b - ChR-wt 9do Humid',  3026:3145, [2,4], [1:8], '121024b-ChR-wt-Humid.pdf');
% 
% laserMasterPlots('121025 - ChR-wt 10do Dry', 3146:3205, [2,4], [1:8], '121025-ChR-wt-Dry.pdf');
% 
% laserMasterPlots('121026 - NorpA unstaged Humid', 3206:3265, [2,4], [1:8], '121026-NorpA-Humid.pdf');
% 
% laserMasterPlots('121030a - ChR-22a 9do Dry',   3266:3355, [2,4], [1:8], '121030a-ChR-22a-Dry.pdf');
% laserMasterPlots('121030b - ChR-22a 9do Humid', 3356:3475, [2,4], [1:8], '121030b-ChR-22a-Humid.pdf');
% 
% laserMasterPlots('121031a - ChR-10a 9do Dry',   3476:3565, [2,4], [1:8], '121031a-ChR-10a-Dry.pdf');
% laserMasterPlots('121031b - ChR-10a 9do Humid', 3566:3685, [2,4], [1:8], '121031b-ChR-10a-Humid.pdf');
% 
% laserMasterPlots('121101a - ChR-42a 7do Dry',   3686:3775, [2,4], [1:8], '121101a-ChR-42a-Dry.pdf');
% laserMasterPlots('121101b - ChR-42a 7do Humid', 3776:3895, [2,4], [1:8], '121101b-ChR-42a-Humid.pdf');

%laserMasterPlots('121214 - NorpA^7',returnFileList('122914-101238'),2,1:8,'121214-NA.pdf');
%laserMasterPlots('121217 - NorpA^7',returnFileList('121217-'),2,1:8,'121217-NA.pdf');
%laserMasterPlots('121218 - ChR-83b',returnFileList('121218-133500'),2,1:8,'121218-83b.pdf');
%laserMasterPlots('121219a - NAChR-Ctrl',returnFileList('121219-09'),2,1:8,'121219-A.pdf');
%laserMasterPlots('121219b - NAChR-Ctrl',returnFileList('121219-10'),2,1:8,'121219-B.pdf');
%laserMasterPlots('121219c - NAChR-Ctrl',returnFileList('121219-12'),2,1:8,'121219-C.pdf');
%laserMasterPlots('121219d - NAChR-Ctrl',returnFileList('121219-13'),2,1:8,'121219-D.pdf');
%laserMasterPlots('121219e - NAChR-Ctrl',returnFileList('121219-15'),2,1:8,'121219-E.pdf');
%laserMasterPlots('121219f - NAChR-Ctrl',returnFileList('121219-160'),2,1:8,'121219-F.pdf');
%laserMasterPlots('121219g - NAChR-Ctrl',returnFileList('121219-165'),2,1:8,'121219-G.pdf');

%laserMasterPlots('121229 - ChR-83b',returnFileList('121229-'),2,1:8,'121229-83b.pdf');
%laserMasterPlots('121230 - ChR-83b',returnFileList('121230-'),2,1:8,'121230-83b.pdf');
%laserMasterPlots('121231 - ChR-83b',returnFileList('121231-'),2,1:8,'121231-83b.pdf');

laserMasterPlots('130102 - ChR-83b',returnFileList('130102-083000-'),2,1:8,'130102-83b.pdf');
laserMasterPlots('130102b - ChR-Ctrl',returnFileList('130102-172600-'),2,1:8,'130102b-Ctrl.pdf');
laserMasterPlots('130103a - ChR-42b',returnFileList('130103-072200-'),2,1:8,'130103a-42b.pdf');
laserMasterPlots('130103b - ChR-82a',returnFileList('130103-151600-'),2,1:8,'130103b-82a.pdf');
laserMasterPlots('130103c - ChR-92a',returnFileList('130103-230000-'),2,1:8,'130103c-92a.pdf');
laserMasterPlots('130104 - ChR-Ctrl',returnFileList('130104-'),2,1:8,'130104-Ctrl.pdf');
laserMasterPlots('130107a - ChR-67b',returnFileList('130107-082000-'),2,1:8,'130107a-67b.pdf');
laserMasterPlots('130107b - ChR-67d',returnFileList('130107-160300'),2,1:8,'130107b-67d.pdf');
laserMasterPlots('130108 - ChR-10a',returnFileList('130108-'),2,1:8,'130108-10a.pdf');

laserMasterPlots('130102  - ChR-83b Abr.',  returnAbbreviatedFileList('130102-083000-',3*14),2,1:8,'130102-83b-Abr.pdf');
laserMasterPlots('130102b - ChR-Ctrl Abr.', returnAbbreviatedFileList('130102-172600-',3*14),2,1:8,'130102b-Ctrl-Abr.pdf');
laserMasterPlots('130103a - ChR-42b Abr.',  returnAbbreviatedFileList('130103-072200-',3*14),2,1:8,'130103a-42b-Abr.pdf');
laserMasterPlots('130103b - ChR-82a Abr.',  returnAbbreviatedFileList('130103-151600-',3*14),2,1:8,'130103b-82a-Abr.pdf');
laserMasterPlots('130103c - ChR-92a Abr.',  returnAbbreviatedFileList('130103-230000-',3*14),2,1:8,'130103c-92a-Abr.pdf');
laserMasterPlots('130104  - ChR-Ctrl Abr.', returnAbbreviatedFileList('130104-'       ,3*14),2,1:8,'130104-Ctrl-Abr.pdf');
laserMasterPlots('130107a - ChR-67b Abr.',  returnAbbreviatedFileList('130107-082000-',3*14),2,1:8,'130107a-67b-Abr.pdf');
laserMasterPlots('130107b - ChR-67d Abr.',  returnAbbreviatedFileList('130107-160300-',3*14),2,1:8,'130107b-67d-Abr.pdf');
laserMasterPlots('130108  - ChR-10a Abr.',  returnAbbreviatedFileList('130108-'       ,3*14),2,1:8,'130108-10a-Abr.pdf');



%softReset();
%startTracking;


