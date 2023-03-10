
%sin(wt)的FFT

w=3;t=linspace(0,10,1024);t=t';

x=0.5+sin(w.*t);%+sin(3*w.*t)/3+sin(5*w.*t)/5;	%原信號
x1=x+0.5*randn(size(t));			%原信號加雜訊

fx=fft(x);mfx=abs(fx);
fx1=fft(x1);mfx1=abs(fx1);

figure(1);subplot(211);plot(t,x);axis([0 10 -2 4]) %畫原信號
figure(1);subplot(212);plot(t,x1);axis([0 10 -2 4])%畫原信號加雜訊

Ts = t(2)-t(1);
Ws=2*pi/Ts;

FX = fx(1:513)*Ts
FX1 = fx1(1:513)*Ts;

W = Ws*(0:512)/1024;

figure(2);subplot(211);plot(W,abs(FX));
figure(2);subplot(212);plot(W,abs(FX1));

