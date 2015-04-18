function [Y_pred, Y_real] = FaIE_decode(Z_pred, recover)
        Y_real = Z_pred * recover;
        Y_pred = (sign(Y_real) - (Y_real == 0));

  %Y_real = Z_pred * Vm' + repmat(shift, N, 1);
  %Y_pred = (sign(Y_real) - (Y_real == 0)); %%0 set to -1


