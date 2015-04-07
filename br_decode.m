function [Y_pred] = br_decode(Z_pred, Vm)

Y_pred = Z_pred * Vm';

