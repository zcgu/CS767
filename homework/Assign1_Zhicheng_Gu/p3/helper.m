function [ imOut ] = helper( imIn, lst, count )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

imOut = imIn;

[m ,n] = size(imOut);

while size(lst) > 0
    x = lst(1,1);
    y = lst(1,2);
    lst(1,:) = [];

    if x < 1 || x > m || y < 1 || y > n
        continue
    end

    if imOut(x, y) ~= -1
        continue
    end

    imOut(x, y) = count;

    for i = -5:5
        for j = -5:5
            lst = [lst; [x + i, y + j]];
        end
    end

end

end

