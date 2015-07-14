function [Z, recover] = FaIEp_encode(X, Y, M, lambda, alpha)
    if (~exist('alpha', 'var'))
        alpha = 0.1;
    end

    D1 = Y * Y';
    Delta = ridgereg_hat(X, lambda);

    Omega = D1 + alpha * Delta;
    [Z, D] = eigs(Omega, M);
    recover = Z' * Y;
