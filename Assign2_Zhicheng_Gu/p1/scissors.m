function [ imOut ] =  scissors( imIn, seedRow, seedCol, destRow, destCol )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[sizex, sizey] = size(imIn);
imIn = im2double(imIn);
imOut = zeros(size(imIn));

dist = zeros(size(imIn));
visited = zeros(size(imIn));
parent = zeros(size(imIn));

for x = 1:sizex
    for y = 1:sizey
        dist(x, y) = (sizex + 1) * (sizey + 1);
    end
end

pq = pq_create( (sizex + 1) * (sizey + 1) ); 
pq_push(pq, seedRow * sizey + seedCol , -0);

while pq_size(pq) > 0

    [index, cost] = pq_pop(pq);
    x = floor(index / sizey);
    y = index - floor(index / sizey) * sizey;
    cost = -cost;
    visited(x, y) = 1;
    
    if x == destRow && y == destCol
        break
    end
    
    xx = x + 1;
    yy = y;
    
    if xx > 1 && xx < sizex && yy > 1 && yy < sizey
        path = abs(( imIn(x, y -1) + imIn(x + 1, y -1)) / 2 - (imIn(x, y +1) + imIn(x + 1, y +1)) / 2) / 2;
        if visited(xx, yy) == 0 && cost + path < dist(xx, yy)
            dist(xx, yy) = cost + path;
            pq_push(pq, xx * sizey + yy , - cost - path);
            parent(xx, yy) = index;
        end
    end
    
    xx = x - 1;
    yy = y;
    if xx > 1 && xx < sizex && yy > 1 && yy < sizey
        path = abs((imIn(x, y -1) + imIn(x - 1, y -1)) / 2 - (imIn(x, y +1) + imIn(x - 1, y +1)) / 2) / 2;

        if visited(xx, yy) == 0 && cost + path < dist(xx, yy)
            dist(xx, yy) = cost + path;
            pq_push(pq, xx * sizey + yy , - cost - path);
            parent(xx, yy) = index;
        end
    end
    
    xx = x;
    yy = y - 1;
    if xx > 1 && xx < sizex && yy > 1 && yy < sizey
        path = abs((imIn(x - 1, y) + imIn(x - 1, y -1)) / 2 - (imIn(x + 1, y) + imIn(x + 1, y - 1)) / 2) / 2;

        if visited(xx, yy) == 0 && cost + path < dist(xx, yy)
            dist(xx, yy) = cost + path;
            pq_push(pq, xx * sizey + yy , - cost - path);
            parent(xx, yy) = index;
        end
    end
    
    xx = x;
    yy = y + 1;
    if xx > 1 && xx < sizex && yy > 1 && yy < sizey

        path = abs((imIn(x - 1, y) + imIn(x - 1, y +1)) / 2 - (imIn(x + 1, y) + imIn(x + 1, y + 1)) / 2) / 2;

        if visited(xx, yy) == 0 && cost + path < dist(xx, yy)
            dist(xx, yy) = cost + path;
            pq_push(pq, xx * sizey + yy , - cost - path);
            parent(xx, yy) = index;
        end
    end

    for i = -1:2:1
        for j = -1:2:1
            xx = x + i;
            yy = y + j;
            if xx > 1 && xx < sizex && yy > 1 && yy < sizey

                path = abs(imIn(x, yy) + imIn(xx, y)) /  sqrt(2);
                if visited(xx, yy) == 0 && cost + path < dist(xx, yy)
                    dist(xx, yy) = cost + path;
                    pq_push(pq, xx * sizey + yy , - cost - path);
                    parent(xx, yy) = index;
                end
            end
        end
    end
    
end

x = destRow;
y = destCol;

while x ~= seedRow || y ~= seedCol
    imOut(x, y) = 1;
    index = parent(x, y);
    x = floor(index / sizey);
    y = index - floor(index / sizey) * sizey;
end

pq_delete(pq);

end

