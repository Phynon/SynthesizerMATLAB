function y = envelope2(t)
N = length(t);
m = 2 * (10 * t / N) .^ 2 .* exp(-13 * t / N);
y = m;
end
