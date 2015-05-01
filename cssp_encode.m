function [Z, recover] = cssp_encode(Y, M, lambda)
    if (~exist('lambda','var'))
        lambda = 10^-6;
    end

    [u,d,v] = svd(Y);
    vt = v';
    vtk = vt(1:M,:);
    p = sum(vtk,1)  ./ sum(sum(vtk,1),2);
    sum_p = 0;

    C = [];
    used = zeros([1,size(Y,2)]);
    while size(C,2) < M
        idx = pick(p, used, sum_p);
        used(idx) = 1;
        sum_p = sum_p - p(idx);
        C = [C Y(:,idx)];
    end    

    Z = C;
    recover = ridgereg_pinv(C, lambda) * Y;
    %recover = pinv(C) * Y;
    
end

function idx = pick(p, used, sum_p)
    len = size(p,2);
    if abs(sum_p ) < 1e-24
        idx = len;
    else
        idx = len;
        s = 0;
        r = rand();
        for i = 1:len
            if 1 ~= used(i) 
                s = s + p(i);
                if s/sum_p >= r
                    idx = i;
                    break;
                end
            end
        end
    end          

end
