
function [subimages] = segment(imagename)
    threshold = 200/255;
    image = im2bw(imread('formula1.png'), threshold); % black white binary image
    [img] = cropImage(image);
    [endy, endx] = size(img);
%     imshow(image)
%     figure();
    imshow(img)
    
    image = img;
    
    centertable = zeros(size(image));
    size(centertable)
    
    
    visited = zeros(size(img)); % boolean table to mark the already visited nodes by floodfill
   
    [rows, cols] = size(img);
    size(img)
    %preallocate the segmented data struct array
    segments = repmat(struct('actual',[],'top', 1, 'bottom', 1, 'left', 1, 'right', 1, 'centerX', 1, 'centerY', 1, 'centroid', [], 'resized', []), 100, 1);
    counter = 1; % counts the number of segments
    for c=1:cols
        for r = 1:rows
            
            if visited(r,c) == 1, continue, end %already visited before
            
            if img(r,c) == 1
                visited(r,c) = 1;
            elseif visited(r,c) == 0 % black pixel not visited before
                [img, visited, l,rr,t,b, count] = floodfill(img, visited, endx, endy, r,c, c,c,r,r, 0);
                if count<10, continue, end;
                
                %create the struct to save valuable information
                clear toshow;
                toshow.actual = img(t:b, l:rr);  % this is the subsegment of the image
                toshow.top = t;
                toshow.bottom = b;
                toshow.left = l;
                toshow.right = rr;
                %save the midpoints
                toshow.centerX = ceil((rr+l)/2);
                toshow.centerY = ceil((b+t)/2);
                centertable(toshow.centerY, toshow.centerX) = counter;
                %also save a centroid (center of gravity) just in case;
                centroid = regionprops(~toshow.actual, 'centroid');
                centroid = floor(centroid.Centroid);
                toshow.centroid = centroid;
                
                %resize the image for recognition purposes (standardizing
                %the segmented images, ie)
                ratio_occupied = count/((b-t)*(rr-l));
                m=0; n=0;
                if ratio_occupied>1  % fix this, ratio shouldn't be more than one
                     m = ceil((b-t)*6);
                     n = ceil((rr-l)*0.2); 
                else
                    m = ceil((b-t)*0.2);
                    n = ceil((rr-l)*0.3);
                end
                toshow_padded = padarray(toshow.actual, [m n], 255, 'both'); % instead of fixed padding length, use percentage of length
                toshow_resized = imresize(toshow_padded,[42 24], 'bilinear');
                toshow.resized = toshow_resized;
                segments(counter) = toshow;
                counter = counter+1;
%                 figure();
%                 imshow(toshow_resized)
            end 
        end
    end
    %calculate the 
    segments = segments(1:counter-1, :);
    assignin('base', 'segments', segments);
    
    %do stuff with the data, such as extract spatial information
    centroid_table = zeros(size(image));
    row=0;col=0;
    for i=1:counter-1
        segments(i).index = i; %save things in the order they are discovered. 
        %save the centroid's (row, col) information
        row = segments(i).centroid(1);
        col = segments(i).centroid(2);
        centroid_table(row, col) = 1;
    end
    
%     
%     leftmostnode = getLeftmostBaseline(segments, image, centertable);
%     figure();
%     leftmostnode.index
%     imshow(segments(leftmostnode.index).resized);
%     
%     
%     leftmostnode = getLeftmostBaseline(segments, image, centertable(segments(leftmostnode.index).top:segments(leftmostnode.index).bottom, segments(leftmostnode.index).right:100));
%     figure();
%     leftmostnode.index
%     imshow(segments(leftmostnode.index).resized);
    
    %call the function that creates a minimum spanning tree
    firstnode = createMST(segments, image, centertable);
    assignin('base', 'head', firstnode);
    
    
end


function[top, topright, right, bottomright, bottom] = findPosition(l1, r1, t1, b1, l2, r2, t2, b2)
    top = 0;
    topright = 0;
    right = 0;
    bottomright = 0;
    bottom = 0;
    
    midHeight_1 = (t1+b1)/2;
    %if the next is completely above the current's midway point, label it
    %topright
    if (midHeight1) >= b2
        topright=1;    
    end
    
    %if it is completely above, it is top
    if b2<=t1 && r1>(r2-l2)/2
        topright = 0;
        top = 1;
    end

    
