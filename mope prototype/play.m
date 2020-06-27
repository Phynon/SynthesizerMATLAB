function y = play(inputscore, sus)
%PLAY play
%   comment

global fs;
global A5;
global spo;

notes = cell(0);
timings = [];
noteidx = 1;
cnt = 0; % sound count, unused
while noteidx <= length(inputscore( : , 3))
    note = zeros([1, fix(inputscore(noteidx, 3) * spo * fs * sus)]);
    % process a sound
    for chordidx = noteidx : noteidx + 10 % assume the max count of notes in a chord limited
        % mutiply piano-toned waveform by finetuned envelope3
        wfenvelope = envelope3((0 : fix(inputscore(chordidx, 3) * sus * spo * fs) - 1));
        sound = piano(2 * pi * A5 * 2 ^ (inputscore(chordidx, 2) / 12) * ...
                      (0 : fix(inputscore(chordidx, 3) * spo * sus * fs) - 1) / fs);
       
        if length(wfenvelope) > length(sound)
            wfenvelope = wfenvelope(1 : length(sound));
        else
            if length(wfenvelope) < length(sound)
                sound = sound(1 : length(wfenvelope));
            end
        end
                      
        temp = wfenvelope .* sound;
        % cut off possible rounding errors in matrix lengths
        if length(note) > length(temp)
            note = note(1 : length(temp));
        else
            if length(note) < length(temp)
                temp = temp(1 : length(note));
            end
        end
        note = note + temp; % assume chord is a simple sum of single waveforms
        % chord, or not a chord
        if chordidx + 1 > length(inputscore( : , 3))
            break;
        end
        if inputscore(chordidx, 1) ~= inputscore(chordidx + 1, 1)
            noteidx = chordidx;
            break;
        end
    end
    note(isnan(note)) = 0; % reset to zero stop signs indicated by nan in the score
    notes = [notes; note]; % append a sound to notes
    timings = [timings; inputscore(chordidx, 3)]; % append corresponding timings
    noteidx = noteidx + 1;
    cnt = cnt + 1;
end
music = arrange(notes', timings); % arrange all the notes with timings
% music2 = cell2mat(notes')';

y = music;
end

