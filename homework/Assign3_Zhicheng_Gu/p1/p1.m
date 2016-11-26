clc;clear;close all;

load('hw3imagepair1.mat')
% load('hw3imagepair2.mat')
% load('hw3imagepair3.mat')
% load('hw3imagepair4.mat')

[im1, im2, im3] = doMutInfoRegistration(imp, im, -50);

subplot(1, 3, 1);
imshow(im1);
subplot(1, 3, 2);
imshow(im2);
subplot(1, 3, 3);
imshow(im3);
