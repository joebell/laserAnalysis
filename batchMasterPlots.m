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

%laserMasterPlots('130102 - ChR-83b',returnFileList('130102-083000-'),2,1:8,'130102-83b.pdf');
%laserMasterPlots('130102b - ChR-Ctrl',returnFileList('130102-172600-'),2,1:8,'130102b-Ctrl.pdf');
%laserMasterPlots('130103a - ChR-42b',returnFileList('130103-072200-'),2,1:8,'130103a-42b.pdf');
%laserMasterPlots('130103b - ChR-82a',returnFileList('130103-151600-'),2,1:8,'130103b-82a.pdf');
%laserMasterPlots('130103c - ChR-92a',returnFileList('130103-230000-'),2,1:8,'130103c-92a.pdf');
%laserMasterPlots('130104 - ChR-Ctrl',returnFileList('130104-'),2,1:8,'130104-Ctrl.pdf');
%laserMasterPlots('130107a - ChR-67b',returnFileList('130107-082000-'),2,1:8,'130107a-67b.pdf');
%laserMasterPlots('130107b - ChR-67d',returnFileList('130107-160300'),2,1:8,'130107b-67d.pdf');
%laserMasterPlots('130108 - ChR-10a',returnFileList('130108-'),2,1:8,'130108-10a.pdf');
%laserMasterPlots('130109 - ChR-22a',returnFileList('130109-'),2,1:8,'130109-22a.pdf');
%laserMasterPlots('130110 - ChR-10a',returnFileList('130110-'),2,1:8,'130110-10a.pdf');


%laserMasterPlots('130102  - ChR-83b Abr.',  returnAbbreviatedFileList('130102-083000-',3*14),2,1:8,'130102-83b-Abr.pdf');
%laserMasterPlots('130102b - ChR-Ctrl Abr.', returnAbbreviatedFileList('130102-172600-',3*14),2,1:8,'130102b-Ctrl-Abr.pdf');
%laserMasterPlots('130103a - ChR-42b Abr.',  returnAbbreviatedFileList('130103-072200-',3*14),2,1:8,'130103a-42b-Abr.pdf');
%laserMasterPlots('130103b - ChR-82a Abr.',  returnAbbreviatedFileList('130103-151600-',3*14),2,1:8,'130103b-82a-Abr.pdf');
%laserMasterPlots('130103c - ChR-92a Abr.',  returnAbbreviatedFileList('130103-230000-',3*14),2,1:8,'130103c-92a-Abr.pdf');
%laserMasterPlots('130104  - ChR-Ctrl Abr.', returnAbbreviatedFileList('130104-'       ,3*14),2,1:8,'130104-Ctrl-Abr.pdf');
%laserMasterPlots('130107a - ChR-67b Abr.',  returnAbbreviatedFileList('130107-082000-',3*14),2,1:8,'130107a-67b-Abr.pdf');
%laserMasterPlots('130107b - ChR-67d Abr.',  returnAbbreviatedFileList('130107-160300-',3*14),2,1:8,'130107b-67d-Abr.pdf');
%laserMasterPlots('130108  - ChR-10a Abr.',  returnAbbreviatedFileList('130108-'       ,3*14),2,1:8,'130108-10a-Abr.pdf');
%laserMasterPlots('130109  - ChR-22a Abr.',  returnAbbreviatedFileList('130109-'       ,3*14),2,1:8,'130109-22a-Abr.pdf');
%laserMasterPlots('130110  - ChR-10a Abr.',  returnAbbreviatedFileList('130110-'       ,3*14),2,1:8,'130110-10a-Abr.pdf');

%laserMasterPlots('130111 - ChR-92a',returnFileList('130111-090500-'),2,1:8,'130111-92a-blocked.pdf');
%list = returnFileList('130111-090500-');
%list1 = list(1:63); list2 = list(64:126);
%laserMasterPlots('130111 - ChR-92a - Pass1',list1,2,1:8,'130111-92a-blockedP1.pdf');
%laserMasterPlots('130111 - ChR-92a - Pass2',list2,2,1:8,'130111-92a-blockedP2.pdf');

%list = returnFileList('130114-101500-');
%list1 = list(1:64); list2 = list(65:128);
%laserMasterPlots('130114a - ChR-Ctrl - Pass1',list1,2,1:8,'130114a-Ctrl-blockedP1.pdf');
%laserMasterPlots('130114a - ChR-Ctrl - Pass2',list2,2,1:8,'130114a-Ctrl-blockedP2.pdf');

