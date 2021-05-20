clear all;
close all;
clc;

% Dataset
load('C:\Users\User\Projects\ecg-signal-processing\Person1\rec_1m.mat');

% Fs = 500;
% t = 0: 1/Fs : length(val)/Fs-1/Fs;
% 
% % Raw
% figure(1);
% plot(t,val(1,:)/1000);
% title('ECG sem filtro');
% grid on;
% 
% % Filtro alvo
% figure(2);
% plot(t,val(2,:)/1000);
% title('ECG com filtro');
% grid on;
% 
% % FFT
% Y = fft(val(2,:));
% 
% % Limpando frequências
% L = length(val(2,:));
% f = Fs*(0:(L/2))/L;
% for index=1:length(f)
%    frequency = f(index);
%    disp(frequency);
%    if frequency < 0.67 || frequency >= 45
%        Y(index) = 0;
%    end
% end
% 
% % IFTT
% result = ifft(Y);
% figure(4);
% plot(t,result/1000);
% 
% % FTT plot original
% figure(3);
% fftPlot(val(2,:), Fs);
% 
% % FTT plot filtrado
% hold on;
% fftPlot(result, Fs);
% legend('Original', 'Após filtro');
% 
% 
 


Fs = 500;
Ts = 1/Fs;
t = 0: 1/Fs : length(val)/Fs-1/Fs;

x = val(1,:);    

load('coeffHighpass.mat')
% Implementação filtro IIR Passa Alta

N = length(x);

buffer_in = zeros(length(bm),1);
buffer_out = zeros(length(an),1);

b_total = length(bm);
a_total = length(an);

for n=1:N
    buffer_in_a = buffer_in;
    for k=1:b_total-1
        buffer_in(k+1) = buffer_in_a(k); 
    end 
    buffer_in(1) = x(n);
    
    sum1 = 0;
    for k=1:b_total
       sum1 = sum1 + buffer_in(k)*bm(k); 
    end
    
    sum2 = 0;
    for k=1:a_total-1
       sum2 = sum2 + buffer_out(k)*an(k+1); 
    end
    
    yh(n) = sum1 - sum2;
    
    buffer_out_a = buffer_out;
    for k=1:a_total-1
        buffer_out(k+1) = buffer_out_a(k); 
    end 
    buffer_out(1) = yh(n);    
end

figure(1)
plot(t,x)

figure(2)
plot(t,yh)



load('coeffLowpass.mat')
% Implementação filtro IIR Passa Baixa

buffer_in = zeros(length(bm),1);
buffer_out = zeros(length(an),1);

b_total = length(bm);
a_total = length(an);

for n=1:N
    buffer_in_a = buffer_in;
    for k=1:b_total-1
        buffer_in(k+1) = buffer_in_a(k); 
    end 
    buffer_in(1) = yh(n);
    
    sum1 = 0;
    for k=1:b_total
       sum1 = sum1 + buffer_in(k)*bm(k); 
    end
    
    sum2 = 0;
    for k=1:a_total-1
       sum2 = sum2 + buffer_out(k)*an(k+1); 
    end
    
    yl(n) = sum1 - sum2;
    
    buffer_out_a = buffer_out;
    for k=1:a_total-1
        buffer_out(k+1) = buffer_out_a(k); 
    end 
    buffer_out(1) = yl(n);    
end

figure(3)
plot(t,yl)


figure(4)
fftPlot(val(2,:), Fs);
hold on;
fftPlot(yl, Fs);
legend('Original', 'Após filtro');
















