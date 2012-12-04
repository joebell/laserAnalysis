% pretty.m
% 
%
%         by: david schoppik
%       date: 12-18-02
%    purpose: to return a pretty color
%
%      usage: pretty(colorstring)
%             use in a plot statement following 'Color' as in
%             plot(x,y,'Color',pretty(colorvalue));
%
%   k - black      y - yellow     m - magenta    c - cyan
%   r - red        g - green      b - blue       a - apple green
%   d - dk gray    e - evergreen  f - fuschia    h - honey
%   i - indigo     j - jade       l - lilac      n - nutbrown
%   p - pink       q - kumquat    s - sky blue   t - tan
%   u - umber      v - violet     z - lt. grey   w - white
%
%   shamelessly "adapted" from "Arrow3.m"
% 
%   4-3-3 : Javier (the colorblind) says good colors for him are
%           the following: y g i p u b

function colorvalue = pretty(colorStringOrIndex)

if nargin == 0
  colorvalue = [0 0 0];
  help pretty
  return
end

colorvalue = [0 0 0];

%   k - black      y - yellow     m - magenta    c - cyan
cn=[0.00,0.00,0.00;1.00,1.00,0.00;1.00,0.00,1.00;0.00,1.00,1.00;
%   r - red        g - green      b - blue       a - apple green
    1.00,0.00,0.00;0.00,1.00,0.00;0.00,0.00,1.00;0.00,0.70,0.00;
%   d - dk gray    e - evergreen  f - fuschia    h - honey
    0.40,0.40,0.40;0.00,0.40,0.00;0.90,0.00,0.40;.85,0.65,0.00;
%   i - indigo     j - jade       l - lilac      n - nutbrown
    0.00,0.00,0.70;0.20,0.80,0.50;0.80,0.40,0.80;0.50,0.20,0.00;
%   p - pink       q - kumquat    s - sky blue   t - tan
    1.00,0.70,0.70;1.00,0.40,0.00;0.00,0.80,1.00;0.80,0.40,0.00;
%   u - umber      v - violet     z - lt. grey   w - white
    0.70,0.00,0.00;0.60,0.00,1.00;0.60,0.60,0.60;1.00,1.00,1.00;];

letters   = ['k','y','m','c','r','g','b','a','d','e','f','h','i','j','l','n','p','q','s','t','u','v','z','w'];
plotOrder = ['r','q','h','a','b','i','v','z','n','k','f','e','l','p','u','c','m','y','g','d','j','s','t','w'];

% check for a valid string and assign the colors appropriately

if isnumeric(colorStringOrIndex)
    colorStringOrIndex = plotOrder(colorStringOrIndex);
end

for i=1:length(letters)
    if colorStringOrIndex == letters(i);
        colorvalue = cn(i,:);
    end
end


  