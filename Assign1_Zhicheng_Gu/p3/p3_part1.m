% clear
a = imread('edge_link.png');
% a = imread('edge_detector.png');

% imshow(a)
a = im2double(a);
subplot(2, 3, 1);
imagesc(a);

p = 1.0;

h = fspecial( 'gaussian', 5, p );

b = conv2(a, h, 'same');
subplot(2, 3, 2);
imagesc(b);

gx = [-1, 0, 1; -2, 0, 2; -1, 0, 1];
gy = [-1, -2, -1; 0, 0, 0; 1, 2, 1];

bx = conv2(b, gx, 'same');
by = conv2(b, gy, 'same');

g = zeros(size(bx));
t = zeros(size(bx));

[m ,n] = size(bx);

for i = 1:m
    for j =1:n
        g(i, j) = (bx(i, j) ^ 2 + by(i, j) ^ 2) ^ 0.5;
        t(i, j) = atan(by(i, j) / bx(i, j));
    end
end

subplot(2, 3, 3);
imagesc(g);
subplot(2, 3, 4);


quiver(sin(t), cos(t));

        