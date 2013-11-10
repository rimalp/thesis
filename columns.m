function [fc position_h re]=columns(image)
% Divide text in lines
% image->input image; fc->first line; re->remain line
% Example:
% image=imread('TEST_3.jpg');
% [fc re]=lines(image);
% subplot(3,1,1);imshow(image);title('INPUT IMAGE')
% subplot(3,1,2);imshow(fc);title('FIRST LINE')
% subplot(3,1,3);imshow(re);title('REMAIN LINES')
[image, below]=clip(image);
imshow(image);
% imshow(below);
columns_num =size(image,2);
for i=1:columns_num
    if sum(image(:, i))==0
        fc=image(:, 1:i-1); % First column matrix
        re=image(:, i + 1:end);% Remain column matrix
        %*-*-*Uncomment lines below to see the result*-*-*-*-
                subplot(2,1,1);imshow(fc);
                subplot(2,1,2);imshow(re);
		position_h = below;
        break
    else
        fc=image;%Only one column.
        re=[ ];
		position_h = below;
    end
end
end

function [img_out below]=clip(img_in)
[f c]=find(img_in);
img_out=img_in(1:size(img_in, 1),min(c):max(c));%Crops image
%img_out=img_in(min(f):max(f),min(c):max(c));%Crops image
below = size(img_in, 1) - max(f);
end