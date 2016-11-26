function [ points ] = myHoughCircleTest(imBWnew, yourcellvar)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


[sizex, sizey] = size(imBWnew);
[x, n] = size(yourcellvar);

hough = zeros(size(imBWnew));

for x = 1:sizex
    for y = 1:sizey
        if imBWnew(x, y) == 1
            for i = 1:n
                dx = yourcellvar(1, i);
                dy = yourcellvar(2, i);
                
                xx = x + dx;
                yy = y + dy;
                
                if xx >= 1 && xx <= sizex && yy >= 1 && yy <= sizey
                    hough(xx, yy) = hough(xx, yy) + 1;
                end
            end
        end
    end
end

points = [0, 0;0,0];
count = [-1, -1];

for x = 1:sizex
    for y = 1:sizey
        if hough(x, y) > count(2)
            points(1,1) = points(2,1);
            points(1,2) = points(2,2);
            
            count(1) = count(2);
            
            points(2,1) = x;
            points(2,2) = y;
            
            count(2) = hough(x, y);
        elseif hough(x, y) > count(1)
            points(1,1) = x;
            points(1,2) = y;
            
            count(1) = hough(x, y);
        end
    end
end

end

