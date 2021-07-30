function L_redFeatures = getRedFeatures(L, R, G, B)
%GETREDFEATURES Threshold an image to get its red features.
%   This function takes an image as input argument, and the 2D array for
%   each of the colors (R, G and B) in the image. Then, uses thresholding
%   to distinguish the red features in the image, converts this to a
%   appropriate datatype and multiplies this with the original image to
%   isolate the red colours in the original image.

% Set R, G and B values to select the red pixels from the image.
r = R>50 & G<50 & B<50;

% Use imfill() to fill holes in between borders.
r2 = imfill(r, 'holes');
se = strel('disk', 5); % Create a strel.
r3 = imclose(r2, se); % Closing operation with strel.
r4 = imopen(r3, 5); % Opening operation.

% Stack so 'red4' is same shape as the image.
rStacked = cat(3, r4);

% Convert rStacked to uint8 data type, and multply by the original image,
% which will output an image with only the red pixels.
L_redFeatures = L .* uint8(rStacked);

end

