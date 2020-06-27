function y = envelope4(t)
N = length(t);
m = exp(-5 * t / N);
y = m;
end