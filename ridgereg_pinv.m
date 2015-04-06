function invX = ridgereg_pinv(X, lambda)
  invX = inv(X' * X + lambda * eye(size(X, 2))) * X';

