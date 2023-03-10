
%FFT範例

clear,clc,clf

figure(3)
%t = 0:.001:.25;
t = 0:.001:1;
x = sin(2*pi*50*t) + sin(2*pi*120*t);
%x = sin(2*pi*60*t);
y = x + 2*randn(size(t));
%y = x;
subplot(211)
plot(y(1:200))
title('Noisy time domain signal')

Y = fft(y,251);

Pyy = Y.*conj(Y)/251;
f = 1000/251*(0:127);
subplot(212)
plot(f,Pyy(1:128))
title('Power spectral density')
xlabel('Frequency (Hz)')

subplot(212)
plot(f(1:50),Pyy(1:50))
title('Power spectral density')
xlabel('Frequency (Hz)')


