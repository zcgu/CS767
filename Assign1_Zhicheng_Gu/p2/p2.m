clc;clear;close all;
a = imread('test-label.png');
% a = imread('phantom.png');
subplot(1, 2, 1);
imshow(a);


b = myRegionFinder(a);
subplot(1, 2, 2);
imshow(b)
colormap jet