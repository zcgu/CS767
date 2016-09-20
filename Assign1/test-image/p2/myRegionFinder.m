function [ imOut ] = myRegionFinder( imIn )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
count = 1;

imOut = zeros(size(imIn));

[m, n] = size(imIn);

for x = 1 : m
    for y = 1: n
        if imIn(x, y) == 1
            imOut(x, y) = -1;
        end
    end
end

for x = 1 : m
    for y = 1: n
        if imOut(x, y) == -1
            imOut = helper(imOut, [x, y], count);
            count = count + 1;
        end
    end
end

imOut = imOut ./ max(imOut(:));
% imOut
imOut = im2uint8(imOut);

end

