
f = @(x) exp(sin(6*x));
t = 1:-0.05:0;
A = vander(t, 11);
b = exp(sin(6*t))';
