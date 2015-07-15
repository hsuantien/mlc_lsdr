function [Z, Vm] = csspp_encode(Y, M, lambda)
  if (~exist('lambda','var'))
    lambda = 10^-6;
  end
  rand('seed', 1);

  [N, K] = size(Y);  
  [~, ~ , V] = svd(Y, 0);
  Vm = V(:, 1:M);
  p = diag(Vm * Vm') ./ M;
  max_p = max(p);
  
  Z = zeros(N, M);
  used = zeros(1, K);
  for m = 1:M
    accept = false
    idx = 1;
    while ~accept
      idx = floor(rand() * K) + 1;
      accept = (used(idx) == 0 && rand() * max_p <= p(idx))
    end
    used(idx) = 1;
    Z(:, m) = Y(:, idx);
  end    

  Vm = (ridgereg_pinv(Z, lambda) * Y)';
%recover = pinv(C) * Y;
  
end
