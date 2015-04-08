function [Z, Zt, A] = cs_encode(Y, Yt, M)

  [N, K]=size(Y);
hadamard_n=2^(ceil(log2(K)));
A = generate_rand_hadamard(m,K,hadamard_n);
Z = Y * A';
Zt = Yt * A';

function [A]=generate_rand_hadamard(m,K,hadamard_size)
A=[];
H=hadamard(hadamard_size);
p=randperm(hadamard_size);

for i=1:1:m
    A=[A; H(p(i),1:K)];
end
return

