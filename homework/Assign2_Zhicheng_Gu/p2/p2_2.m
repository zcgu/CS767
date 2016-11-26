clc;clear;close all;

a = imread('2.2/train.png');

subplot(1, 3, 1);
imshow(a);

a = a(:,:,1);
e = edge(a);

x = load('/afs/cs.wisc.edu/u/z/h/zhichenggu/CS767/Assign2_Zhicheng_Gu/p2/2.2/train.mat');
c = x.c;
list = x.ptlist;

yourcellvar = myHoughCircleTrain(e, c, list);



t = imread('2.2/test.png');
t = im2bw(t);

subplot(1, 3, 2);
imshow(t);

points = myHoughCircleTest(t, yourcellvar);

fprintf('Two reference points are (%i, %i) and (%i, %i).\n', points(1,1), points(1,2), points(2,1), points(2,2));

t(points(1,1), points(1,2)) = 1;
t(points(2,1), points(2,2)) = 1;
subplot(1, 3, 3);
imshow(t);
