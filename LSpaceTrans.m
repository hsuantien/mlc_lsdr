function [Yt_pred, HL] = LSpaceTrans(DataSet, M, alg)

  %read dataset
  [Y, X, Yt, Xt] = read_dataset(DataSet);
  [N, K] = size(Y);
  [Nt, d] = size(Xt);

  %encoding scheme
  %for Binary Relevance with Random Discarding
  if (strcmp(alg, 'br'))
    [Z, Zt, Vm] = br_encode(Y, Yt, M);
  %for Principal Label Space Transformation
  elseif (strcmp(alg, 'plst'))
    [Z, Zt, Vm, shift] = plst_encode(Y, Yt, M);
  elseif (strcmp(alg, 'cplst'))
    [Z, Zt, Vm, shift] = cplst_encode(Y, Yt, M, X, 0.1);
  else
    fprintf(1, 'ERROR, unrecognized coding scheme');
    return;
  end
  
  %ridge regression
  ww = ridgereg(Z, X, 0.1);
  Zt_pred = [ones(Nt, 1) Xt] * ww;

  %decoding scheme
  %for Binary Relevance with Random Discarding
  if (strcmp(alg, 'br'))
    [Yt_pred, ~] = round_linear_decode(Zt_pred, Vm);
  %for Principal Label Space Transformation
  elseif (strcmp(alg, 'plst'))
    [Yt_pred, ~] = round_linear_decode(Zt_pred, Vm, shift);
  elseif (strcmp(alg, 'cplst'))
    [Yt_pred, ~] = round_linear_decode(Zt_pred, Vm, shift);
  else
    fprintf(1, 'ERROR, unrecognized coding scheme');
    return;
  end
  HL = sum(sum(Yt_pred ~= Yt)) / Nt / K;
