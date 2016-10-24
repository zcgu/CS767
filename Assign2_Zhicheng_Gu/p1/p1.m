clc;clear;close all;

% mex pq/pq_create.cpp; 
% mex pq/pq_push.cpp; 
% mex pq/pq_pop.cpp; 
% mex pq/pq_size.cpp; 
% mex pq/pq_top.cpp;
% mex pq/pq_delete.cpp;

a = imread('1.png');
% a = imread('2.JPG');
% a = imread('MRI.jpg');
% a = imread('brain.png');

a = a(:,:,1);
% a = im2uint8(a);

subplot(1, 3, 1);
imshow(a);

[pointy1,pointx1,l] = ginput(1);
pointx1 = round(pointx1);
pointy1 = round(pointy1);

[pointy2,pointx2,l] = ginput(1);
pointx2 = round(pointx2);
pointy2 = round(pointy2);

[b] = scissors(a, pointx1, pointy1, pointx2, pointy2);

subplot(1, 3, 2);
imshow(b);

c = a;
[sizex, sizey] = size(c);
for x = 1:sizex
    for y = 1:sizey
        if b(x, y) == 1
            c(x, y) = 1;
        end
    end
end

subplot(1, 3, 3);
imshow(c);
