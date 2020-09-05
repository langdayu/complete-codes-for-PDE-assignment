function pde = expdata()

pde = struct ('f', @f, 'exactu', @exactu ,'g_D', @g_D , 'Du', @Du);
% right hand side function
function z = f(p)
x = p;
z = 4*x .* exp(x);
end
% exact solution
function z = exactu(p)
x = p;
z = x .* (1-x) .* exp(x);
end
% Dirichlet boundary condition
function z = g_D(p)
x = p;
z = exactu(p);
end
% Derivative of the exact solution
function z = Du(p)
x = p;
z = exp(x) .* (1 - x - x.^2);
end
end
