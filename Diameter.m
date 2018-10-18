%Clear previous variables and Import Image

clear;
clc;

obj=imread('ball.jpg');
imshow(obj)


%Segment Image
%divide image "obj" into its respective RGB intensites

red=obj(:,:,1);
green=obj(:,:,2);
blue=obj(:,:,3);

figure(1)
subplot(2,2,1); imshow(obj); title('Original Image');
subplot(2,2,2); imshow(red); title('Red Plane');
subplot(2,2,3); imshow(green); title('Green Plane');
subplot(2,2,4); imshow(blue); title('Blue Plane');

%Threshold the blue plane

figure(2)
level=0.37;
bw2=im2bw(blue,level);
subplot(2,2,1); imshow(bw2); title('Blue plane thresholded');

%%Remove Noise

%Fill any holes
fill=imfill(bw2,'holes');
subplot(2,2,2); imshow(fill); title('Holes filled');

%Remove any blobs on the border of the image
clear=imclearborder(fill);
subplot(2,2,3); imshow(clear); title('Remove blobs on border');

%Remove blobs that are smaller than 10 pixels across
se=strel('disk',10);
open=imopen(fill,se);
subplot(2,2,4); imshow(open); title('Remove small blobs');

%Calculate properties of regions in the image and return the data in a table.

stats = regionprops('table',open,'Centroid',...
'MajorAxisLength','MinorAxisLength')

%Get centers and radii of the circles.

diameters = mean([stats.MajorAxisLength stats.MinorAxisLength],2);
radii = diameters/2;
fprintf('Diameter=%f and Radius=%f',diameters,radii);

%Show Result 
figure(3)
imshow(obj)
d=imdistline; %Include a line to physically measure the ball

