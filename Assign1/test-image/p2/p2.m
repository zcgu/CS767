% clear
a = imread('test-label.png');
% a = imread('phantom.png');

b = myRegionFinder(a);
imshow(b)
colormap jet