function [] = fftPlot(value, Fs)
    L = length(value);
    Y = fft(value);

    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    f = Fs*(0:(L/2))/L;
    plot(f,P1);
end
