function [ imOut ] = mySnake(imIn, imInitial, curve, alpha, beta)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

[sizex, sizey] = size(imIn);
imIn = im2double(imIn);
[n, u] = size(curve);

tmp = imIn;
for i = 1:n
    tmp(curve(i, 1), curve(i, 2)) = 0;
end

subplot(1, 4, 1);
imshow(tmp);


for iteration = 1:100

    dp = zeros(n, 9);
    parent = zeros(n, 9);

    d_average = 0;
    for i = 1:n - 1
        d_average = d_average + sqrt( (curve(i,1) - curve(i+1,1)) ^ 2 + (curve(i,2) - curve(i+1,2)) ^ 2);
    end
    d_average = d_average + sqrt( (curve(n,1) - curve(1,1)) ^ 2 + (curve(n,2) - curve(1,2)) ^ 2);
    d_average = d_average / n;

    for i = 2:n
        x = curve(i, 1);
        y = curve(i, 2);
        px = curve(i-1, 1);
        py = curve(i-1, 2);
        px2 = curve(n, 1);
        py2 = curve(n, 2);
        if i ~= 2
            px2 = curve(i -2, 1);
            py2 = curve(i -2, 2);
        end
        

         
        for cur = 1:9
            curx = x + floor((cur - 1) / 3) - 1;
            cury = y + cur - floor((cur - 1) / 3) * 3 - 2;
            
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
            
            Ee = -(bx ^ 2 + by ^ 2) * 1000;
            
            Emin = Ee + alpha * (sizex ^ 2 + sizey ^ 2) ^ 2;
            
            for last = 1:9
                lastx = px + floor((last - 1) / 3) - 1;
                lasty = py + last - floor((last - 1) / 3) * 3 - 2;
                
                last2 = 5;
                lastx2 = 0;
                lasty2 = 0;
                if i ~= 2
                    last2 = parent(i-1, last);
                    lastx2 = px2 + floor((last2 - 1) / 3) - 1;
                    lasty2 = py2 + last2 - floor((last2 - 1) / 3) * 3 - 2;
                end
                
                Ei1 = alpha * ( ((curx - lastx) ^ 2 + (cury - lasty) ^ 2) - d_average) ^ 2;
                Ei2 = beta * ((curx -2 * lastx + lastx2) ^ 2 + (cury - 2 * lasty + lasty2)^2);

                if Ei1 + Ei2 + Ee + dp(i - 1, last) < Emin
                    Emin = Ei1 + Ei2 + Ee + dp(i - 1, last);
                    
                    parent(i, cur) = last;
                    dp(i, cur) = Emin;
                end
                
            end
           
            
        end
        
    end
    
    Emin = dp(n, 1);
    pos = 1;
    
    for i = 1:9
        if dp(n, i) < Emin
            Emin = dp(n, i);
            pos = i;
        end
    end
    
    curve(n, 1) = curve(n, 1) + floor((pos - 1) / 3) - 1;
    curve(n, 2) = curve(n, 2) + pos - floor((pos - 1) / 3) * 3 - 2;
    
    i = n - 1;
    while i > 1
        pos = parent(i + 1, pos);
        
        curve(i, 1) = curve(i, 1) + floor((pos - 1) / 3) - 1;
        curve(i, 2) = curve(i, 2) + pos - floor((pos - 1) / 3) * 3 - 2;
        
        i = i -1;
    end
    
    
    curve = curve([round(n/2):n,1:round(n /2)],:);

    
    if iteration == 10 || iteration == 20 || iteration == 30
        tmp = imIn;
        for i = 1:n
            tmp(curve(i, 1), curve(i, 2)) = 0;
        end

        subplot(1, 4, round(iteration / 10) + 1);
        imshow(tmp);
    end
    
   
end


imOut = imIn;
for i = 1:n
    imOut(curve(i, 1), curve(i, 2)) = 0;
end

end

