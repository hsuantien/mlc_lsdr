function[Ytr, Ytt, A]=compress_hadamard(y_tr, y_tt, m, FilePath)
%dimension reduction: hadamard
[training_size, label_size]=size(y_tr);
hadamard_n=2^(ceil(log2(label_size)));
A = generate_rand_hadamard(m,label_size,hadamard_n);
Ytr=A*y_tr';
Ytt=A*y_tt';
Ytr=Ytr';
Ytt=Ytt';
return
