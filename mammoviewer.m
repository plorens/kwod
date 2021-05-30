clc;
clear all;
close all;

I = imread('mammo_2.jpg');
I_cropped = I(1:644,1:631);
figure()
imshow(I_cropped);

I_eq = adapthisteq(I_cropped);
figure()
imshow(I_eq);


bw = im2bw(I_eq, graythresh(I_eq));
figure()
imshow(bw);

bw2 = imfill(bw,'holes');
bw3 = imopen(bw2,ones(5,5));
bw4 = bwareaopen(bw3, 40);
bw4_perim = bwperim(bw4);
overlay1 = imoverlay(I_eq, bw4_perim, 'red');
figure()
imshow(overlay1);

mask_em = imextendedmax(I_eq, 30);
figure()
imshow(mask_em)

mask_em = imclose(mask_em, ones(5,5));
mask_em = imfill(mask_em, 'holes');
mask_em = bwareaopen(mask_em, 40);
overlay2 = imoverlay(I_eq, bw4_perim | mask_em, 'red');
figure()
imshow(overlay2);

