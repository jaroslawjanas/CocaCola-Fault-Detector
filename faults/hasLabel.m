function [out] = hasLabel(img)

    %% Crop out the label area
    I = imcrop(img, [0, 180, 161 , size(img, 1)-180]);

    %% Histogram with 3 bins, where bin no. 1 captures the label
    Z = imhist(I, 3);
    
    %% Chosen threshold value
    if Z(1) < 10000
        out = 1;
    else
        out = 0;
    end

end