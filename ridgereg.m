function [G_tt] = ridgereg(y_tr, x_tr, y_tt, x_tt)

  [training_size, label_size] = size(y_tr);
  [testing_size, feature_num] = size(x_tt);

  w = zeros(feature_num + 1, label_size);
  neg_ones = -ones(training_size,1);
  hat = ((([neg_ones x_tr]')*[neg_ones x_tr] + 0.01*eye(feature_num+1))^-1)*([neg_ones x_tr]');

  w(:, i) = hat * y_tr;

  G_tt = [-one(testing_size, 1) x_tt] * w;
