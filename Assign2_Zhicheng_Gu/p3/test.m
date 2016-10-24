clc;clear;close all;
a = imread('1.png');

a = a(:,:,1);
imshow(a);
imIn = im2double(a);

[cury,curx,l] = ginput(1);
cury = round(cury);

curx = round(curx);

gx = [-1, 0, 1; -2, 0, 2; -1, 0, 1];
gy = [-1, -2, -1; 0, 0, 0; 1, 2, 1];
bx = 0;
by = 0;

for j = -1:1
    for k = -1:1
        bx = bx + imIn(curx + j, cury +k) * gx(j +2, k+ 2);
        by = by + imIn(curx + j, cury +k) * gy(j +2, k+ 2);
    end
end

Ee = -(bx ^ 2 + by ^ 2)