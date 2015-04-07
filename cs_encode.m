function [Z, Zt, A] = cs_encode(Y, Yt, M)

[training_size, label_size]=size(Y);
hadamard_n=2^(ceil(log2(label_size)));
A = generate_rand_hadamard(m,label_size,hadamard_n);
Z = Y * A';
Zt = Yt * A';

