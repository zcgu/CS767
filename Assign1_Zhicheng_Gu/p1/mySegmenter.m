function [ imOut] = mySegmenter( imIn )
%This function gets a input gray image imIn and output segmented binary
%image.
%   This function also display the images and other infos of images.
subplot(1, 3, 1);
imshow(imIn);

hist = imhist(imIn);

indexes = 1 : length(hist);

pos = 0;
min_wcv = realmax;

for i = 1 : length(hist) - 1
    w1 = sum(hist(1:i)) / sum(hist);
    w2 = sum(hist(i+1:end)) / sum(hist);
    
    
    wcv = w1 * var(indexes(1:i), hist(1:i)) ...
        + w2 * var(indexes(i+1:end), hist(i+1:end));
    
    if wcv < min_wcv
        min_wcv = wcv;
        pos = i;
    end
end

imOut = imIn;

for idx = 1:numel(imOut)
    element = imOut(idx);
    if element > pos
        imOut(idx) = 1;
    else
        imOut(idx) = 0;
    end
end

imOut = logical(imOut);

subplot(1, 3, 2);
imshow(imOut);

perimeter = myPerimeter(imOut);

fprintf('p1:\n');
fprintf('Image size: %i x %i\n', length(imIn), length(imIn(1,:)));
fprintf('Total number of pixels: %i\n', length(imIn) * length(imIn(1,:)));
fprintf('Number of pixels in region: %i\n', sum(imOut(:)));
fprintf('Length of perimeter: %i\n', length(perimeter));

diameter = 0;

for idx1 = 1:length(perimeter)
    for idx2 = 1:length(perimeter)
        x1 = perimeter(idx1, 1);
        y1 = perimeter(idx1, 2);
        x2 = perimeter(idx2, 1);
        y2 = perimeter(idx2, 2);
        if diameter < ((x1 - x2) ^ 2 + (y1 - y2) ^ 2) ^ 0.5
            diameter = ((x1 - x2) ^ 2 + (y1 - y2) ^ 2) ^ 0.5;
        end
    end
end

fprintf('Diameter: %i\n', diameter);

[im1, im2] = myDT(imOut, perimeter);

area = sum(imOut(:));

% imwrite(imOut, 'p1_output.jpg');

return
end

