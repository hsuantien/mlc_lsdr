function [Z, Zt, A] = cs_encode(Y, Yt, M)

  [N, K]=size(Y);
  Kh = 2^(ceil(log2(K)));
A = generate_rand_hadamard(m,K, Kh);
Z = Y * A';
Zt = Yt * A';

function [A]=generate_rand_hadamard(m,K,Kh)
H=hadamard(Kh);
p = randperm(Kh);
A = H(1:K, p(1:M))


