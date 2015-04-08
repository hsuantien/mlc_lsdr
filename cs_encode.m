function [Z, Zt, Vm] = cs_encode(Y, Yt, M)

  [N, K] = size(Y);
  Kh = 2^(ceil(log2(K)));
  H = hadamard(Kh);
  p = randperm(Kh);
  Vm = H(1:K, p(1:M));
  Z = (Y+1) / 2 * Vm; %%0/1 encoding of Y instead of -/+ 1
  Zt = (Yt+1) / 2 * Vm;
