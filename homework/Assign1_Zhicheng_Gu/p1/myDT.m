function [ im1, im11 ] = myDT( imIn, perimeter )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
% im1 = double(imIn);

im1 = zeros(size(imIn));
im11 = 0;
im2 = zeros(size(imIn));
im22 = 0;

[sizx, sizey] = size(imIn);
for x = 2:sizx
    for y = 2:sizey
        val = realmax;

        for p = 1:length(perimeter)
            x1 = perimeter(p, 1);
            y1 = perimeter(p, 2);

            val = min(val, ((x1 - x) ^ 2 + (y1 - y) ^ 2) ^ 0.5);

        end
        
%         imIn(x, y)
        if imIn(x, y) > 0
            im2(x, y) = val;
            im1(x, y) = 0;
        else
            im2(x, y) = 0;
            im1(x, y) = val;
        end
    end
end

% [res, map] = gray2ind(im1,8);
% subplot(2, 3, 4);
% imshow(im1);

% subplot(2, 3, 5);
% imshow(res, map);

im11 = im1 ./ max(im1(:));
im11 = im2uint8(im11);
im22 = im2 ./ max(im2(:));
im22 = im2uint8(im22);
% im2 = im2 * 255;
% [m, n, r]=size(im2);
% rgb=zeros(m,n,3); 
% rgb(:,:,1)=im2;
% rgb(:,:,2)=rgb(:,:,1);
% rgb(:,:,3)=rgb(:,:,1);
% im2=rgb/255; 

% [rows columns numberOfColorChannels] = size(im2);
% if numberOfColorChannels == 1
%   % It's monochrome, so convert to color.
%   im2 = cat(3, im2, im2, im2);
% end

figure
subplot(1, 2, 1);
imagesc(im11);
subplot(1, 2, 2);
imagesc(im22);
colormap jet
end

