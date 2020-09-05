function showsolution(uh,varargin)

n = length(uh);
x = (0:0.01:1)';
v = basis(x,n);
%The line below need to add x
%Becasue we really need to solve is u(x) 
%And u(x£© = v(x) + x
y = v'*uh+x; 
plot(x,y,varargin{:});