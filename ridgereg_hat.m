function H = ridgereg_hat(X, lambda)
  H = X * ridgereg_pinv(X, lambda)
