
%FFT範例

clear,clc,clf

%t = 0:.001:.25;
t = 0:.001:1;
x = sin(2*pi*50*t) + sin(2*pi*120*t);
%x = sin(2*pi*60*t);
y1 = x;
y2 = x + 2*randn(size(t));
subplot(221)
plot(y1(1:200))
subplot(222)
plot(y2(1:200))
title('Noisy time domain signal')

Y1 = fft(y1,251);
Y2 = fft(y2,251);

Pyy1 = Y1.*conj(Y1)/251;
Pyy2 = Y2.*conj(Y2)/251;
f = 1000/251*(0:127);
%subplot(221)
%plot(f,Pyy1(1:128))
%plot(f,Pyy2(1:128))
title('Power spectral density')
xlabel('Frequency (Hz)')

subplot(212)
subplot(223)
plot(f(1:50),Pyy1(1:50))
subplot(224)
plot(f(1:50),Pyy2(1:50))
title('Power spectral density')
xlabel('Frequency (Hz)')


