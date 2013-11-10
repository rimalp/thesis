function letter=read_letter(imagn, symbols_num)
% Computes the correlation between template and input image
% and its output is a string containing the letter.
% Size of 'imagn' must be 42 x 24 pixels
% Example:
% imagn=imread('D.bmp');
% letter=read_letter(imagn)
global templates
comp =zeros(1, symbols_num);
index = 1;
for n=1:symbols_num
    sem=corr2(templates{1,n},imagn);
    comp(index)= sem;
    index = index + 1;
end
vd=find(comp==max(comp));
%*-*-*-*-*-*-*-*-*-*-*-*-*-
if vd < 83
    capitalL = ['A' : 'Z'];
    smallL = ['a' : 'z'];
    funcL = ['a' 'c' 'i' 'l' 'm' 'n' 'o' 's' 't'];
    nums1 = ['1' : '9'];
    nums2 = ['0' : '9'];
    nums3 = ['0' '1'];
    val = [capitalL smallL funcL nums1 nums2 nums3];
    letter = val(vd);
elseif vd==83
    letter=' sum';
elseif vd==84
    letter=' integrate';
elseif vd==85
    letter='+';
elseif vd==86
    letter='-';
elseif vd==87
    letter='/';
elseif vd==88
    letter='.';
elseif vd==89
    letter=' alpha ';
elseif vd==90
    letter=' beta ';
elseif vd==91
    letter=' gamma ';
elseif vd==92
    letter=' delta ';
elseif vd==93
    letter=' epsilon ';
elseif vd==94
    letter=' pi ';
elseif vd==95
    letter=' sigma ';
elseif vd==96
    letter=' theta ';
elseif vd==97
    letter='*';
elseif vd==98
    letter='<';
elseif vd==99
    letter=' sqrt(';
elseif vd==100
    letter=' sqrt(';
elseif vd==101
    letter=' sqrt(';
elseif vd==102
    letter='(';
elseif vd==103
    letter=')';
    % elseif vd==83
    %     letter='[';
    % elseif vd==84
    % 	letter=']';
    % elseif vd==83
    %     letter='{';
    % elseif vd==84
    %     letter='}';
    % elseif vd==85
    %     letter='lDOWNVALparen';
    % elseif vd==86
    %     letter='rDOWNVALparen';
    % elseif vd==87
    %     letter='lUPVALparen';
    % elseif vd==88
    %     letter='rUPVALparen';
elseif vd==104
    letter=' product';
elseif vd==105
    letter=' infinity';
elseif vd==106
    letter=' arrow';
elseif vd==107
    letter='d';
elseif vd==108
    letter='''';
elseif vd==109
    letter=' lambda ';
elseif vd==110
    letter='!';
elseif vd==111
    letter='!';
elseif vd==112
    letter='/';
else
    letter='-';
end

