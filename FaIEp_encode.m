function [Z, recover] = FaIEp_encode(X, Y, M, lambda, alpha)
    if (~exist('alpha', 'var'))
        alpha = 0.1;
    end

    Delta = ridgereg_hat(X, lambda);
    Omega = Y * Y' + alpha * Delta;
    [Z, D] = eigs(Omega, M);
    recover = Z' * Y;
