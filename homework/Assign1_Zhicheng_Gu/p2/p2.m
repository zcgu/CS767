clc;clear;close all;
a = imread('test-label.png');
% a = imread('phantom.png');

subplot(1, 2, 1);
imagesc(a);


b = myRegionFinder(a);
subplot(1, 2, 2);
imagesc(b);
