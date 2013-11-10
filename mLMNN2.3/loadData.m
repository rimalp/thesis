load('USPS.mat');
fea = fea-1;
feat = fea';
gndt = gnd';
xte = xTe;
yte = yTe;
xtr = xTr;
ytr = yTr;
xTr = feat(:, 1:7291);
xTe = feat(:, 7292:length(feat));
yTr = gndt(:, 1:7291);
yTe = gndt(:, 7292:length(gndt));

% Do this for testing with limited data (not the 10% of the test data).
% xTe = xTe(:, 1:50);
% yTe = yTe(:, 1:50)