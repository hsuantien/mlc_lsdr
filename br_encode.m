function [Ytr, Ytt, perm] = br_encode(y_tr, y_tt, m)

[training_size, label_size]=size(y_tr);
perm1 = 1:label_size;
perm2 = randperm(label_size);
perm = [perm1; perm2];
Ytr = y_tr(:, perm2);
Ytt = y_tt(:, perm2);
Ytr=Ytr(:,1:m);
Ytt=Ytt(:,1:m);

