clear all;
close all;
clc;

% Dataset
load('C:\Users\User\Projects\ecg-signal-processing\Person1\rec_1m.mat');

Fs = 500;
t = 0: 1/Fs : length(val)/Fs-1/Fs;

% Raw
figure(1);
plot(t,val(1,:)/1000);
title('ECG sem filtro');
grid on;

% Filtro alvo
figure(2);
plot(t,val(2,:)/1000);
title('ECG com filtro');
grid on;

% FFT
Y = fft(val(2,:));

% Limpando frequências
L = length(val(2,:));
f = Fs*(0:(L/2))/L;
for index=1:length(f)
   frequency = f(index);
   disp(frequency);
   if frequency < 0.67 || frequency >= 45
       Y(index) = 0;
   end
end

% IFTT
result = ifft(Y);
figure(4);
plot(t,result/1000);

% FTT plot original
figure(3);
fftPlot(val(2,:), Fs);

% FTT plot filtrado
hold on;
fftPlot(result, Fs);
legend('Original', 'Após filtro');


