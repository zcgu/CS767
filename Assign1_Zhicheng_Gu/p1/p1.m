% clc;clear;close all;

a = imread('flower.jpg');

a = a(:,:,1);
a = im2uint8(a);
[a2] = mySegmenter(a);


% b = blobs;
% p = predictor;
% 
% areas = zeros(length(b));
% diameters = zeros(length(b));
% for i = 1 : length(b)
%     read = cell2mat(b(i));
%     read = im2uint8(read);
%     [a2, area, diameter] = mySegmenter(read);
%     areas(i) = area;
%     diameters(i) = diameter;
% end
