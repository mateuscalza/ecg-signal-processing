clear all;
close all;
clc;

% Dataset
load('Person1\rec_1m.mat');

% Info
Fs = 500;
Ts = 1/Fs;
t = 0: 1/Fs : length(val)/Fs-1/Fs;
x = val(1,:);

% Highpass
load('coeffHighpass.mat');
yh = iir(x, bm, an);

% Lowpass
load('coeffLowpass.mat');
yl = fir(yh, bm);

% Plot
figure(1)
plot(t,x)
hold on;
plot(t,yl)
legend('Original', 'Ap�s filtro');
title('ECG');
grid on;

% FFT Plot
figure(4)
fftPlot(x, Fs);
hold on;
fftPlot(yl, Fs);
legend('Original', 'Ap�s filtro');
title('FFT');
grid on;
