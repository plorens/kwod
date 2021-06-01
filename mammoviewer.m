clc;
clear all;
close all;

I = imread('dane/mammo.jpg');
% I = imread('mammo.jpg');
wymiary=size(I);
I_przyciete = I(1:wymiary(1),1:wymiary(2));

% Obraz oryginalny
figure()
imshow(I_przyciete);

% Contrast-limited Adaptive Histogram Equalization
I_equalized = adapthisteq(I_przyciete);
figure()
imshow(I_equalized);

% Potrzebne do obrysu (tylko czarny i bialy)
bw = im2bw(I_equalized, graythresh(I_equalized));
figure()
imshow(bw);

bw2 = imfill(bw,'holes');
bw3 = imopen(bw2,ones(5,5));
bw4 = bwareaopen(bw3, 40);
bw4_perim = bwperim(bw4);
overlay1 = imoverlay(I_equalized, bw4_perim, 'red');
% Obrys
figure()
imshow(overlay1);

mask_em = imextendedmax(I_equalized, 30);
figure()
imshow(mask_em)

mask_em = imclose(mask_em, ones(5,5));
mask_em = imfill(mask_em, 'holes');
mask_em = bwareaopen(mask_em, 40);
overlay2 = imoverlay(I_equalized, bw4_perim | mask_em, 'red');
figure()
imshow(overlay2);

