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
%laserMasterPlots('130207 - Gr21aC',returnFileList('130207-075320-'),2,1:8,'130207-Gr21aC.pdf');
%laserMasterPlots('130211 - 56a3',returnFileList('130211-081006-'),2,1:8,'130211-56a3.pdf');
%laserMasterPlots('130212 - Gr21aBD Ramp',returnFileList('130212-092853-'),2,1:8,'130212-21aBD.pdf');
%laserMasterPlots('130213 - 67d,67b',returnFileList('130213-'),2,1:8,'130213-67d67b.pdf');
%laserMasterPlots('130214 - SNMP',returnFileList('130214-074306-'),2,1:8,'130214-SNMP.pdf');
%laserMasterPlots('130215 - 67d',returnFileList('130215-090637-'),2,1:8,'130215-67d.pdf');
%laserMasterPlots('130218a - 67b',returnFileList('130218-082120-'),2,1:8,'130218a-67b.pdf');
%laserMasterPlots('130218b - 10a',returnFileList('130218-161438-'),2,1:8,'130218b-10a.pdf');
%laserMasterPlots('130219a - 22a',returnFileList('130219-083449-'),2,1:8,'130219a-22a.pdf');
%laserMasterPlots('130219b - 42a',returnFileList('130219-124848-'),2,1:8,'130219b-42a.pdf');
%laserMasterPlots('130219c - 42b,22a',returnFileList('130219-223927-'),2,1:8,'130219c-42b22a.pdf');
%laserMasterPlots('130220 - 82a',returnFileList('130220-082330-'),2,1:8,'130220-82a.pdf');

%laserMasterPlots('130221 - 42b,67b',returnFileList('130221-140313-'),2,1:8,'130221-42b67b.pdf');
%laserMasterPlots('130221 - 42b,22a no air',returnFileList('130221-214131-'),2,1:8,'130221-42b22aNoAir.pdf');
%laserMasterPlots('130222 - 67d',returnFileList('130222-101053-'),2,1:8,'130222-67d.pdf');
%laserMasterPlots('130222 - 67d no air',returnFileList('130222-180350-'),2,1:8,'130222-67dNoAir.pdf');
%laserMasterPlots('130223 - 85a(II)',returnFileList('130223-110454-'),2,1:8,'130223-85aII.pdf');
%laserMasterPlots('130225 - Bl,Ir64a(III)',returnFileList('130225-082814-'),2,1:8,'130225-Ir64aIII.pdf');
%laserMasterPlots('130226 - 85a(III)',returnFileList('130226-090903-'),2,1:8,'130226-85aIII.pdf');

%laserMasterPlots('130227 - Ir64aX2',returnFileList('130227-101015-'),2,1:8,'130227-Ir64aX2.pdf');
%laserMasterPlots('130228 - Ir64a(II),TM2',returnFileList('130228-'),2,1:8,'130228-Ir64aII.pdf');
%laserMasterPlots('130301 - Bl,Ir64a(III)',returnFileList('130301-081755'),2,1:8,'130301-Ir64aIII.pdf');

%laserMasterPlots('130305 - 42b,92a',returnFileList('130305-093259-'),2,1:8,'130305-42b92a.pdf');
%laserMasterPlots('130306 - 22a',returnFileList('130306-080838-'),2,1:8,'130306-22a.pdf');

%laserMasterPlots('130311 - Gr63a-Gal4,TM2',returnFileList('130311-075444-'),2,1:8,'130311-Gr63a-TM2.pdf');
%laserMasterPlots('130312 - 7a(II)',returnFileList('130312-'),2,1:8,'130312-7aII.pdf');
%laserMasterPlots('130313 - Bl,Gr63a-Gal4',returnFileList('130313-084034-'),2,1:8,'130313-Bl-Gr63a.pdf');

