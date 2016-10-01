clc;clear;close all;
a = imread('dsa.png');
% a = imread('fmri.png');

subplot(1, 2, 1);
imshow(a);

b = a;

[m, n] = size(b);
for x = 1 : 10: m - 10
    for y = 1: 10: n - 10
        feature = getFeature(a, x, y, 5, 5);
        
        for xx = x:x+10
            for yy = y:y+10
                b(xx, yy) = feature;
            end
        end
    end
end

% c = b;
c = b(1:end - 10, 1:end - 10, 1);
% c = double(c);
% c = c ./ max(c(:));
c = im2uint8(c);
subplot(1, 2, 2);
imshow(imadjust(c));
