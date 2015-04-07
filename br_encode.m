function [Z, Zt, Vm] = br_encode(Y, Yt, M)

  [N, K] = size(Y);
  Vm = speye(K);
  idx = randperm(1:K);
  Vm = Vm(idx, 1:M);
  Z = Y * Vm;
  Zt = Yt * Vm;

