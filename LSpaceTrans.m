function LSpaceTrans(DataSet, M, k, alg)

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
  else
    fprintf(1, 'ERROR, unrecognized coding scheme');
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
  else
    fprintf(1, 'ERROR, unrecognized coding scheme');
end

HL=sum(sum(abs((sign(Yt_pred)+1)/2-(Yt+1)/2))/Nt)/K
%save pred_result G_tt -ASCII
%return
