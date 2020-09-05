pde = model_data1 (); 

%Forward
%[X,T,U] = heat_equation_fd1d (100,10000, pde,'forward');
%showvarysolution (X,T,U);
%showsolution (X,T,U);
%Backward
NS = 200;
NT = 400;
[X,T,U] = heat_equation_fd1d (NS ,NT , pde ,'backward ');
%showvarysolution (X,T,U);
showsolution (X,T,U);
[m, n] = size(U);
U_true = zeros(m, n);
t_val = linspace(0, 0.1, NT+1)';
x_val = linspace(0, 1, NS+1)';
for j = 1:n
    U_true(:,j) = sin(2*pi*x_val) .* exp(10 * t_val(j));
end
error = max(max(abs(U-U_true)))
%Crank-Nicholson
%[X,T,U] = heat_equation_fd1d (100 ,100 , pde ,'crank - nicholson ');
%showvarysolution (X,T,U);
%showsolution (X,T,U);
