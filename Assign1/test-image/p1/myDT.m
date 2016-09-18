function [ im1, im2 ] = myDT( imIn, perimeter )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
% im1 = double(imIn);
im1 = zeros(size(imIn));
im2 = 0;

for x = 2:length(im1) - 1
    for y = 2:length(im1(x,:)) - 1
        val = realmax;

        for p = 1:length(perimeter)
            x1 = perimeter(p, 1);
            y1 = perimeter(p, 2);

            val = min(val, ((x1 - x) ^ 2 + (y1 - y) ^ 2) ^ 0.5);

        end
        
        im1(x, y) = val;
    end
end

% [res, map] = gray2ind(im1,8);
% subplot(2, 3, 4);
% imshow(im1);

% subplot(2, 3, 5);
% imshow(res, map);

im2 = im1 ./ max(im1(:));
im2 = im2uint8(im2);
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

subplot(2, 3, 5);
imshow(im2);
% colormap hot
end

