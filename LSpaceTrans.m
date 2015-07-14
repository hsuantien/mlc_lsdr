function [Yt_pred, HL] = LSpaceTrans(DataSet, M, alg)
  if (isa(M, 'char'))
    M = str2num(M);
  end
  lambda = 0.1;

  %read dataset
  [Y, X, Yt, Xt] = read_dataset(DataSet);
  [N, K] = size(Y);
  [Nt, d] = size(Xt);

  % {0,1} -> {-1,1}
  if sum(sum(Y>0)) == sum(sum(Y))
    Y = 2*Y - 1;
    Yt = 2*Yt - 1;
  end

  %encoding scheme
  %for Binary Relevance with Random Discarding
  if (strcmp(alg, 'br'))
    [Z, Zt, Vm] = br_encode(Y, Yt, M);
  %for Principal Label Space Transformation
  elseif (strcmp(alg, 'plst'))
    [Z, Zt, Vm, shift] = plst_encode(Y, Yt, M);
  %for Conditional Principal Label Space Transformation
  elseif (strcmp(alg, 'cplst'))
    [Z, Zt, Vm, shift] = cplst_encode(Y, Yt, M, X, lambda);
  %for FaIE
  elseif (strcmp(alg, 'faie'))
    [Z, recover] = FaIE_encode(X, Y, M, lambda);
  elseif (strcmp(alg, 'faiep'))
    [Z, Vm] = FaIEp_encode(Y, M, X, lambda);
  %for cssp
  elseif (strcmp(alg, 'cssp'))
    [Z, recover] = cssp_encode(Y, M);
  else
    fprintf(1, 'ERROR, unrecognized coding scheme');
    return;
  end
  
  %ridge regression
  ww = ridgereg(Z, X, lambda);
  Zt_pred = [ones(Nt, 1) Xt] * ww;

  %decoding scheme
  %for Binary Relevance with Random Discarding
  if (strcmp(alg, 'br'))
    [Yt_pred, ~] = round_linear_decode(Zt_pred, Vm);
  %for Principal Label Space Transformation
  elseif (strcmp(alg, 'plst'))
    [Yt_pred, ~] = round_linear_decode(Zt_pred, Vm, shift);
  %for Conditional Principal Label Space Transformation
  elseif (strcmp(alg, 'cplst'))
    [Yt_pred, ~] = round_linear_decode(Zt_pred, Vm, shift);
  elseif (strcmp(alg, 'faie'))
    [Yt_pred, ~] = FaIE_decode(Zt_pred, recover);
  elseif (strcmp(alg, 'faiep'))
    [Yt_pred, ~] = round_linear_decode(Zt_pred, Vm);
  elseif (strcmp(alg, 'cssp'))
    [Yt_pred, ~] = cssp_decode(Zt_pred, recover);
  else
    fprintf(1, 'ERROR, unrecognized coding scheme');
    return;
  end
  [~,~,~,HL,~] = evaluate(Yt_pred, Yt);
