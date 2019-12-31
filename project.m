clear;
fontSize = 20;
rgbImage = imread('5.jpg');
grayImage = rgb2gray(rgbImage);
subplot(2,2,1);
imshow(grayImage);
title('Original Image', 'FontSize', fontSize);


binaryImage = imbinarize(grayImage, .4);
subplot(2,2,2);
imshow(binaryImage)
title('Binary Image', 'FontSize', fontSize);

binaryImage = imfill(binaryImage, 'holes');

se = strel('disk',11);
binaryImage = imerode(binaryImage,se);
subplot(2,2,3);
imshow(binaryImage)
title('Eroded Image', 'FontSize', fontSize);

labeledImage = bwlabel(binaryImage);
%disp(labeledImage)
measurements = regionprops(labeledImage,'Area','Perimeter');


allAreas = [measurements.Area];
disp(allAreas)


allPerimeters = [measurements.Perimeter];
circularities = (4*pi*allAreas) ./ allPerimeters.^2;
%disp(circularities)

maxAllowableArea = 200000;
validCoin = circularities > 0.8 & circularities < 1.1 & allAreas < maxAllowableArea & allAreas > 100;
bigCoin2 = circularities > 0.8 & circularities < 1.1 & allAreas < maxAllowableArea & allAreas >= 1000 & allAreas < 200000;
smallCoin2 = circularities > 0.8 & circularities < 1.1 & allAreas < maxAllowableArea & allAreas < 1000 & allAreas > 100;

totalCoin = sum(validCoin)
smallCoin = sum(smallCoin2)
bigCoin = sum(bigCoin2)

disp(validCoin);
roundObjects = find(validCoin);

disp(roundObjects);

binaryImage = ismember(labeledImage, roundObjects) > 0;
subplot(2,2,4);
imshow(binaryImage);
%title('Final Image', 'FontSize', fontSize);
title(['Big Coin  : ',  num2str(bigCoin), ' , Small Coin : ', num2str(smallCoin)], 'FontSize', fontSize);
labeledImage = bwlabel(binaryImage);
