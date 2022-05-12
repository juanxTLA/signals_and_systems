load handel.mat
filename = 'Tarrat_Juan_mod.wav'

[y,Fs] = audioread(filename);

samplingFreq = Fs;


left = y(:, 2);

filtered = filter(Hd, y);

prev = y(1:10*samplingFreq, :);
post = y(10*samplingFreq:Fs*14, :);

sound(filtered, Fs); % this code checks the implementation of the filter

% max(y);
% t = 10:1/Fs:14;
% rightSine = 0.1*sin(2*pi*2210.*t);
% leftSine = 0.1*sin(2*pi*2200.*t+(pi/3));
% y(Fs*10:Fs*14,2) = rightSine;
% y(Fs*10:Fs*14,1) = leftSine;
% audiowrite('phaseImodified.wav',y,Fs);







