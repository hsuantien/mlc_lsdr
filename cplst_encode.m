function [Z, Zt, Vm, shift] = cplst_encode(Y, Yt, M, X, lambda)

  shift = mean(Y);

  [N, K] = size(Y);
  Yshift = Y - repmat(shift, N, 1);
  [Nt, K] = size(Yt);
  Ytshift = Yt - repmat(shift, Nt, 1);

  [~, ~, V] = svd(Yshift' * ridgereg_hat(X, lambda) * Yshift, 0);
  Vm = V(:, 1:M);
  Z = Yshift * Vm;
  Zt = Ytshift * Vm;
