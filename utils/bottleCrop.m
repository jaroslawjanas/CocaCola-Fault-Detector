% This function crops out the middle bottle from the img

function [out] = bottleCrop(img)

    % Measured variables (in pixels)
    bottleDiameter = 126;
    neckDiameter = 60;

    bottleRadius = bottleDiameter / 2;
    neckRadius = neckDiameter/2;

    % Crop the bottom part, we only want the neck of the bottle
    I = imcrop(img, [0, 0, size(img, 2), 140]);

    IS = sum(I, 1); % sum by col
    dIS = diff(IS); % differantiate

    %% Uncomment this to see the plot 
%     imshow(I);
%     hold on;
%     graph_only_IS = size(I, 1) ...
%         - ((IS - min(IS)) / (max(IS) - min(IS)) * size(I, 1));
%     plot(graph_only_IS, LineWidth=2);
%     dIS = diff(IS);
%     plot(diff(graph_only_IS) + 90, LineWidth=2)
%     pause;
%     hold off;

    [minValue, posMin] = min(dIS); % get min of dIS
    [maxValue, posMax] = max(dIS); % get max of dIS

    % We know the position of the neck of the bottle
    % but we want the whole bottle
    border1 = posMin - (bottleRadius - neckRadius);
    border2 = posMax + (bottleRadius - neckRadius);

    %% Uncomment this to see the image borders
%     imshow(img);
%     hold on;
%     xline(border1, LineWidth=2, Color="green");
%     xline(border2, LineWidth=2, Color="cyan");
%     pause;
%     hold off;

    % Crop the image using the calculated borders
    out = imcrop(img, [border1, 0, (border2 - border1), size(img, 1)]);
%     imshow(out);
end