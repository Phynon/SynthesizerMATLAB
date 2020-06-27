function y = envelope3(t)
%ENVELOPE3 envelope3
%   comment

N = length(t);
y = 1.6 * tanh(160 * t / N) .* cosh(3.5 * t / N) .^ (-2);
end