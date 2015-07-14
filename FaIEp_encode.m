function [Z, recover] = FaIEp_encode(X, Y, M, lambda, alpha)
    if (~exist('alpha', 'var'))
        alpha = 0.1;
    end

    D1 = Y * Y';
    Delta = ridgereg_hat(X, lambda);

    Omega = D1 + alpha * Delta;
    [V, D] = eigs(Omega, M);
    Z = V;

    recover = Z' * Y;
