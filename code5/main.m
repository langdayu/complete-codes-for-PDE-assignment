clear, clc
a = 0;
b = 1;

h = 0.1;

pde = expdata();

option.fQuadOrder = 3;
option.errQuadOder = 3;

maxIt = 5;
errL2 = zeros(maxIt, 1);
errH1 = zeros(maxIt, 1);
N = zeros(maxIt, 1);
for i = 1: maxIt
    [node ,elem , bdFlag] = intervalmesh(a,b,h /2^(i -1));
    uh = Poisson1d(node, elem, pde, bdFlag, option);
    N(i) = size(elem, 1);
   errL2(i) = getL2error1d(node, elem,pde.exactu,uh, option.errQuadOder);
   errH1 (i) = getH1error1d(node ,elem, pde.Du,uh,option.errQuadOder);
end
for i = 1:maxIt-1
    rate(i,1) = errH1(i)/errH1(i+1);
    rate(i,2) = errL2(i)/errL2(i+1);
end
so10 = open('solution10.mat'); so20 = open('solution20.mat');
so40 = open('solution40.mat'); so80 = open('solution80.mat');
so160 = open('solution160.mat');
plot(so10.node, so10.uh, '-k', so20.node, so20.uh, '--y', ...
     so40.node, so40.uh, '--om', so80.node, so80.uh, '--+c', ...
     so160.node, so160.uh, '--xr');
 rate = zeros(maxIt-1, 2);

loglog(N,errH1,'-*'); hold on; loglog(N, errL2, '-*');