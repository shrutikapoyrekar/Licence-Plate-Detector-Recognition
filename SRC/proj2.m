


clc;
clear all;
close all;

a= imread('test_021.jpg');

a = rgb2gray(a);
a1=a;
%figure(1)
%imshow(a)
a= double(a);

[row col]=size(a);
display(size(a));
%code for sobel filter
% ? that shud be asked y sobel filter and not any oder
BW = edge(double(a),'sobel');
figure(1)
imshow(BW)
title('Sobel Final Gradient Image');

%code for vertical projection
% not used for the project have kept it so that if required dont need to
% search for the code again
vp = sum(BW,2);
%figure(2);
%(plot(vp));

%code for horizontal projection
hp = sum(BW,1); % if we neeed it later

% over here i locate the point with highest peak and its index ;)
[ybm , indy ] = max(vp);


% closing image
% closing aimage is basically to used so that all the points which form
% white points together form the object
%BW1 = BW;
se = strel('rectangle',[3,8]);
closeBW = imclose(BW,se);
%figure(2);
%imshow(closeBW);

% filling image
% just fills the the boundary and removes the blocka
fI = imfill(closeBW,'holes');
figure(2);
imshow(fI);


%open image
fO = imopen(fI,se);
fO = imclearborder(fO,8);
figure(3);
imshow(fO);


figure;
imshow(a1);
pause(1);
% trials to corp the detect plate ( remeber black =0)
figure;
%set(gcf, 'Position', get(0, 'ScreenSize'));


labeledImage = bwlabel(fO, 8);
originalImage =a1; %just copied


measure = regionprops(labeledImage, originalImage, 'all');   
number = size(measure, 1);

display(number);

for k = 1 : number           % Loop through all blobs.
        chk=1;
		% Find the bounding box of each blob.
		thisBoundingBox = measure(k).BoundingBox;  % Get list of pixels in current blob.
		% Extract out this coin into it's own image.
		subImage = imcrop(a1, thisBoundingBox);
        
        % over here i will do plate    recognition from the samples i have 
        % for eg in the image test_003 i have got 22 samples :-/
        % u can count n chk :P
        
        %display(size(subImage)); after chking i set the limit to [30 100]
        [x y]= size(subImage);
        if(x >=25 && y >=100)
            
            imshow(subImage);
            imwrite(subImage,'image1.jpg');
            break;
            %ocr; need to replace the ocr code over here
            % just call the ocr file giving tit the input of file
            % image1.jpg
            % after that as soon as u go in ocr.m file delete image1.jpg
            % this is to maintain security of the file
            %pause(1);
        end
        
      % ocr;
       %pause(5);
		% Display the image with informative caption.
		%subplot(3, 4, k);
		%imshow(subImage);
		%caption = sprintf('Coin #%d\nDiameter = %.1f pixels\nArea = %d pixels', k, blobECD(k), blobMeasurements(k).Area);
		%title(caption, 'FontSize', 14);
end


    
