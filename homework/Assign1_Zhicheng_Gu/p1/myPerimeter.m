function [ perimeter ] = myPerimeter( im )
%This function reads a input binary image and output the perimeter.
im2 = im;
perimeter = [];

[sizx, sizey] = size(im);

for x = 2:sizx - 1
    for y = 2:sizey - 1
        if im(x, y) == 1 && min(min(im(x-1:x+1, y-1:y+1))) == 0
            perimeter = [perimeter; [x, y]];
            im2(x,y) = 1;
        else
            im2(x,y) = 0;
        end
    end
end

subplot(1, 3, 3);
imshow(im2);
% imwrite(im2, 'p1_perimeter_output.jpg');

end

