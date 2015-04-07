function [Z, Zt, Vm, shift] = plst_encode(Y, Yt, m)

  shift = mean(Y);

  [N, K] = size(Y);
  Yshift = Y - repmat(shift, N, 1);
  [Nt, K] = size(Yt);
  Ytshift = Yt - repmat(shift, Nt, 1);

  [~, ~, V] = svd(Yshift, 0);
  Vm = V(:, 1:m);
  Z = Yshift * Vm;
  Zt = Ytshift * Vm;
