function [ featureHist ] = getFeatureHist( imIn, m, n, numBins )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here


% The original method, which is very slow.
% [sizx, sizey] = size(imIn);
% featureHist = zeros((sizx - m) * (sizey - n), 1);
% i = 1;
% for x = 1 : sizx - m - m - 1
%     for y = 1 : sizey - n - 1
%         x
%         featureHist(i)  = getFeature(imIn, x, y, m, n);
%         i = i + 1;
%     end
% end
% 
% subplot(1, 2, 2);
% histogram(featureHist, numBins);

[sizx, sizey] = size(imIn);
sums = zeros(sizx, sizey);
imIn = double(imIn);
sums(1, 1) = imIn(1, 1);

for x = 2 : sizx
    sums(x, 1) = sums(x-1, 1) + imIn(x,1);
end

for y = 2 : sizey
    sums(1, y) = sums(1, y - 1) + imIn(1,y);
end

for x = 2 : sizx
    for y = 2 : sizey
        sums(x, y) = imIn(x, y) + sums(x-1, y) + sums(x, y-1) - sums(x-1, y -1);
    end
end

b = double(imIn);

featureHist = zeros((sizx - m) * (sizey - n), 1);
i = 1;
for x = 1 : sizx - m - m - 1
    for y = 1 : sizey - n -n - 1
        feature = sums(x +m, y +n) - sums(x+m,y) - sums(x, y+n) + sums(x,y);
        feature = feature - (sums(x+m, y +n+n) - sums(x+m,y+n) - sums(x, y+n+n) + sums(x,y+n));
        feature = feature / (m * n);
        featureHist(i) = feature;
        b(x, y) = feature;
        i = i + 1;
    end
end


c = b(1:end - m - m, 1:end - n - n, 1);
c = c ./ max(c(:));
c = im2uint8(c);
subplot(1, 3, 2);
imshow(imadjust(c));

subplot(1, 3, 3);
histogram(featureHist, numBins);
end