%laserMasterPlots('130314 - Or7a-Gal4 (III)',returnFileList('130314-091059-'),2,1:8,'130314-7aIII.pdf');
%laserMasterPlots('130319 - Or42b-Gal4',returnFileList('130319-085212-'),2,1:8,'130319-42b.pdf');
%laserMasterPlots('130320 - Or83b-Gal4',returnFileList('130320-091728-'),2,[1,2,3,4,6,7,8],'130320-83b.pdf');
%laserMasterPlots('130321 - Or83b-Gal4',returnFileList('130321-092719-'),2,1:8,'130321-83b-HalfP.pdf');
%laserMasterPlots('130325 - Ctrl',returnFileList('130325-'),2,1:8,'130325-Ctrl.pdf');
%laserMasterPlots('130326 - Or92a-Gal4',returnFileList('130326-084240-'),2,1:8,'130326-92a.pdf');
%laserMasterPlots('130327 - Or83b-Gal4',returnFileList('130327-090228-'),2,1:8,'130327-83b.pdf');
%laserMasterPlots('130328 - Or42b-Gal4',returnFileList('130328-095119-'),2,1:8,'130328-42b.pdf');

%laserMasterPlots('130330 - Gr21a-Gal4 (Suh)',returnFileList('130330-'),2,1:8,'130330-Gr21aSuh.pdf');
%laserMasterPlots('130401 - Gr21a-Gal4 (Suh)',returnFileList('130401-085058-'),2,1:8,'130401-Gr21aSuh.pdf');
%laserMasterPlots('130402 - Gr21a-Gal4 (Suh) Long Spacing',returnFileList('130402-092620-'),2,1:8,'130402-Gr21aSuh.pdf');
%laserMasterPlots('130403 - Gr21a-Gal4 (Suh) No air',returnFileList('130403-085918-'),2,1:8,'130403-Gr21aSuh.pdf');

%list = returnFileList('130401-164753-');
%openLoopAvgPlots(list);
%saveTallPDF('130401-OL-Gr21a-Suh.pdf');
%close all;

%list = returnFileList('130403-062035-');
%openLoopAvgPlots(list);
%saveTallPDF('130402-OL-Gr21a-Suh.pdf');
%close all;

%list = returnFileList('130403-163946-');
%openLoopAvgPlots(list);
%saveTallPDF('130403-OL-Gr21a-Suh.pdf');
%close all;

%laserMasterPlots('130408 - 42b,92a 20Hz Pulses',returnFileList('130408-083743-'),2,1:8,'130408-42b92a-20Hz.pdf');
%laserMasterPlots('130409 - 22a 20 Hz Pulses', returnFileList('130409-0'),2,1:8,'130409-22a-20Hz.pdf');
%laserMasterPlots('130410 - Gr21a (Suh) 20 Hz Pulses', returnFileList('130410-'),2,1:8,'130410-Gr21a-20Hz.pdf');

%laserMasterPlots('130411 - 10a 20 Hz Pulses', returnFileList('130411-'),2,1:8,'130411-10a-20Hz.pdf');
%laserMasterPlots('130412 - 42a', returnFileList('130412-'),2,1:8,'130412-42a.pdf');
%laserMasterPlots('130415 - 42b,92a No ATR', returnFileList('130415-'),2,1:8,'130415-42b92a-NoATR.pdf');
%laserMasterPlots('130416 - 82a 20 Hz Pulses', returnFileList('130416-'),2,1:8,'130416-82a-20Hz.pdf');
%laserMasterPlots('130417 - 85a (II) 20 Hz Pulses', returnFileList('130417-'),2,1:8,'130417-85aII-20Hz.pdf');

%laserMasterPlots('130418 - 85a (II) 4 Hz Pulses No Air', returnFileList('130418-'),2,1:8,'130418-85aII-4Hz-NoAir.pdf');
%laserMasterPlots('130422 - 85a (II) 4 Hz Pulses', returnFileList('130422-'),2,1:8,'130422-85aII-4Hz.pdf');
%laserMasterPlots('130423 - Gr21a (Suh) 4 Hz Pulses', returnFileList('130423-'),2,1:8,'130423-Gr21a-4Hz.pdf');
%laserMasterPlots('130424 - 42b,92a 4 Hz Pulses', returnFileList('130424-'),2,1:8,'130424-42b92a-4Hz.pdf');

%laserMasterPlots('130425 - 42b,92a 4 Hz Pulses, Air from L only', returnFileList('130425-'),2,1:8,'130425-42b92a-4Hz-Lonly.pdf');
%laserMasterPlots('130426 - Gr21a (Suh) 4 Hz Pulses, Air from L only', returnFileList('130426-'),2,1:8,'130426-Gr21a-Suh-4Hz-Lonly.pdf');
%laserMasterPlots('130429 - 22a 4 Hz Pulses, Air from L only', returnFileList('130429-'),2,1:8,'130429-22a-4Hz-Lonly.pdf');
%laserMasterPlots('130430 - 42b, Varying Freq.', returnFileList('130430-'),2,1:8,'130430-42b-VaryFreq.pdf');
%laserMasterPlots('130501 - 42b Freq. Gradient', returnFileList('130501-'),2,1:8,'130501-42b-FreqGradient.pdf');

