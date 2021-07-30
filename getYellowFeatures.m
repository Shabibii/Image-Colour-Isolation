function L_yellowFeatures = getYellowFeatures(L, R, G, B)
%GETYELLOWFEATURES Threshold an image to get its yellow features.
%   This function takes an image as input argument, and the 2D array for
%   each of the colors (R, G and B) in the image. Then, uses thresholding
%   to distinguish the yellow features in the image, converts this to the
%   appropriate datatype and multiplies this with the original image to
%   isolate the yellow colours in the original image.

% Set R, G and B values to select the yellow pixels from the image.
y = R>150 & G>150 & B<50;

% Use imfill() to fill holes in between borders.
y2 = imfill(y, 'holes');
se = strel('square', 20); % Create a strel.
y3 = imclose(y2, se); % Closing operation with strel.
y4 = imopen(y3, 5); % Opening operation.

% Stack so 'yellow4' is same shape as the image.
yStacked = cat(3, y4);

% Convert yStacked to uint8 data type, and multply by the original image,
% which will output an image with only the yellow pixels.
L_yellowFeatures = L .* uint8(yStacked);

end

