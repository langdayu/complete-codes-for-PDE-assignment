clc; clear;
pde = model_data1(); 
NX = [100 200 400 800];
NT = [200 400 800 1600];
error = zeros(length(NX), 1);
for i = 1:1
    [X,T,U] = advection_fd1d(NX(i), NT(i), pde,'elw');
    UE = pde.u_exact(X,T);
    error(i) = max(max(abs(UE-U)));
end
rate = zeros(length(NX)-1,1);
for i = 2:length(NX)
    rate(i-1) = error(i)./error(i-1);
end
%showvarysolution(X,T,UE-U);
%plot(U(:, 1), X, 'r-', UE(:, 1), X, 'b*')

%showsolution(X,T,U); 
error
rate