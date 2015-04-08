function [Z, Zt, A] = cs_encode(Y, Yt, M)

  [N, K]=size(Y);
  Kh = 2^(ceil(log2(K)));
A = generate_rand_hadamard(m,K, Kh);
Z = Y * A';
Zt = Yt * A';

function [A]=generate_rand_hadamard(m,K,Kh)
A=[];
H=hadamard(Kh);
p=randperm(Kh);

for i=1:1:m
    A=[A; H(p(i),1:K)];
end
return

