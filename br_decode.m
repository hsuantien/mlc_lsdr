function [G_tt] = br_decode(G_prime, perm, label_size)

%reconstruction: add zeros or negative ones
[testing_size, m]=size(G_prime);
G_tt=[G_prime -1*ones(testing_size, label_size-m)];
[permed, inverse_perm]=sort(perm(2,:));
G_tt=G_tt(:, inverse_perm);

return
