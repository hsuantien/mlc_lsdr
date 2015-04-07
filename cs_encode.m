function [Z, Zt, A] = compress_hadamard(Y, Yt, m, FilePath)
%dimension reduction: hadamard
[training_size, label_size]=size(Y);
hadamard_n=2^(ceil(log2(label_size)));
A = generate_rand_hadamard(m,label_size,hadamard_n);
Z=A*Y';
Zt=A*Yt';
Z=Z';
Zt=Zt';

