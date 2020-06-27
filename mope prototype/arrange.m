function y = arrange(notes, timings)
%ARRANGE arrange
%   comment

m = notes{1};
time = timings(1);
for idx = 1 : length(notes) - 1
    m = lap(m, notes{idx + 1}, time);
    time = time + timings(idx + 1);
end

y = m;
end