end

% function [top, topright, right, bottomright, bottom] = findNext(l1, r1, t1, b1, l2, r2, t2, b2)
%     margin = .15;
%     
% end
% 

%consider the horizontal range to be the distance between the current base
%and the next potential base
% function [top, topright, right, bottomright, bottom] = findSuperscript(l1, r1, t1, b1, l2, r2, t2, b2)
%     
% end
% 
% function [top, topright, right, bottomright, bottom] = findSubscript(l1, r1, t1, b1, l2, r2, t2, b2)
% end




function [image] = cropImage(bwimg)
    [row, col] = size(bwimg);
    startX = 0; startY = 0; endX = 0; endY = 0;
    
    %find the top bottom boundary
    for i = 1:row
        for j = 1:col
            if startY == 0 && bwimg(i,j) == 0
                startY = i;
                break;
            end
            
            if bwimg(i,j) == 0 
                endY = i;
                break;
            end
        end
    end
    
    %find the left right boundary
    for j = 1:col
        for i = 1:row
            if startX == 0 && bwimg(i, j) == 0
                startX = j;
                break;
            end
            
            if bwimg(i, j) == 0 
                endX = j;
                break;
            end
        end
    end
   
    
    %now crop the image
    if startX==0 startX=1; end
    if startY==0 startY=1; end
    image = bwimg(startY:endY, startX:endX);
%     assignin('base', 'startX', startX);
%     assignin('base', 'startY', startY);
%     assignin('base', 'endX', endX);
%     assignin('base', 'endY', endY);
end

%this method is supposed to construct a MST of the expressions to get a
%spatial relationship of the connected terms w.r.t. each other
function[ first ] = createMST(segments, image, centertable)
%     centertable
    first = getLeftmostBaseline(segments, image, centertable); %leftmost baseline node
    prev = 0; %left node in the baseline
    next = 0; % next baseline node
    counter = 1;
    [imgrow, imgcol] = size(centertable);
    prev = first;
    [finalcount, ~] = size(segments);
    
    % Note: if the find firstbaseline method does not return anything,
    % try getting the first you get and see if it is not significantly
    % smaller than the second one and count that is the baseline (compare
    % levels basically)
    while(counter ~= finalcount)
        next = 0;

%         next =  getLeftmostBaseline(segments, image, centertable(segments(prev.index).top:segments(prev.index).bottom, segments(prev.index).right:imgcol));

        % IMPORTANT: before you move right, make sure there's nothing below
        % like a fraction (a function like findLevel might be needed)
        next = findNextRight(segments, centertable(:, prev.info.right:imgcol));
%       
        figure()
        imshow(next.info.resized)
        if isa(next, 'Node')
            counter = counter + 1
            level = findLevel(prev, next)
            if level == -1
                prev.subscript = next;
            elseif level == 0
                prev.next = next;
            elseif level == 1
                prev.power = next;
            end
        end

%             prev.next = next;
%             counter = counter + 1;
%             fprintf('displaying: %d \n  %d', prev.index, next.index);
%             figure()
%             imshow(prev.info.resized);
%             if next.index == 6
%                 figure()
%                 imshow(next.info.resized);
%             end
            
%             power = 0;
%             power = findSuperscript(segments, image, centertable(1:ceil((prev.info.top+prev.info.bottom)/2 - (prev.info.bottom-prev.info.top)*0.0), prev.info.right:next.info.left));
%             if isa(power, 'Node')
%                 counter = counter+1;
%                 prev.power = power;
% %                 figure()
% %                 imshow(power.info.resized);
%             end
% %         prev = next;
%         else
%             fprintf('last of the times');
%             %otherwise find (power, subscript...) from the end of current till the end
%             power = 0;
% %             power = findSuperscript(segments, image, centertable(1:floor((prev.info.top+prev.info.bottom)/2 - (prev.info.bottom-prev.info.top)), prev.info.right:imgcol));
%             if isa(power, 'Node')
%                 power = findSuperscript(segments, image, centertable(1:imgrow, prev.info.right:imgcol));
%                 centertable((1:imgrow), prev.info.right:imgcol)
%                 counter = counter+1;
%                 prev.power = power;
% %                 figure()
% %                 imshow(power.info.resized);
%             end
%         end



        prev = next;
        
        
        
    end
    
