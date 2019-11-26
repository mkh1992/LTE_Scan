%  Zadoff-Chu sequence for PSS
function seq = PSSeqCreate(root)
first31 = exp(-1i*pi*root*(0:30).*(1:31)/63);
last31 = exp(-1i*pi*root*(32:62).*(33:63)/63);
seq=[first31,last31].';