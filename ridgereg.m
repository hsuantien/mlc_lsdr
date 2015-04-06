function [w] = ridgereg(y_tr, x_tr)

  [N, K] = size(y_tr);

  X = [ones(N, 1) x_tr];
  w = ridgereg_pinv(X) * y_tr;

