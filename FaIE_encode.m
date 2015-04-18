function [Z, recover] = FaIE_encode(X, Y, M)
    D1 = Y * Y';
    nFea = size(X,2);
    Delta = (X / (X' * X + 10^-6*eye(nFea))) * X';
    
    labelNum = M;

    alpha = 0.1;
    Omega = D1 + alpha * Delta;
    [V,D] = eigs(Omega, labelNum);
    D = real(diag(D));
    V = real(V);
    scales = 1 ./ sqrt(diag(V'*V));
    scales(isinf(scales) | isnan(scales)) = 1;
    V  = V * sparse(diag(scales));              % normalize the eigenvectors
    
    [tmpY, tmpI] = sort(D, 'descend');    
    Z = V(:, tmpI(1:labelNum));

    recover = Z' * Y;
