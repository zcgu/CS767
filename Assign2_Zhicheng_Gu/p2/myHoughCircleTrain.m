function [ yourcellvar ] = myHoughCircleTrain( imBW, c, ptlist )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[x, n] = size(ptlist);
cx = c(1);
cy = c(2);

yourcellvar = zeros(2, n);

for i = 1:n
    a = cell2mat( ptlist(i));
    x = a(1);
    y = a(2);

    yourcellvar(1, i) = cx - x;
    yourcellvar(2, i) = cy - y;
    
end


end

