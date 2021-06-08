clc;
clear all;
close all;
sciezka='dane/P_02079_RIGHT_MLO.jpg';

I = imread(sciezka);
wymiary=size(I);
obraz_przyciety = I(1:wymiary(1),1:wymiary(2));

% Obraz oryginalny
figure()
imshow(obraz_przyciety);

I_equalized = adapthisteq(obraz_przyciety);
% Contrast-limited Adaptive Histogram Equalization
figure()
imshow(I_equalized);

bw1 = im2bw(I_equalized, graythresh(I_equalized));
% Informacja gdzie jest obiekt na zdjeciu
figure()
imshow(bw1);

bw2 = imfill(bw1,'holes');
bw3 = imopen(bw2,ones(5,5));
bw4 = bwareaopen(bw3, 30);
bw5 = bwperim(bw4);
obrys = imoverlay(I_equalized, bw5, 'red');
% Obrys biektu
figure()
imshow(obrys);

mask_em = imextendedmax(I_equalized, 40);
% Wyznaczenie podejrzanych punktów
figure()
imshow(mask_em)

mask_em = imclose(mask_em, ones(5,5));
mask_em = imfill(mask_em, 'holes');
mask_em = bwareaopen(mask_em, 100);
result = imoverlay(I_equalized, bw5 | mask_em, 'red');
% Obraz finalny
figure()
imshow(result);

