function u=u(x)
  u = exp(-x .* x) .* (1 - x .* x);
end