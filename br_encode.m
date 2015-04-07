function [Ytr, Ytt, perm] = br_encode(Y, Yt, m)

  [N, K] = size(Y);
perm1 = 1:label_size;
perm2 = randperm(label_size);
perm = [perm1; perm2];
Ytr = Y(:, perm2);
Ytt = Yt(:, perm2);
Ytr=Ytr(:,1:m);
Ytt=Ytt(:,1:m);

