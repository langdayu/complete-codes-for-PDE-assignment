function [X,T,U] = advection_fd1d(NS, NT, pde, method)
    [X,h] = pde.space_grid(NS);
    [T, tau] = pde.time_grid(NT);
    N = length(X); M = length(T);
    U = zeros(N,M);
    U(:, 1) = pde.u_initial(X);
    a = pde.a;
    r = a * tau / h;
    if a >= 0
        U(1, :) = pde.u_left(T);
    else
        U(end,:) = pde.u_right(T);
    end
     switch (method)
         case {'explicity', 'e', 'E'}
             explicity();
         case {'explicity laxw', 'elw', 'ELW'}
             explicity_laxw();
     end
     function explicity()
        for i = 2 : M
            if a > 0
                U(2:end, i) = U(2:end, i-1) - r*(U(2:end, i-1) - ...
                U(1:end-1, i-1));
            else
                U(1:end-1, i) = U(1:end-1, i-1) - r*(U(2:end, i-1) - ...
                U(1:end-1, i-1));
            end
        end
     end
     function explicity_laxw()
        for i = 2:M
            U(2:end-1, i) = U(2:end-1, i-1) - 0.5*r*(U(3:end, i-1) - ...
            U(1:end-2, i-1)) + 0.5*r^2*(U(3:end, i-1) - ...
            2*U(2:end-1, i-1) + U(1:end-2, i-1));
            if a > 0
                U(end, i) = 2*U(end-1, i) - U(end-2, i);
            else
                %U(1, i) = U(1, i-1) + 2 * tau / h * (U(2, i-1)-U(1, i-1));
                %U(1, i) = U(2, i);
                U(1, i) = 2*U(2, i) - U(3, i);
            end
        end
     end
end
    
            