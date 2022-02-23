function [out] = isBottleMissing(img)
    
    % Note, no need from any cropping since we are already
    % passig in the roughly cropped image (grayscale)

    %% Get an image histogram with 2 bins
    Z = imhist(img, 2);

    %% Chosen threshold value
    if Z(1) < 8000
        out = 1;
    else
        out = 0;
    end

end