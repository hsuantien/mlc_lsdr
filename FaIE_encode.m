function [Z, recover] = FaIE_encode(X, Y, M, alpha, lambda)
    if (~exist('lambda', 'var'))
        lambda = 10^-6;
    end

    if (~exist('alpha', 'var'))
        alpha = 0.1;
    end

    D1 = Y * Y';
    Delta = ridgereg_hat(X, lambda);

    Omega = D1 + alpha * Delta;
    [V,D] = eigs(Omega, M);
    D = real(diag(D));
    V = real(V);
    scales = 1 ./ sqrt(diag(V'*V));
    scales(isinf(scales) | isnan(scales)) = 1;
    V  = V * sparse(diag(scales));              % normalize the eigenvectors
    
    [tmpY, tmpI] = sort(D, 'descend');    
    Z = V(:, tmpI(1:M));

    recover = Z' * Y;
