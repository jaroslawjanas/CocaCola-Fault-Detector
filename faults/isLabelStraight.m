% Requires isAnyRowAll function - imported in main

function [out] = isLabelStraight(img)

    %% Crop out the label
    I = imcrop(img, [0, 150, size(img, 2) , size(img, 1) - 150]);

    %% Blur + Edge Detection
    BI = edge(I, "canny"); % Better than sobel and log

    %% Dilate the edges horizontally (to remove gaps)
%     se_horz = strel("line", 2, 0);
%     BI = imdilate(BI, se_horz);

    %% Dilate the edges vertically (to remove gaps and combat label curvature)
    se_vert = strel("line", 3, 90);
    BI = imdilate(BI, se_vert);

    %% Crop the top edge of the label
%     BI = imcrop(BI, [48, 20, 65, 30]);
    BI = imcrop(BI, [40, 20, size(BI, 2) - 80, 30]);

    %% Check if any row in the matrix is all 1s
    if isAnyRowAll(BI, 1)
        out = 1;
    else 
        out = 0;
    end

end
