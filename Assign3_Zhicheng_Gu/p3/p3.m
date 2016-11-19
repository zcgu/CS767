clc;clear;close all;

load('q3images.mat')

im1 = (gardenImages(:,:,1));
im1 = im2uint8(im1 ./ max(im1(:)));
im2 = (gardenImages(:,:,2));
im2 = im2uint8(im2 ./ max(im2(:)));

subplot(1, 2, 1);
imshow(im1)
subplot(1, 2, 2);
imshow(im2)