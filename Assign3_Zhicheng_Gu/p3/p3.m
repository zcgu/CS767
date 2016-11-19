clc;clear;close all;

load('q3images.mat')

im1 = (gardenImages(:,:,1));
im1 = im2uint8(im1 ./ max(im1(:)));
im2 = (gardenImages(:,:,2));
im2 = im2uint8(im2 ./ max(im2(:)));

[sizex, sizey] = size(im1);

l = 15;

m = round(sizex / l);
n = round(sizey / l);
us = zeros(m, n);
vs = zeros(m, n);

for row = 0:m - 1
    for col = 0:n - 1
        Ix = zeros(l, l);
        Iy = zeros(l, l);
        It = zeros(l, l);
        
        for x = 1:l
            for y = 1:l
                if row * l + x + 1 >= sizex
                    Ix(x, y) = im2(row * l + x - 1, col * l + y) - im2(row * l + x, col * l + y);
                else
                    Ix(x, y) = im2(row * l + x, col * l + y) - im2(row * l + x + 1, col * l + y);
                end
                
                if col * l + y + 1 >= sizey
                    Iy(x, y) = im2(row * l + x, col * l + y - 1) - im2(row * l + x, col * l + y);
                else
%                     row * l + x
%                     col * l + y + 1
                    Iy(x, y) = im2(row * l + x, col * l + y) - im2(row * l + x, col * l + y + 1);
                end
                
                
                It(x, y) = im2(row * l + x, col * l + y) - im1(row * l + x, col * l + y);
            end
        end
        
        a11 = 0;
        a12 = 0;
        a21 = 0;
        a22 = 0;
        b1 = 0;
        b2 = 0;
        for x = 1:l
            for y = 1:l
                a11 = a11 + Ix(x, y) * Ix(x, y);
                a12 = a12 + Ix(x, y) * Iy(x, y);
                a21 = a21 + Iy(x, y) * Ix(x, y);
                a22 = a22 + Iy(x, y) * Iy(x, y);
                
                b1 = b1 + Ix(x, y) * It(x, y);
                b2 = b2 + Iy(x, y) * It(x, y);
            end
        end
        
        
        A = [a11, a12; a21, a22];
        R = A \ [b1; b2];

        us(row + 1, col + 1) = R(1);
        vs(row + 1, col + 1) = R(2);
        
        
        
        
    end
end

quiver(us, flipud(vs));
                      