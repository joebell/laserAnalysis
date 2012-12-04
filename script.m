for col=1:3
    for row=1:3
        axesArray(col,row) = subplot(3,3,(row-1)*3 + col);
    end
end