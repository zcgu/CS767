function [ num ] = getFeature( imIn, i, j, m, n )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
num = 0.0;

for x = 1 : m
    for y = 1: n
        num = num + imIn(i + x, j + y);

        num = num - imIn(i + x + m, j + y);
    end
end

num = num / (m * n);

end

