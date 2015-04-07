function [Z, Zt, Vm] = svd_project(Y, Yt, m)

[U, S, V] = svd(Y, 0);
Vm = V(:,1:m);
Z = Y * Vm;
Zt = Yt * Vm;
