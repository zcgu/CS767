clc;clear;close all;

a = imread('2.1/2.png');
% a = imread('2.1/myTest4.jpg');
% a = imread('2.1/myTest1.jpg');
% a = imread('2.1/myTest2.jpg');
% a = imread('2.1/myTest3.jpg');
% a = imread('2.1/myTest5.jpg');
% a = imread('2.1/myTest7.jpg');

subplot(1, 3, 1);
imshow(a);

a = a(:,:,1);
e = edge(a);

n = 5;

lines = myHoughLine(e, n);


b = zeros(size(a));
[sizex, sizey] = size(b);

for p = 1:n
    d = lines(p, 1);
    i = lines(p, 2);
    
    for x = 1:sizex
        y = round((x * cos(i / 180 * pi) - d) / sin(i / 180 * pi));
        
        if y >= 1 && y <= sizey
            b(x, y) = 1;
        end
    end
end

subplot(1, 3, 2);
imshow(b);

c = a;
for x = 1:sizex
    for y = 1:sizey
        if b(x, y) == 1
            c(x, y) = 255;
        end
    end
end

subplot(1, 3, 3);
imshow(c);
