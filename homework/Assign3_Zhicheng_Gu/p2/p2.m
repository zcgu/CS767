clc;clear;close all;

load('q2examples.mat');
im1 = brainim;
im2 = template1large;
im2 = im2(:,:,1);

l = 100;

ypeak = 0;
xpeak = 0;
scale = 0;
corr = -1000;

for x = 0:l
    s = 0.2 + (2 - 0.2) * x / l;
    
    imScale = imresize(im2, s);
    
    c = normxcorr2(imScale, im1);
    
    [y, x] = find(c==max(c(:)));
    
    if max(c(:)) > corr
        ypeak = y;
        xpeak = x;
        scale = s;
        corr = max(c(:));
    end
    
end

xpeak
ypeak
scale