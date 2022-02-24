function [out] = isUnderfilled(img)

    %% Crop out the area below the normal fill level
    % but above the label
    I = imcrop(img, [20, 135, (size(img, 2) - 40) , 50]);
%     imshow(I);
%     pause(0.3);

    %% Get a histogram with 3 bins
    Z = imhist(I, 3);

    %% Chosen threshold value
    if Z(1) < 2000
        out = 1;
    else
        out = 0;
    end

end