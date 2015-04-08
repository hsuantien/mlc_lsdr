
HLbr = zeros(1, 14);
HLplst = zeros(1, 14);
HLcplst = zeros(1, 14);

for M=1:14
  [~, HLbr(M)] = LSpaceTrans('yeast', M, 'br');
  [~, HLplst(M)] = LSpaceTrans('yeast', M, 'plst');
  [~, HLcplst(M)] = LSpaceTrans('yeast', M, 'cplst');
end

plot(1:M, HLbr, 'r', 1:M, HLplst, 'g', 1:M, HLcplst, 'b');
xlabel('M, number of reduced sub-problems');
ylabel('test hamming loss');
legend('Binary Relevance', 'PLST', 'CPLST');

