clc;clear;close all;
% a = imread('edge_link.png');
a = imread('edge_detector.png');

a = im2double(a);

b = edge(a);
subplot(1, 2, 1);
imagesc(b);

[pointy,pointx,l] = ginput(1);

pointx = round(pointx);
pointy = round(pointy);

b(pointx, pointy)

b = double(b);

[m, n] = size(b);
for x = 1 : m
    for y = 1: n
        if b(x, y) == 1
            b(x, y) = -1;
        end
    end
end

c = helper(b, [pointx, pointy], 1);
[m, n] = size(c);
for x = 1 : m
    for y = 1: n
        if c(x, y) == -1
            c(x, y) = 0;
        end
    end
end

subplot(1, 2, 2);
imagesc(c);
