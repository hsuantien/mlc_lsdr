function [Y_pred, Y_real] = round_linear_decode(Z_pred, Vm)

  Y_real = Z_pred * Vm');
  Y_pred = sign(Y_real);