%laserMasterPlots('130502 - 42b Freq. Two Choice 5Hz', returnFileList('130502-'),2,1:8,'130502-42b-Freq.pdf');
%laserMasterPlots('130503 - 42b Freq. Two Choice 20Hz', returnFileList('130503-'),2,1:8,'130503-42b-Freq.pdf');
%laserMasterPlots('130506 - 42b Freq. Two Choice 5Hz, Air L', returnFileList('130506-'),2,1:8,'130501-42b-Freq.pdf');
%laserMasterPlots('130507 - 42b Freq. Gradient', returnFileList('130507-'),2,1:8,'130507-42b-Freq.pdf');
%laserMasterPlots('130508 - 42b Freq. Gradient, Air L', returnFileList('130508-'),2,1:8,'130508-42b-Freq.pdf');


%laserMasterPlots('130514 - Ctrl @ 4 Hz', returnFileList('130514-'),2,1:8,'130514-Ctrl-4Hz.pdf');
%laserMasterPlots('130607 - 42b H134R 20 Hz', returnFileList('130607-'),2,1:8,'130607-42b-H134R.pdf');
%laserMasterPlots('130610 - 85a H134R 20 Hz', returnFileList('130610-'),2,1:8,'130610-85a-H134R.pdf');
%laserMasterPlots('130611 - 92a H134R 20 Hz', returnFileList('130611-'),2,1:8,'130611-92a-H134R.pdf');
%laserMasterPlots('130612 - Gr21a H134R 20 Hz', returnFileList('130612-'),2,1:8,'130612-Gr21a-H134R.pdf');

%laserMasterPlots('130718 - Gr21a (Suh) H134R 20 Hz', returnFileList('130718-074930-'),2,1:8,'130718-Gr21a-H134R.pdf');
%laserMasterPlots('130719 - Gr21a (Suh) H134R 20 Hz', returnFileList('130719-'),2,1:8,'130719-Gr21a-H134R.pdf');

%laserMasterPlots('130722 - Gr21a (Suh) H134R 20 Hz Air L Only', returnFileList('130722-082015-'),2,1:8,'130722-Gr21a-H134R.pdf');
%laserMasterPlots('130723 - Gr21a (Suh) Training', returnFileList('130723-'),2,1:8,'130723-Gr21a-Training.pdf');
%laserMasterPlots('130723 - Gr21a (Suh) Trained',  returnFileList('130723-'),4,1:8,'130723-Gr21a-Trained.pdf');

%laserMasterPlots('130729 - 7a (II)', returnFileList('130729-'),2,1:8,'130729-7aII.pdf');
%laserMasterPlots('130729 - 7a (II) Abbr.', returnFileList('130729-114722-'),2,1:8,'130729-7aIIabbr.pdf');
%laserMasterPlots('130730 - 7a (II) Wind L', returnFileList('130730-084011-'),2,1:8,'130730-7aII.pdf');
%laserMasterPlots('130801 - 7a (II) No Wind', returnFileList('130801-'),2,1:8,'130801-7aII.pdf');

%laserMasterPlots('130802 - 56a (II) Wind L', returnFileList('130802-'),2,1:8,'130802-56aII.pdf');

%laserMasterPlots('130806 - Ctrl', returnFileList('130806-095217-'),2,1:8,'130806-Ctrl.pdf');
%laserMasterPlots('130806 - 42b No Wind', returnFileList('130806-183602-'),2,1:8,'130806-42b.pdf');
%laserMasterPlots('130807 - 42b', returnFileList('130807-102201-'),2,1:8,'130807-42b.pdf');
%laserMasterPlots('130807 - 56a (LV) No Wind', returnFileList('130807-183612-'),2,1:8,'130807-56a.pdf');

