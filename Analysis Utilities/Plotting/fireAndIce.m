% Plots a useful colormap
function fireAndIce = fireAndIce()

    fireAndIce = ones(256*2,3);
    for n=1:256
        fireAndIce(n,3) = 255;
        fireAndIce(n,2) = n-1;
        fireAndIce(n,1) = n-1;
    end
    for n = 1:256  
        fireAndIce(n+256,3) = 256-n;
        fireAndIce(n+256,2) = 256-n;
        fireAndIce(n+256,1) = 255;
    end
    fireAndIce = .95*fireAndIce./255;