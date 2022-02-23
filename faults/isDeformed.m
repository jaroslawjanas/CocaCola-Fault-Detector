function [out] = isDeformed(img)

    %% Vertical cropping
    I = imcrop(img, [0, 60, size(img, 2), 120]);

    %% Getting rid of some noise, high freq not needed anyway
    I = imgaussfilt(I, 1.2); 
    
    %% Crop out left side
    I1 = imcrop(I, [0, 0, 30, size(I, 1)]);

    %% Crop out right side and mirror it (flip on the vertical axis)
    I2 = imcrop(I, [(size(I, 2)-29), 0, 30, size(I, 1)]);
    I2 = flip(I2 ,2);

%     dI = imsubtract(I1, I2); % Not enough control over the process

    %% Normalize 0-1, subtract and square the error
    % Only interested in big differences, small difference is mostly noise
    % Note, converting uint8 to doubles to preseve negative values
    dI = (double(I1)/255 - double(I2)/255).^2;

    %% Sum everything togehter
    % this is faster than sum(dI, "all")
    dS = sum(dI(:));

    %% Based on a chosed symetry threshold return a true/false
    if dS > 115
        out = 1;
    else
        out = 0;
    end

end