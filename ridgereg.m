function [ww] = ridgereg(Y, X)

  [N, K] = size(Y);
  XX = [ones(N, 1) X]; %pad with 1 in xx_1 so ww_1 corresponds to bias
  ww = ridgereg_pinv(XX) * Y;
