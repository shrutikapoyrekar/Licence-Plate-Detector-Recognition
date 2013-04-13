
% Program for Prewits, sobel and Laplacian


clc;
clear all;
close all;

a= imread('license1.jpg');
a = rgb2gray(a);
figure(1)
imshow(a)
a= double(a);


[row col]=size(a);
BW = edge(double(a),'sobel');
figure(2)
imshow(BW)

title('Sobel Final Gradient Image');





