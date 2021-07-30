% Function to show the low and high threshold bars on the histogram plots.
% This function is obtained from the Matlab file SimpleColorDetectio​n() by
% Image Analyst, available at:
% <https://nl.mathworks.com/matlabcentral/fileexchange/26420-simplecolordetection>
% Some adjustments were made.
function PlaceThresholdBars(plotNumber, lowThresh, highThresh)
% Show the thresholds as vertical red bars on the histograms.
subplot(3, 4, plotNumber);
hold on;
maxYValue = ylim;
% For R2014b and later we can't turn markers totally off like before but we can set their size to be virtually invisible.
hStemLines = stem([lowThresh highThresh], [maxYValue(2) maxYValue(2)], ':', 'MarkerSize', 0.001, 'LineWidth', 3);
% Turn off markers (no longer works with R2014b and later because children is empty, so workaround is to make the MarkerSize really tiny.)
children = get(hStemLines, 'children');
if ~isempty(children)
    % Only works in <= version R2014a
    set(children(2),'visible', 'off');
end
% Place a text label on the bar chart showing the threshold.
fontSizeThresh = 10;
annotationTextL = sprintf('%d', lowThresh);
annotationTextH = sprintf('%d', highThresh);
% For text(), the x and y need to be of the data class "double" so let's cast both to double.
text(double(lowThresh + 5), double(0.85 * maxYValue(2)), annotationTextL, 'FontSize', fontSizeThresh, 'Color', '[0.9290 0.6940 0.1250]', 'FontWeight', 'Bold');
text(double(highThresh + 5), double(0.85 * maxYValue(2)), annotationTextH, 'FontSize', fontSizeThresh, 'Color', '[0.9290 0.6940 0.1250]', 'FontWeight', 'Bold');

% Show the range as arrows.
% Can't get it to work, with either gca or gcf.
% 	annotation(gca, 'arrow', [lowThresh/maxXValue(2) highThresh/maxXValue(2)],[0.7 0.7]);
return;
end % from PlaceThresholdBars()