%laserMasterPlots('130813 - 42b,22a', returnFileList('130813-'),2,1:8,'130813-42b22a.pdf');
%laserMasterPlots('130820 - 67b', returnFileList('130820-'),2,1:8,'130820-67b.pdf');
%laserMasterPlots('130821 - 82a', returnFileList('130821-'),2,1:8,'130821-82a.pdf');

%laserMasterPlots('130826 - 83b 4 groups', returnFileList('130826-'),2,1:8,'130826-83b.pdf');
%laserMasterPlots('130827 - 42b 20 Hz', returnFileList('130827-'),2,1:8,'130827-42b.pdf');

%laserMasterPlots('130828 - 83b 4Hz', returnFileList('130828-125820-'),2,1:8,'130828-83b-4.pdf');
%laserMasterPlots('130828 - 83b 20Hz', returnFileList('130828-164900-'),2,1:8,'130828-83b-20.pdf');
%laserMasterPlots('130829 - 92a 4Hz', returnFileList('130829-'),2,1:8,'130829-92a.pdf');
%laserMasterPlots('130830 - 42b 4Hz', returnFileList('130830-'),2,1:8,'130830-42b.pdf');
%laserMasterPlots('130903 - 42b 4Hz #1', returnFileList('130903-082615-'),2,1:8,'130903-42b-1.pdf');
%laserMasterPlots('130903 - 42b 4Hz #2', returnFileList('130903-122030-'),2,1:8,'130903-42b-2.pdf');
%laserMasterPlots('130903 - 42b 4Hz #3', returnFileList('130903-142155-'),2,1:8,'130903-42b-3.pdf');
%laserMasterPlots('130903 - 42b 100Hz', returnFileList('130903-181902-'),2,1:8,'130903-42b-4.pdf');
%laserMasterPlots('130904 - 42b,92a 100Hz #1', returnFileList('130904-105043-'),2,1:8,'130904-42b92a-1.pdf');
%laserMasterPlots('130904 - 42b,92a 100Hz #2', returnFileList('130904-144909-'),2,1:8,'130904-42b92a-2.pdf');

%laserMasterPlots('130905 - 42b,82a 2Hz', returnFileList('130905-'),2,1:8,'130905-42b82a.pdf');
%laserMasterPlots('130909 - 42b Light 4 Hz', returnFileList('130909-'),2,1:8,'130909-42b.pdf');
%laserMasterPlots('130910 - 42b Dark 4 Hz', returnFileList('130910-090629-'),2,1:8,'130910-42b.pdf');
%laserMasterPlots('130911 - 42b Light 20 Hz', returnFileList('130911-'),2,1:8,'130911-42b.pdf');
%laserMasterPlots('130912 - 42b Dark 20 Hz', returnFileList('130912-'),2,1:8,'130912-42b.pdf');

% laserMasterPlots('130913 - 42b All Light 20 Hz', returnFileList('130913-'),2,1:8,'130913-42b.pdf');
% laserMasterPlots('130915 - 92a All Light 20 Hz ChR2T', returnFileList('130915-'),2,1:8,'130915-92a.pdf');
% laserMasterPlots('130916 - 92a All Light 100 Hz ChR2T', returnFileList('130916-'),2,1:8,'130916-92a.pdf');
%laserMasterPlots('130917 - 92a All Light 20 Hz ChR2T', returnFileList('130917-'),2,1:8,'130917-92a.pdf');
%laserMasterPlots('130918 - 92a All Light 20 Hz ChR2T', returnFileList('130918-'),2,1:8,'130918-92a.pdf');
% laserMasterPlots('130919 - 92a All Light +ATR 20 Hz ChR2T', returnFileList('130919-'),2,1:8,'130919-92a.pdf');
%laserMasterPlots('130920 - 42b,92a Dark +ATR 4 Hz H134R', returnFileList('130920-'),2,1:8,'130920-42b92a.pdf');
%laserMasterPlots('130923 - 42b,92a Dark +ATR 4 Hz H134R', returnFileList('130923-071023-'),2,1:8,'130923-42b92a.pdf');
%laserMasterPlots('130924 - 42b,92a Dark +ATR 20 Hz H134R', returnFileList('130924-080936-'),2,1:8,'130924-42b92a.pdf');
laserMasterPlots('130925 - 42b,92a Dark +ATR 20 Hz H134R', returnFileList('130925-082156-'),2,1:8,'130925-42b92a.pdf');




%softReset();
%startTracking;


