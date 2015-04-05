function[Ytr, Ytt, V_prime]=svd_project(y_tr, y_tt, m)
%dimension reduction: svd
[U,S,V] = svd(y_tr,0);

S_prime=S(:, 1:m);
V_prime=V(:,1:m);

Ytr=U*S_prime;
Ytt=y_tt*V_prime;	

return
