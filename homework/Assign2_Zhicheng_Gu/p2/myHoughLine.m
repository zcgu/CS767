function [ lines ] = myHoughLine( imBW, n )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

e = imBW;

[sizex, sizey] = size(e);

dmax = round(sqrt(sizex * sizex + sizey * sizey));
hough = zeros([dmax, 360]);


for x = 1:sizex
    for y = 1:sizey
        if e(x ,y) == 1
           for i = 1:360
               d = round(x * cos(i / 180 * pi) - y * sin(i / 180 * pi));
               
               if d > 1 && d < dmax
                   hough(d, i) = hough(d, i) + 1;
               end
               
               
           end
           
            
        end
    end
end

que = zeros(n, 1);
count = 1;
for d = 1:dmax
    for i = 1:360
        if hough(d, i) > que(1)
            if count <= n
                que(count) = hough(d, i);
                count = count + 1;
            else
                que(1) = hough(d, i);
            end
            que = sort(que);
        end
    end
end

lines = zeros(n, 2);
count = 1;
for d = 1:dmax
    for i = 1:360
        if hough(d, i) >= que(1) && count <= n
            lines(count, 1) = d;
            lines(count, 2) = i;
            count = count + 1;
        end
    end
end

end

