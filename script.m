% script

expList = returnFileList('131124-100739-');
name = '131124-Gr21a';

dM = makeDataMatrix(expList,2); 
ASC = getStateTransitionCounts(expList(1:112),1:8,2);
compareStateTransitionModels(dM,ASC); title(name);
savePDF([name,'-STM.pdf']); close all;
transitionsThroughTime(ASC); title(name);
savePDF([name,'-T.pdf']); close all;

expList = returnFileList('131124-190203-');
name = '131124-Ir40a';

dM = makeDataMatrix(expList,2); 
ASC = getStateTransitionCounts(expList(1:112),1:8,2);
compareStateTransitionModels(dM,ASC); title(name);
savePDF([name,'-STM.pdf']); close all;
transitionsThroughTime(ASC); title(name);
savePDF([name,'-T.pdf']); close all;

return;


expList = returnFileList('131123-102032-');
name = '131123-Or42a';

dM = makeDataMatrix(expList,2); 
ASC = getStateTransitionCounts(expList(1:112),1:8,2);
compareStateTransitionModels(dM,ASC); title(name);
savePDF([name,'-STM.pdf']); close all;
transitionsThroughTime(ASC); title(name);
savePDF([name,'-T.pdf']); close all;

expList = returnFileList('131123-185824-');
name = '131123-Or82a';

dM = makeDataMatrix(expList,2); 
ASC = getStateTransitionCounts(expList(1:128),1:8,2);
compareStateTransitionModels(dM,ASC); title(name);
savePDF([name,'-STM.pdf']); close all;
transitionsThroughTime(ASC); title(name);
savePDF([name,'-T.pdf']); close all;





expList = returnFileList('130718-074930');
name = '130718-Gr21a';

dM = makeDataMatrix(expList,2); 
ASC = getStateTransitionCounts(expList(1:64),1:8,2);
compareStateTransitionModels(dM,ASC); title(name);
savePDF([name,'-STM.pdf']); close all;


expList = returnFileList('131107-100113-');
name = '131107-Gr21a';

dM = makeDataMatrix(expList,2); 
ASC = getStateTransitionCounts(expList(1:64),1:8,2);
compareStateTransitionModels(dM,ASC); title(name);
savePDF([name,'-STM.pdf']); close all;

expList = returnFileList('131112-154338');
name = '131112-Gr21a';

dM = makeDataMatrix(expList,2); 
ASC = getStateTransitionCounts(expList(65:128),1:8,2);
compareStateTransitionModels(dM,ASC); title(name);
savePDF([name,'-STM.pdf']); close all;

expList = returnFileList('131113-081841-');
name = '131113-Gr21a';

dM = makeDataMatrix(expList,2); 
ASC = getStateTransitionCounts(expList(65:128),1:8,2);
compareStateTransitionModels(dM,ASC); title(name);
savePDF([name,'-STM.pdf']); close all;

expList = returnFileList('131113-160252-');
name = '131113-Or83b';

dM = makeDataMatrix(expList,2); 
ASC = getStateTransitionCounts(expList(65:128),1:8,2);
compareStateTransitionModels(dM,ASC); title(name);
savePDF([name,'-STM.pdf']); close all;

expList = returnFileList('131114-075347-');
name = '131114-Or42b';

dM = makeDataMatrix(expList,2); 
ASC = getStateTransitionCounts(expList(65:128),1:8,2);
compareStateTransitionModels(dM,ASC); title(name);
savePDF([name,'-STM.pdf']); close all;

expList = returnFileList('131114-153336-');
name = '131114-Ctrl';

dM = makeDataMatrix(expList,2); 
ASC = getStateTransitionCounts(expList(65:128),1:8,2);
compareStateTransitionModels(dM,ASC); title(name);
savePDF([name,'-STM.pdf']); close all;

expList = returnFileList('131115-082259-');
name = '131115-Or22a';

dM = makeDataMatrix(expList,2); 
ASC = getStateTransitionCounts(expList(1:128),1:8,2);
compareStateTransitionModels(dM,ASC); title(name);
savePDF([name,'-STM.pdf']); close all;

expList = returnFileList('131115-160246-');
name = '131115-Or92a';

dM = makeDataMatrix(expList,2); 
ASC = getStateTransitionCounts(expList(1:128),1:8,2);
compareStateTransitionModels(dM,ASC); title(name);
savePDF([name,'-STM.pdf']); close all;

expList = returnFileList('131118-082031-');
name = '131118-Or22a';

dM = makeDataMatrix(expList,2); 
ASC = getStateTransitionCounts(expList(1:128),1:8,2);
compareStateTransitionModels(dM,ASC); title(name);
savePDF([name,'-STM.pdf']); close all;

expList = returnFileList('131118-161931-');
name = '131118-Or83b';

dM = makeDataMatrix(expList,2); 
ASC = getStateTransitionCounts(expList(17:80),1:8,2);
compareStateTransitionModels(dM,ASC); title(name);
savePDF([name,'-STM.pdf']); close all;

expList = returnFileList('131118-211908-');
name = '131118-Or22aB';

dM = makeDataMatrix(expList,2); 
ASC = getStateTransitionCounts(expList(17:80),1:8,2);
compareStateTransitionModels(dM,ASC); title(name);
savePDF([name,'-STM.pdf']); close all;

expList = returnFileList('131122-081610-');
name = '131122-Or82a';

dM = makeDataMatrix(expList,2); 
ASC = getStateTransitionCounts(expList(1:128),1:8,2);
compareStateTransitionModels(dM,ASC); title(name);
savePDF([name,'-STM.pdf']); close all;
transitionsThroughTime(ASC); title(name);
savePDF([name,'-T.pdf']); close all;

expList = returnFileList('131122-170337-');
name = '131122-Or10a';

dM = makeDataMatrix(expList,2); 
ASC = getStateTransitionCounts(expList(1:128),1:8,2);
compareStateTransitionModels(dM,ASC); title(name);
savePDF([name,'-STM.pdf']); close all;
transitionsThroughTime(ASC); title(name);
savePDF([name,'-T.pdf']); close all;














