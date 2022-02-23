function [out] = isUnderfilled(img)

    %% Crop out the area below the normal fill level
    % but above the label
    I = imcrop(img, [40, 135, 80 , 50]);
    
    %% Get a histogram with 3 bins
    Z = imhist(I, 3);

    %% Chosen threshold value
    if Z(1) < 1700
        out = 1;
    else
        out = 0;
    end

end