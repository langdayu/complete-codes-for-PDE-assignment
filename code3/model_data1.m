function pde = model_data1()
TI = 0;
TF = 1;
SI = 0;
SF = 1;
pde = struct('u_exact', @u_exact,'u_initial', @u_initial, ...
             'u_right', @u_right, 'time_grid', @time_grid, ... 
            'space_grid', @space_grid, 'a', -2);
    function [T, tau] = time_grid(NT)
        T = linspace(TI, TF, NT+1);
        tau = (TF - TI) / NT;
    end
    function [X, h] = space_grid(NS)
        X = linspace(SI, SF, NS+1)';
        h = (SF - SI) / NS;
    end
    function U = u_exact(X, T)
        [x, t] = meshgrid(X, T);
        U = zeros(size(x));
        U = 1 + sin(2*pi .* (x + 2*t));
        U = U';
    end
    function u = u_initial(x)
        u = 1 + sin(2*pi .* x);
    end
    function u = u_right(t)
        u = 1 + sin(4*pi .* t);
    end
end
        