%list = returnFileList('130114-181520-');
%list1 = list(1:64); list2 = list(65:128);
%laserMasterPlots('130114b - ChR-22a - Pass1',list1,2,1:8,'130114b-22a-blockedP1.pdf');
%laserMasterPlots('130114b - ChR-22a - Pass2',list2,2,1:8,'130114b-22a-blockedP2.pdf');

%laserMasterPlots('130118 - ChR-42a',returnFileList('130118-093536-'),2,1:8,'130118-42a.pdf');

%laserMasterPlots('130121 - ChR-83b 30sec Trials',returnFileList('130121-091352-'),2,1:8,'130121-83bShort.pdf');
%laserMasterPlots('130121 - ChR-92a 30sec Trials',returnFileList('130121-215506-'),2,1:8,'130121-92aShort.pdf');
%laserMasterPlots('130122 - ChR-Ctrl 30sec Trials',returnFileList('130122-091053-'),2,1:8,'130122-CtrlShort.pdf');
%laserMasterPlots('130122 - ChR-92a Adapt. Recov.',returnFileList('130122-152336-'),2,1:8,'130122-92aAdaptRecov.pdf');
%laserMasterPlots('130122 - ChR-42a 30sec Trials',returnFileList('130122-224253-'),2,1:8,'130122-42aShort.pdf');
%laserMasterPlots('130123a - ChR-22a 30sec Trials 1',returnFileList('130123-092300-'),2,1:8,'130123a-22aShort1.pdf');
%laserMasterPlots('130123b - ChR-22a 30sec Trials 2',returnFileList('130123-133715-'),2,1:8,'130123b-22aShort2.pdf');
%laserMasterPlots('130123c - ChR-42b,67b 30sec Trials',returnFileList('130123-201653-'),2,1:8,'130123c-42b67bShort.pdf');
%laserMasterPlots('130124a - ChR-Ctrl 30sec Trials',returnFileList('130124-092512-'),2,1:8,'130124a-Ctrl.pdf');
%laserMasterPlots('130124b - ChR-42a 30sec Trials Randomized',returnFileList('130124-172812-'),2,1:8,'130124b-42aRand.pdf');
%laserMasterPlots('130125 - ChR-42a 2min Trials Randomized',returnFileList('130125-083800-'),2,1:8,'130125-42aRand2min.pdf');

%laserMasterPlots('130128 - 42b,82a',returnFileList('130128-083447-'),2,1:8,'130128-42b82a.pdf');
%laserMasterPlots('130129 - 10a,22a',returnFileList('130129-170614-'),2,1:8,'130129-10a22a.pdf');
%laserMasterPlots('130130a - 67d,22a',returnFileList('130130-004300-'),2,1:8,'130130a-67d22a.pdf');
%laserMasterPlots('130130b - 67d,82a',returnFileList('130130-094913-'),2,1:8,'130130b-67d82a.pdf');
%laserMasterPlots('130130c - 42b,67b',returnFileList('130130-174007-'),2,1:8,'130130c-42b67b.pdf');

%laserMasterPlots('130131a - 10a,67b',returnFileList('130131-091001-'),2,1:8,'130131a-10a67b.pdf');
%laserMasterPlots('130131b - 67d,22a',returnFileList('130131-165126-'),2,1:8,'130131b-67d22a.pdf');
%laserMasterPlots('130201 - 67d,22a',returnFileList('130201-092723-'),2,1:8,'130201-67d22a.pdf');
%laserMasterPlots('130204a - 56a3',returnFileList('130204-084500-'),2,1:8,'130204a-56a3.pdf');
%laserMasterPlots('130204b - 42b',returnFileList('130204-162940-'),2,1:8,'130204b-42b.pdf');
%laserMasterPlots('130205a - 56a2',returnFileList('130205-090414-'),2,1:8,'130205a-56a2.pdf');
%laserMasterPlots('130205b - 92a',returnFileList('130205-164316-'),2,1:8,'130205b-92a.pdf');
%laserMasterPlots('130206 - Gr21aBD',returnFileList('130206-083520-'),2,1:8,'130206-Gr21aBD.pdf');
laserMasterPlots('130207 - Gr21aC',returnFileList('130207-075320-'),2,1:8,'130207-Gr21aC.pdf');





%softReset();
%startTracking;


