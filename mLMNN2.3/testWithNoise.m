function [xTe, yTe] = testWithNoise(errorScaleFactor, xTe, yTe)
%     load('USPS.mat');
    testUpto = 50;
    xTe = xTe + errorScaleFactor * xTe(:, 1:testUpto);
    yTe = yTe(:, 1:testUpto);
%     [enerrLs, yymmenergy, valuemmenergy] = MMenergyclassify(Ls,xTr,yTr,xTe,yTe,3);
%     [knnerrLs, knerrDetails] = MMknnclassify(Ls,xTr,yTr,xTe,yTe,3);
end


%=======
%train with usps data, loadData, and then test with noise