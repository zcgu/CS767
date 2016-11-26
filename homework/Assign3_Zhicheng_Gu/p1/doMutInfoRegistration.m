function [ im1, im2, im3 ] = doMutInfoRegistration(imSource, imTarget, initialGuessAngle)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

im1 = im2uint8(imSource ./ max(imSource(:)));
im2 = imTarget;

options = optimset('MaxIter',100);
angle = fminsearch(@(k)calcMI(im1,im2,k),initialGuessAngle, options)

im3 = imrotate(im1, angle,'bilinear','crop');

end

