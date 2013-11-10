fid = fopen('train-labels-idx1-ubyte', 'r');
fread(fid, 4, '*uint32');  %header to discard
img = fread(fid, [1128 1128], '*uint8') .';