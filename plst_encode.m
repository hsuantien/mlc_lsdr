function [Z, Zt, Vm] = plst_encode(Y, Yt, m)

[U, S, V] = svd(Y, 0);
Vm = V(:,1:m);
Z = Y * Vm;
Zt = Yt * Vm;
