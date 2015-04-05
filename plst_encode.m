function [Ytr, Ytt, Vm] = svd_project(y_tr, y_tt, m)

[U, S, V] = svd(y_tr, 0);
Vm = V(:,1:m);
Ytr = y_tr*Vm;
Ytt = y_tt*Vm;
