function LSpaceTrans(DataSet, m, k, alg)

%read dataset
[y_tr, x_tr, y_tt, x_tt] = read_dataset(DataSet);
[training_size, label_size] = size(y_tr);
[testing_size, feature_num] = size(x_tt);

%encoding scheme
%for Binary Relevance with Random Discarding
if (strcmp(alg, 'br'))
  [Ytr, Ytt, perm] = br_encode(y_tr, y_tt, m);
%for Principle Label Space Transformation
elseif (strcmp(alg, 'plst'))
  [Ytr, Ytt, Vm] = plst_encode(y_tr, y_tt, m);
%for Compressive Sensing using hadamard and CoSaMP
elseif (strcmp(alg, 'cs'))
	[Ytr, Ytt, A]=compress_hadamard(y_tr, y_tt, m);
else
	fprintf(1, 'ERROR, unrecognized coding scheme');
end

%OVA
w = ridgereg(Ytr, x_tr, Ytt, x_tt);
G_prime = [one(testing_size, 1) x_tt] * w;

%decoding scheme
%for Binary Relevance w/ random discard
if (strcmp(alg, 'br'))
  [G_tt]=random_discard_reconst(G_prime, perm, label_size);
  G_tt=sign(G_tt);
%for Principle Label Space Transformation
elseif (strcmp(alg, 'plst'))
	G_tt=G_prime*Vm';
	G_tt=sign(G_tt);
%for Compressive Sensing using hadamard and CoSaMP
elseif (strcmp(alg, 'cs'))
	[G_tt]=cosamp(A,G_prime,k);
	G_tt=sign(G_tt-0.5);
else
	fprintf(1, 'ERROR, unrecognized coding scheme');
end

HL=sum(sum(abs((sign(G_tt)+1)/2-(y_tt+1)/2))/testing_size)/label_size
save pred_result G_tt -ASCII
return
