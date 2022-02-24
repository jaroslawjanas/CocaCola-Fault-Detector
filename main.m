clear all;
close all;
clc;

%% Dock the figure window and supress the fit to window warning
set(0, "DefaultFigureWindowStyle", "docked");
warning("off", "images:imshow:magnificationMustBeFitForDockedFigure");

%% Import functions
addpath("faults\");
addpath("utils\");

%% Folder paths

% path_to_folder = "./images/1-Underfilled";
% path_to_folder = "./images/1-NotUnderfilled";

% path_to_folder = "./images/2-Overfilled";
% path_to_folder = "./images/2-NotOverfilled";

% path_to_folder = "./images/3-Cap";
% path_to_folder = "./images/3-NoCap";

% path_to_folder = "./images/4-Label";
% path_to_folder = "./images/4-NoLabel";

% path_to_folder = "./images/5-LabelStraight";
% path_to_folder = "./images/5-LabelNotStraight";

% path_to_folder = "./images/6-Deformed";
% path_to_folder = "./images/6-NotDeformed";

% path_to_folder = "./images/7-MiddleBottle";
% path_to_folder = "./images/7-NoMiddleBottle";

% path_to_folder = "./images/8-LabelPrint";
% path_to_folder = "./images/8-NoLabelPrint";

% path_to_folder = "./images/All";

path_to_folder = uigetdir("Select image folder");

%% Paths of imgs in the folder
input_imgs_paths = dir(fullfile(path_to_folder, "*.jpg"));
total_img_count = length(input_imgs_paths);
% Randomise for debugging purposes
r_input_imgs_paths = input_imgs_paths(randperm(total_img_count));

%% Stats
missing = 0;
straight = 0;
caps = 0;
overfilled = 0;
underfilled = 0;
labelled = 0;
labelPrint = 0;
deformed = 0;
% goodBottles = 0;
% badBottles = 0;

%% Loop over the images
for current_img = 1 : length(r_input_imgs_paths)
    img_path = fullfile(path_to_folder, r_input_imgs_paths(current_img).name);
    img = imread(img_path);
    img = imcrop(img,[100 0 160 288]); % Aprox cropping
    img = rgb2gray(img); % I didn't end up using any specific colour channels

    if isBottleMissing(img)
        missing = missing + 1;
        continue;
    end
    
    %% Crop the middle bottle perfectly
    img = bottleCrop(img);
    
    %% Good and Bad bottle counter (implemented at the end)
%     if hasCap(img) && ~isOverfilled(img) && ~isUnderfilled(img) ...
%             && ~isDeformed(img) && hasLabel(img) ...
%             && isLabelStraight(img) && isLabelPrint(img)
%         goodBottles = goodBottles + 1;
%     else
%         badBottles = badBottles + 1;
%     end

    %% Detection pipeline
    caps = caps + hasCap(img);
    overfilled = overfilled + isOverfilled(img);
    underfilled = underfilled + isUnderfilled(img);
    deformed = deformed + isDeformed(img);
    
    if hasLabel(img)
        labelled = labelled + 1;
        straight = straight + isLabelStraight(img);
        labelPrint = labelPrint + isLabelPrint(img);
    end

end

%% Display results
disp("Underfilled: " + underfilled + "/" + total_img_count + ...
    "  (" + underfilled * 100 / total_img_count + "%)");

disp("Overfilled: " + overfilled + "/" + total_img_count + ...
    "  (" + overfilled * 100 / total_img_count + "%)");

disp("Bottle Cap: " + caps + "/" + total_img_count + ...
    "  (" + caps * 100 / total_img_count + "%)");

disp("Labelled: " + labelled + "/" + total_img_count + ...
    "  (" + labelled * 100 / total_img_count + "%)");

disp("Straight Label: " + straight + "/" + total_img_count + ...
    "  (" + straight * 100 / total_img_count + "%)");

disp("Deformed: " + deformed + "/" + total_img_count + ...
    "  (" + deformed * 100 / total_img_count + "%)");

disp("Missing: " + missing + "/" + total_img_count + ...
    "  (" + missing * 100 / total_img_count + "%)");

disp("Label Print: " + labelPrint + "/" + total_img_count + ...
    "  (" + labelPrint * 100 / total_img_count + "%)");

% disp("Good Bottles: " + goodBottles + "/" + (goodBottles + badBottles) + ...
%     "  (" + goodBottles * 100 / (goodBottles + badBottles) + "%)");
% 
% disp("Bad Bottles: " + badBottles + "/" + (goodBottles + badBottles) + ...
%     "  (" + badBottles * 100 / (goodBottles + badBottles) + "%)");

%% Undock the figure window
set(0, "DefaultFigureWindowStyle", "normal");