%     lleft.info = segments(5);
%     rright.info = segments(6);
%     [level] = findLevel(lleft, rright)

end

function [next] = findNextRight(segments, centertable)
    [r, c] = size(centertable);
    next = 0;
    for cc=1:c %consider searching the first few columns and increasing the vertical height if nothing found
        for rr=1:r
            if centertable(rr,cc) ~= 0
                next = Node;
                next.x = cc;
                next.y = rr;
                next.index = centertable(rr, cc);
                next.info = segments(next.index); %info a.k.a. toshow
%                 figure()
%                 imshow(next.info.resized);
                return;
            end
        end
    end
end

%this function decides the relative positions between the left and right
%characters based on their relative positions
function[level] = findLevel(left, right)
    heightleft = left.info.bottom - left.info.top;
    heightright = right.info.bottom - right.info.top;
    midleft = (left.info.bottom+left.info.top)/2;
    midright = (right.info.bottom+right.info.top)/2;
    
    if left.info.top<right.info.top %to of left higher than top of right
        if midleft>right.info.bottom
            level = 1;
            return;
        elseif right.info.bottom>midleft && right.info.bottom > left.info.bottom+0.25*heightright; %heightright <= 0.5*heightleft && right.bottom > (left.bottom + 0.25*heightright)
            level = -1;
            return;
        else
            level = 0;
            return;
        end
    else
        if midleft > right.info.bottom
            level = 1;
            return;
        elseif (right.info.top>midleft) && (right.info.bottom > (left.info.bottom + heightright*0.25))
            level = -1;
            return;
        else 
            level = 0;
            return;
        end
    end

end


%helper methods for MST creation
function[node] = findSuperscript(segments, image, centertable)
   node = 0; 
   [r, c] = size(centertable);
   for rr=1:r
       for cc=1:c
           if centertable(rr,cc) ~= 0
                power = Node;
                node.x = cc;
                node.y = rr;
                node.index = centertable(rr, cc);
                node.info = segments(node.index); %info a.k.a. 'toshow'
            end
       end
   end
end

%find first baseline - finds the leftmost character in Level 0. 
% Algorithm - focus the search in the central 50% of the image
function[leftmostNode] = getLeftmostBaseline(segments, img, centertable)
    [r, c] = size(centertable);
    midrow = floor(r/2);
    top = midrow-floor(r*.30);
    bottom = midrow+floor(r*0.30);
    leftmostNode = 0;
    for cc=1:c %consider searching the first few columns and increasing the vertical height if nothing found
        for rr=1:r
            if centertable(rr,cc) ~= 0
                leftmostNode = Node;
                leftmostNode.x = cc;
                leftmostNode.y = rr;
                leftmostNode.index = centertable(rr, cc);
                leftmostNode.info = segments(leftmostNode.index); %info a.k.a. toshow
                figure()
                imshow(leftmostNode.info.resized);
                return;
            end
        end
    end
end


%this is a recursive floodfill function that returns the region of the
%image matrix that is covered by the floodfill
function[image, visited, l, r, t, b, count] = floodfill(image, visited, endx, endy, row, col, l, r, t, b, count)
    
   if visited(row, col) == 0
        visited(row, col) = 1;
        if col<l l=col; end
        if col>r r=col; end
        if row<t t=row; end
        if row>b b=row; end
       
        for i=row-1:1:row+1
            if i<1 || i>endy continue; end
            for j = col-1:1:col+1
                if j<1 || j>endx continue; end
                if image(i, j) == 1
                    visited(i, j) = 1;
                elseif image(i, j) == 0 && visited(i, j) == 0
                  
                    count = count+1;
                    [image, visited, l, r, t, b, count] = floodfill(image, visited, endx, endy, i, j, l, r, t, b, count);
                end
            end
        end
   end  

end

        