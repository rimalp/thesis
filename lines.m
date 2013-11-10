function [fl position_h re]=lines(im_texto)
% Divide text in lines
% im_texto->input image; fl->first line; re->remain line
% Example:
% im_texto=imread('TEST_3.jpg');
% [fl re]=lines(im_texto);
% subplot(3,1,1);imshow(im_texto);title('INPUT IMAGE')
% subplot(3,1,2);imshow(fl);title('FIRST LINE')
% subplot(3,1,3);imshow(re);title('REMAIN LINES')
[im_texto below]=clip(im_texto);
num_filas=size(im_texto,1);
for s=1:num_filas
    if sum(im_texto(s,:))==0
        fl=im_texto(1:s-1, :); % First line matrix
		re=im_texto(s+1 :end, :);% Remain line matrix
        %*-*-*Uncomment lines below to see the result*-*-*-*-
        %         subplot(2,1,1);imshow(fl);
        %         subplot(2,1,2);imshow(re);
		position_h = below + num_filas - s;
        break
    else
        fl=im_texto;%Only one line.
		position_h = below;
        re=[ ];
    end
end
end

function [img_out below]=clip(img_in)
[f c]=find(img_in);
img_out=img_in(min(f):max(f),min(c):max(c));%Crops image
below = size(img_in, 1) - max(f);
end