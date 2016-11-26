clc;clear;close all;
a = imread('dsa.png');
% a = imread('fmri.png');

a = a(:,:,1);
subplot(1, 3, 1);
imshow(a);

% b = a;
% 
% [m, n] = size(b);
% for x = 1 : m - 10
%     for y = 1: n - 10
%         b(x, y) = getFeature(a, x, y, 5, 5);
%     end
% end
% 
% c = b(1:end - 10, 1:end - 10, 1);
% c = im2uint8(c);
% subplot(1, 2, 2);
% imshow(imadjust(c));

featureHist = getFeatureHist(a, 10, 10, 20);
