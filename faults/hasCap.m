function [out] = hasCap(img)

    % Crop out the cap
    I = imcrop(img, [30 0 65 55]);
    
    % Histogram with 6 bins, where bin no. 3 captures the cap
    Z = imhist(I, 6);
    
    % Chosen threshold value
    if Z(3) > 1000
        out = 1;
    else
        out = 0;
    end

end