function equalizeAxes(varargin)

    if (nargin == 1)
        figure = varargin{1};
        xLims = [];
        yLims = [];
    elseif (nargin == 3)
        figure = varargin{1};
        xLims = varargin{2};
        yLims = varargin{3};
    end

    allAxes = get(figure,'Children');
    for axesN = 1:size(allAxes,1)
        Xlimits(axesN,:) = get(allAxes(axesN),'XLim');
        Ylimits(axesN,:) = get(allAxes(axesN),'YLim');
    end
    minX = min(Xlimits(:,1));
    maxX = max(Xlimits(:,2));
    minY = min(Ylimits(:,1));
    maxY = max(Ylimits(:,2));
    
    for axesN = 1:size(allAxes,1)
        if (isempty(xLims))
            set(allAxes(axesN),'XLim',[minX,maxX]);
        else
            set(allAxes(axesN),'XLim',xLims);
        end
        if (isempty(yLims))
            set(allAxes(axesN),'YLim',[minY,maxY]);
        else
            set(allAxes(axesN),'YLim',yLims);
        end
    end