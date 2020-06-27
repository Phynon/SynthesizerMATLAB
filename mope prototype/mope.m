%% Globals
global fs;
global A5;
global bpm;
global spo;

fs = 48e3;
A5 = 880;
bpm = 100;
spo = 30 / bpm;

sustain_ratio1 = 1.8;
sustain_ratio2 = 2;
sustain_ratio3 = 2.5;

%% Dongfang Hong
%{
% score to be implemented
f_dfh = [523.25; 587.33; 392; 349.23; 293.66];
N = 1 * fs;
t = (0 : N - 1) / fs;
x = 2 * pi * f_dfh * t;
keys = sin(x);
signal_dfh = reshape(keys', [numel(keys),1]);
sound(signal, fs);
pause(6);
for idx = 1 : size(f_dfh)
    sound(keys(idx, : ), fs);
    pause(1);
end
%}

%% MopeMope

mope_scores;
music1 = play(score1, sustain_ratio1);
music2 = play(score2, sustain_ratio2);
music3 = play(score3, sustain_ratio3);

% if a waveform exceeds the expected length,
% it should be long sustains of stop signs or notes.
% cutting it off usually just do.
music2 = music2(1 : length(music1));
music3 = music3(1 : length(music1));

music = music1 + 0.5 * music2 + 0.5 * music3;

% sound(music, fs);

t = (0 : length(music) - 1) / fs;
%{
% plot music waveform
plot(t, music);
xlabel('time (s)');
ylabel('amplitude');
grid on;
audiowrite('mope.wav', music, fs); % save wave file
%}

% save movie
for k = 1:1177
	plot(t(1 : 4800 * k), music(1 : 4800 * k));
	axis([0 120 -8 8]);
    xlabel('time (s)');
    ylabel('amplitude');
    grid on;
	M(k) = getframe;
end
disp('ready to display');
pause(2);

% display
sound(music, fs);
movie(M, 1, 10); % fps = 10