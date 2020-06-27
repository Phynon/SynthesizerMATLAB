function y = envelope1(t)
N = length(t);
t1 = 0.1 * N;
t2 = 0.2 * N;
t3 = 0.6 * N;
m = (t / (t1 - 0)) .* (t >= 0 & t < t1) + ...
    (-0.25 * t / (t2 - t1) + 1.25) .* (t >= t1 & t < t2) + ...
    0.75 .* (t >= t2 & t < t3) + (-0.75 * t / (N - t3) + 1.875) .* (t >= t3);
y = m;
end