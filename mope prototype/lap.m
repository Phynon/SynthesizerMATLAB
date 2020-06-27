function y = lap(note1, note2, real_time)
%LAP lap-connect two waveforms, specifically two notes.
%   lap(note1, note2, time)
%   lap-connect note2 onto note1, with the initial impulse of note2
%   set on the exact time, which is determined by arg time.

global fs;
global spo;

pos = fix(real_time * fs * spo);
lapspan = length(note1) - pos;
temp = note1(1 : pos);
if lapspan >= length(note2)
    m = [temp, note1(pos + 1 : pos + length(note2)) + note2, note1(pos + length(note2) + 1 : end)];
else
    m = [temp, note1(pos + 1 : end) + note2(1 : lapspan), note2(lapspan + 1 : end)];
end

y = m;
end

