function pde = modeldata()
    pde = struct('exactu', @exactu, 'f', @f, 'Du', @Du);
    function z = exactu(x)
        z = 2*cos(x) - x + x.^2 - (2*sin(x)*(cos(1) - 1))/sin(1) - 2;
    end
    function z = f(x)
        z = x.^2 - x;
    end
end
% x = [1/4, 1/2, 3/4]; 
% y = 2*cos(x) + x.^2 - (2*sin(x)*(cos(1) - 1))/sin(1) - 2;
% plot(x, y, 'r-');