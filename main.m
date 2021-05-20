clear all;
close all;
clc;

% Dataset
load('Person1\rec_3m.mat');

Fs = 500;
Ts = 1/Fs;
t = 0: 1/Fs : length(val)/Fs-1/Fs;

x = val(1,:);    

load('coeffHighpass.mat');
yh = iir(x, bm, an);

load('coeffLowpass.mat');
yl = iir(yh, bm, an);

figure(1)
plot(t,x)
hold on;
plot(t,yl)
legend('Original', 'Após filtro');
title('ECG');
grid on;

figure(4)
fftPlot(x, Fs);
hold on;
fftPlot(yl, Fs);
legend('Original', 'Após filtro');
title('FFT');
grid on;
