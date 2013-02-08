function plotStateTransitionsBLL(AllStateProbs, powerN, plotColor, leftOrRight)

	yScale = .15;

    fontSize = 6;
    Vspacing = .08;
    Hspacing = 3;
    labelAnnotation = false;
    
    %useLanes = 1:8;
    xBins = -25:1:25;
    xSpan = xBins(end) - xBins(1);
    nXBins = size(xBins,2);

    for fromState = 1:3
		for toState   = 1:3
		    
    

		    xOrigin = 0 + (fromState - 1)*(Hspacing + xBins(end)-xBins(1));
		    yOrigin = 0 + (toState - 1)*(-1 - Vspacing);
		  
		    line(xOrigin + [xBins(1) xBins(1) xBins(end) xBins(end) xBins(1)],...
		         yOrigin + [0 1 1 0 0],'Color','k');
		    hold on;
		    
			if (powerN == 1)
		    	probMatrix = squeeze(AllStateProbs(powerN,1,:,:,:) + AllStateProbs(powerN,2,:,:,:))./2;
			else
				probMatrix = squeeze(AllStateProbs(powerN,leftOrRight,:,:,:));
				%probMatrix = probMatrix + squeeze(AllStateProbs(powerN-1,leftOrRight,:,:,:));
				%probMatrix = probMatrix ./ 2;			
			end
			
			if (fromState == toState)
				plotSeq = probMatrix(fromState,:,toState)/yScale - (1-yScale)/yScale;
			else
				plotSeq = probMatrix(fromState,:,toState)/yScale;
			end
				
			ix = find((plotSeq < 0));
			plotSeq(ix) = 0;
			ix = find((plotSeq > 1));
			plotSeq(ix) = 1;
		    plot(xBins + xOrigin,yOrigin + plotSeq, 'Color',plotColor);			
 
		end
    end
    
    if labelAnnotation
        
        toState   = 1;
        fromState = 1; 
        xOrigin = 0 + (fromState - 1)*(Hspacing + xBins(end)-xBins(1));
        yOrigin = 0 + (toState - 1)*(-1 - Vspacing);
        text(xOrigin,yOrigin+1.1,['P( ... | \leftarrow',' )'],...
            'HorizontalAlignment','center');
        fromState = 2; 
        xOrigin = 0 + (fromState - 1)*(Hspacing + xBins(end)-xBins(1));
        yOrigin = 0 + (toState - 1)*(-1 - Vspacing);
        text(xOrigin,yOrigin+1.1,['P( ... | \oslash',' )'],...
            'HorizontalAlignment','center');
        fromState = 3; 
        xOrigin = 0 + (fromState - 1)*(Hspacing + xBins(end)-xBins(1));
        yOrigin = 0 + (toState - 1)*(-1 - Vspacing);
        text(xOrigin,yOrigin+1.1,['P( ... | \rightarrow',' )'],...
            'HorizontalAlignment','center');
        fromState = 1;
        toState = 1; 
        xOrigin = 0 + (fromState - 1)*(Hspacing + xBins(end)-xBins(1));
        yOrigin = 0 + (toState - 1)*(-1 - Vspacing);
        text(xOrigin -26,yOrigin+.5,['P( \leftarrow',' | ... )'],...
            'HorizontalAlignment','right');
        toState = 2; 
        xOrigin = 0 + (fromState - 1)*(Hspacing + xBins(end)-xBins(1));
        yOrigin = 0 + (toState - 1)*(-1 - Vspacing);
        text(xOrigin -26,yOrigin+.5,['P( \oslash',' | ... )'],...
            'HorizontalAlignment','right');
        toState = 3; 
        xOrigin = 0 + (fromState - 1)*(Hspacing + xBins(end)-xBins(1));
        yOrigin = 0 + (toState - 1)*(-1 - Vspacing);
        text(xOrigin-26,yOrigin+.5,['P( \rightarrow',' | ... )'],...
            'HorizontalAlignment','right');
        
        xOrigin = 0 + (fromState - 1)*(Hspacing + xBins(end)-xBins(1));
        yOrigin = 0 + (toState - 1)*(-1 - Vspacing);
        text(xOrigin-26,yOrigin,['0'],...
            'HorizontalAlignment','right');
        text(xOrigin-26,yOrigin+1,['1'],...
            'HorizontalAlignment','right');
        yOrigin = yOrigin - .15;
        ticLength = .05;
        line([-28 28],yOrigin + [0 0],'Color','k');
        line([-25 -25],yOrigin + ticLength.*[-1 1],'Color','k');
        line([25   25],yOrigin + ticLength.*[-1 1],'Color','k');
        line([0 0],yOrigin + ticLength.*[-1 1],'Color','k');

        text(-25,yOrigin - ticLength,['-25'],...
            'HorizontalAlignment','center','VerticalAlignment','top');
        text(0,yOrigin - ticLength,['0 mm'],...
            'HorizontalAlignment','center','VerticalAlignment','top');
        text(25,yOrigin - ticLength,['25'],...
            'HorizontalAlignment','center','VerticalAlignment','top');
        
    end
    
    xMin = -Hspacing + xBins(1) + (1 - 1)*(Hspacing + xBins(end)-xBins(1));
    xMax = Hspacing + xBins(end) + (3 - 1)*(Hspacing + xBins(end)-xBins(1));
    yMin = -Vspacing + 0 + (3 - 1)*(-1 - Vspacing);
    yMax =  Vspacing + 1 + (1 - 1)*(-1 - Vspacing);
    xlim([xMin xMax]);
    ylim([yMin yMax]);
    set(gca, 'XTick',[],'YTick',[],'ZTick',[]);
    set(gca,'Visible','off');
    set(gcf,'Color','w');
    
    if labelAnnotation
        lims = ylim();
        ylim([lims(1)-.4 lims(2)]);
    end
    
    
    
    
 
    

    
 
                            
                            
                            
                            
                            
                            
