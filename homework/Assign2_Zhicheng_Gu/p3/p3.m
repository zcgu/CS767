clc;clear;close all;

a = imread('1.png');
% a = imread('2.JPG');
% a = imread('MRI.jpg');
% a = imread('brain.png');

subplot(1, 4, 1);
imshow(a);

a = a(:,:,1);

curve = ginput(100);
curve = round(curve);
curve(:,[1,2])=curve(:,[2,1]);

imOut = mySnake(a, a, curve, 0.3, 0.5);

figure
imshow(imOut);