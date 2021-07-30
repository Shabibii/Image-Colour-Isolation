%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title:        Threshold Image for Road Sign Isolation
% Author:       Samir Habibi
% Rev. Date:    23/11/2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; % Delete all variables.
close all; % Close all windows.
clc; % Clear command window.

% Ask user for file by presenting options with menu() command.
fileChoice = menu('File', 'Road Signs', 'Choose own');

% Use switch() to read file based on user's choice (fileChoice).
switch (fileChoice)
    case 1
        filename = ('roadsigns.jpg');
        L = imread(filename);
    case 2
        filename = uigetfile('');
        L = imread(filename);
end % End the switch-statement after obtaining image.

% Create array for each color band in the original image, so 3 separate 2D
% arrays.
R = L(:,:,1);
G = L(:,:,2);
B = L(:,:,3);

% Check if the image's datatype is uint8, this is required for scaling
% later. Obtained from https://nl.mathworks.com/matlabcentral/fileexchange/26420-simplecolordetection
if strcmpi(class(L), 'uint8')
    % 256 levels
    eightBit = true;
else
    eightBit = false;
end

% Call methods for recognition and isolation of yellow features.
L_yellowFeatures = getYellowFeatures(L, R, G, B);
% Call methods for recognition and isolation of red features.
L_redFeatures = getRedFeatures(L, R, G, B);

figure;
% Maximize user screen for image plots.
set(gcf, 'Position', get(0, 'ScreenSize'));
% Display original image.
subplot(3, 4, 1);
imshow(L);
title('Input Image');

% Display histogram of image L.
subplot(3, 4, 2);
H_count = imhist(L);
bar(0:255, H_count, 'k');
title('Input Image Histogram')
grid on;
xlabel('Luminance');
ylabel('Pixel Count');
xlim([0 255]);ylim([0 max(H_count)]);

% Display image with only yellow features.
subplot(3, 4, 5);
imshow(L_yellowFeatures);
title('Yellow Road Sign');

% Get and plot the red colour histogram of the input image. The histograms
% for each triplet are based on SimpleColorDetectio​n() by Image Analyst,
% available at: <https://nl.mathworks.com/matlabcentral/fileexchange/26420-simplecolordetection>
histRed = subplot(3, 4, 6);
[countsRed, lumRed] = imhist(R);
maxLumRed = find(countsRed > 0, 1, 'last'); % x-axis
maxCountRed = max(countsRed); % y-axis
bar(countsRed, 'r');
grid on;
xlabel('Luminance');
ylabel('Pixel Count');
title('Threshold value R > 150');

% Get and plot the green colour histogram of the input image.
histGreen = subplot(3, 4, 7);
[countsGreen, lumGreen] = imhist(G);
maxLumGreen = find(countsGreen > 0, 1, 'last');
maxCountGreen = max(countsGreen);
bar(countsGreen, 'g', 'BarWidth', 0.95);
grid on;
xlabel('Luminance');
ylabel('Pixel Count');
title('Threshold value G > 150');

% Get and plot the blue colour histogram of the input image.
histBlue = subplot(3, 4, 8);
[countsBlue, lumBlue] = imhist(B);
maxLumBlue = find(countsBlue > 0, 1, 'last');
maxCountBlue = max(countsBlue);
bar(countsBlue, 'b');
grid on;
xlabel('Luminance');
ylabel('Pixel Count');
title('Threshold value B < 50');

% Plot all 3 color bands' histogram.
subplot(3, 4, 3);
plot(lumRed, countsRed, 'r', 'LineWidth', 2);
xlabel('Luminance');
ylabel('Pixel Count');
grid on;
hold on;
plot(lumGreen, countsGreen, 'g', 'LineWidth', 2);
plot(lumBlue, countsBlue, 'b', 'LineWidth', 2);
title('Histogram of All Colour Bands');
% Get the maximum luminance of each colour in the RGB triplet.
maxLuminance = max([maxLumRed,  maxLumGreen, maxLumBlue]);
% Set x-axis to appropriate value for data type uint8, maximum luminance is
% 255. If not datatype uint8, then take the maximum luminance.
if eightBit
    xlim([0 255]);
else
    xlim([0 maxLuminance]);
end

% Set both axes to same size, easier to compare.
% x-axis
maxLum = max([maxLumRed,  maxLumGreen, maxLumBlue]);
if eightBit
    maxLum = 255;
end
% y-axis
maxCount = max([maxCountRed,  maxCountGreen, maxCountBlue]);
axis([histRed histGreen histBlue], [0 maxLum 0 maxCount]);

% Display image with only red features.
subplot(3, 4, 9);
imshow(L_redFeatures);
title('Red Road Sign');

% Plot red colour histogram again, adjust title appropriately.
subplot(3, 4, 10);
bar(countsRed, 'r');
grid on;
xlabel('Luminance');
ylabel('Pixel Count');
title('Threshold value R > 50');

% Plot green colour histogram again, adjust title appropriately.
subplot(3, 4, 11);
bar(countsGreen, 'g');
grid on;
xlabel('Luminance');
ylabel('Pixel Count');
title('Threshold value < 50');

% Plot blue colour histogram again, adjust title appropriately.
subplot(3, 4, 12);
bar(countsBlue, 'b');
grid on;
xlabel('Luminance');
ylabel('Pixel Count');
title('Threshold value B < 50');

% Show the thresholds as vertical red bars on the histograms. For this task
% the function PlaceThresholdBars() is used (small adjustments, such as
% removing unused variables). Aformentioned function was found in
% SimpleColorDetectio​n() by Image Analyst, available at:
% <https://nl.mathworks.com/matlabcentral/fileexchange/26420-simplecolordetection>
PlaceThresholdBars(6, 150, 255);
PlaceThresholdBars(7, 150, 255);
PlaceThresholdBars(8, 0, 50);
PlaceThresholdBars(10, 50, 255);
PlaceThresholdBars(11, 0, 50);
PlaceThresholdBars(12, 0, 50);
