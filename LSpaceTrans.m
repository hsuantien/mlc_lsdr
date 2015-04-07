function LSpaceTrans(DataSet, M, k, alg)

  %read dataset
  [Y, X, Yt, Xt] = read_dataset(DataSet);
  [N, K] = size(Y);
  [Nt, d] = size(Xt);

  %encoding scheme
  %for Binary Relevance with Random Discarding
  if (strcmp(alg, 'br'))
    [Z, Zt, perm] = br_encode(Y, Yt, M);
  %for Principle Label Space Transformation
  elseif (strcmp(alg, 'plst'))
    [Z, Zt, Vm] = plst_encode(Y, Yt, m);
  %for Compressive Sensing using hadamard and CoSaMP
  elseif (strcmp(alg, 'cs'))
    [Z, Zt, A]=compress_hadamard(Y, Yt, m);
  else
    fprintf(1, 'ERROR, unrecognized coding scheme');
  end
  
  %ridge regression
  ww = ridgereg(Z, X, 0.1);
  Zt_pred = [ones(Nt, 1) Xt] * ww;

%decoding scheme
%for Binary Relevance w/ random discard
if (strcmp(alg, 'br'))
  [G_tt]=random_discard_reconst(Zt_pred, perm, K);
  G_tt=sign(G_tt);
%for Principle Label Space Transformation
elseif (strcmp(alg, 'plst'))
	G_tt=Zt_pred*Vm';
	G_tt=sign(G_tt);
%for Compressive Sensing using hadamard and CoSaMP
elseif (strcmp(alg, 'cs'))
	[G_tt]=cosamp(A,Zt_pred,k);
	G_tt=sign(G_tt-0.5);
else
	fprintf(1, 'ERROR, unrecognized coding scheme');
end

HL=sum(sum(abs((sign(G_tt)+1)/2-(y_tt+1)/2))/Nt)/K
save pred_result G_tt -ASCII
return
