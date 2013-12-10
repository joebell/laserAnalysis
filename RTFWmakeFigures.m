function forms = RTFWmakeFigures(fileName)

    h1 = figure('Visible','off'); % Ensure numbering
    h2 = figure('Visible','off'); % Ensure numbering
    h3 = figure('Visible','off'); % Ensure numbering
    h4 = figure('Visible','off'); % Ensure numbering

    f = figure('Visible','off');
    axesArray = hgload(fileName);
    titleString = get(axesArray(1),'String');
    
    close([h1,h2,h3,h4]); % Ensure numbering
    
    forms{1} = [RTFWForm1()];
    forms{1}.setTitle(titleString);
    forms{1}.setFileName(fileName);
    forms{1}.cloneAxesIn(axesArray([1:12]+1),1:12);
    forms{1}.cloneAxesIn(axesArray(14),13);
    
    forms{2} = [RTFWForm2()];
    forms{2}.setPrevPage(forms{1});
    forms{2}.setTitle(titleString);
    forms{2}.setFileName(fileName);
    forms{2}.cloneAxesIn(axesArray(21),1);
    
    forms{3} = RTFWForm3();
    forms{3}.setPrevPage(forms{2});
    forms{3}.setTitle(titleString);
    forms{3}.setFileName(fileName);
    forms{3}.cloneAxesIn(axesArray(15:17),1:3);
    forms{3}.cloneAxesIn(axesArray(18:19),4:5);
    forms{3}.cloneAxesIn(axesArray(38:55),6:23);
    forms{3}.cloneAxesIn(axesArray(56),24);
    
    forms{4} = RTFWForm4();
    forms{4}.setPrevPage(forms{3});
    forms{4}.setTitle(titleString);
    forms{4}.setFileName(fileName);
    forms{4}.cloneAxesIn(axesArray(34:37),1:4);
    forms{4}.cloneAxesIn(axesArray(24),8);
    forms{4}.cloneAxesIn(axesArray(57),5);
    forms{4}.cloneAxesIn(axesArray(58),6);
    forms{4}.cloneAxesIn(axesArray(59),9);
    forms{4}.cloneAxesIn(axesArray(60),10);
    forms{4}.cloneAxesIn(axesArray(20),7);
    forms{4}.cloneAxesIn(axesArray(25:33),11:19);
    
    delete(axesArray);
    close(f);
    
    figure(forms{4}.figHandle);
    figure(forms{3}.figHandle);
    figure(forms{2}.figHandle);
    figure(forms{1}.figHandle);