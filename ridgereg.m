function [G_tt] = ridgereg(y_tr, x_tr, y_tt, x_tt)

  [N, K] = size(y_tr);
  [testing_size, feature_num] = size(x_tt);

  X = [ones(N, 1) x_tr];
  w = ridgereg_pinv(X) * y_tr;

  G_tt = [-one(testing_size, 1) x_tt] * w;
