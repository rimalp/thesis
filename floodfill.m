function [subimages] = segment(imagename)
    threshold = 128/255;
    image = im2bw(imread('for_ocr.png'), threshold); % black white binary image
    visited = zeros(size(image)); % boolean table to mark the already visited nodes by floodfill
    [rows, cols] = size(image);
    for r=1:rows
        for c = 1:cols
            if visited(r,c) == 1 
                continue; %floodfill already determined the presence of an active pixel.
            end
            
            if image(r,c) == 1
                visited(r,c) = 1;
            elseif visited(r,c) == 0 % black pixel not visited before
                [image, visited, l,r,t,b] = floodfill(image, visited, c,c,r,r);
            end
            figure();
            imshow(image(t:b, l:r))            
        end
    end    
    subimages = visited;
end

function[image, visited, l, r, t, b] = floodfill(image, visited, row, col, l, r, t, b)
    
   if visited(row, col) == 0
        visited(row, col) = 1;
        if col<l l=col; end
        if col>r r=col; end
        if row<t t=row; end
        if row>b b=row; end
       
        for i=row-1:row+1
            for j = col-1:col+1
                if image(i, j) == 0 && visited(i, j) ~= 1
                    [image, visited, l, r, t, b] = floodfill(image, visited, l, r, t, b);
                end
            end
        end
   end  
  %now set the return types  

end

        