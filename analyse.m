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
L = length(val);
Y = fft(val(2,:));
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
f = Fs*(0:(L/2))/L;

% FTT plot original
figure(3);
plot(f,P1);

% Limpando frequências
for index=1:length(f)
   frequency = f(index);
   disp(frequency);
   if frequency < 0.67 || frequency >= 50
       Y(index) = 0;
   end
end

% FTT plot filtrado
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
f = Fs*(0:(L/2))/L;
hold on;
plot(f,P1);
legend('Original', 'Após filtro');

% IFTT
result = ifft(Y);
figure(4);
plot(t,result/1000);


