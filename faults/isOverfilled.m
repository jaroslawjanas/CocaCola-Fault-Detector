function [out] = isOverfilled(img)

    %% Crop out the area above normal fill level
    I = imcrop(img, [5, 60, 120, 80]);
    
    %% Get a histogram with 3 bins
    Z = imhist(I, 3);
    
    %% Chosen threshold value
    if Z(1) > 700
        out = 1;
    else
        out = 0;
    end

end