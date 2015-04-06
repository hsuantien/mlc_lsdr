function [G_tt]=OVA_linreg(y_tr, y_tt, x_tr, x_tt)

	[training_size, label_size]=size(y_tr);
	[testing_size, feature_num]=size(x_tt);

	w=zeros(feature_num, label_size);
	neg_ones=-1*ones(training_size,1);
	hat = ((([neg_ones x_tr]')*[neg_ones x_tr] + 0.01*eye(feature_num+1))^-1)*([neg_ones x_tr]');

	theta=zeros(label_size,1);
	for i=1:label_size
    		w_tmp=hat*y_tr(:,i);
    		theta(i)=w_tmp(1);
    		w(:,i)=w_tmp(2:length(w_tmp));
	end
	theta_matrix_tt=ones(testing_size,label_size);
	for i=1:label_size 
		theta_matrix_tt(:,i)=theta(i)*theta_matrix_tt(:,i);
	end
	G_tt=x_tt*w-theta_matrix_tt;
	
return
