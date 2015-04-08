function [Z, Zt, A] = cs_encode(Y, Yt, M)

[training_size, label_size]=size(Y);
hadamard_n=2^(ceil(log2(label_size)));
A = generate_rand_hadamard(m,label_size,hadamard_n);
Z = Y * A';
Zt = Yt * A';

function [A]=generate_rand_hadamard(m,d,hadamard_size)
A=[];
H=hadamard(hadamard_size);
p=randperm(hadamard_size);

for i=1:1:m
    A=[A; H(p(i),1:d)];
end
return

