% 
function jimage(XData,YData,CData,CMap)

% Set NaN's to midscale
ix = isnan(CData);
CData(ix) = .5;
% Scale image indexing to the colormap
cMax = size(CMap,1);
CData = round(CData*(cMax - 1)+1);
image('XData',XData,'YData',YData,'CData',CData);