function [ val ] = calcMI( im1, im2, x )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
im3 = imrotate(im1, x,'bilinear','crop');

hist2 = imhist(im2);
hist3 = imhist(im3);

hist4 = zeros(256, 256);

[sizex, sizey] = size(im2);
    
for x = 1:sizex
    for y = 1:sizey
        hist4(im2(x, y) + 1, im3(x, y) + 1) = hist4(im2(x, y) + 1, im3(x, y) + 1) + 1;
    end
end

nz2 = hist2>0; % Index to non-zero bins
f2 = hist2(nz2)./sum(hist2(nz2));
H2 = -sum(f2.*log2(f2));

nz3 = hist3>0; % Index to non-zero bins
f3 = hist3(nz3)./sum(hist3(nz3));
H3 = -sum(f3.*log2(f3));

nz4 = hist4>0; % Index to non-zero bins
f4 = hist4(nz4)./sum(hist4(nz4));
H4 = -sum(f4.*log2(f4));

val = -( H2 + H3 - H4);

end

