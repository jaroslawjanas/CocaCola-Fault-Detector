function [out] = isLabelPrint(img)

    %% Crop out the label area
    I = imcrop(img, [10, 177, size(img, 2)-20, 112]);
    
    %% Get a histogram with 4 bins
    Z = imhist(I, 4);

    %% Chosen threshold value
    if Z(4) < 6000
        out = 1;
    else
        out = 0;
    end

end