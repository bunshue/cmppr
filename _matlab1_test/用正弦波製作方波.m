
%用正弦波製作方波
clear,clc,clf
%t = 0:.001:.25;
t = 0:.0001:0.5;
f0 = 60;
f = f0 * 1;
y1 = sin(2*pi*f*t)/1;
f = f0 * 3;
y2 = sin(2*pi*f*t)/3;
f = f0 * 5;
y3 = sin(2*pi*f*t)/5;
f = f0 * 7;
y4 = sin(2*pi*f*t)/7;

y5 = y1+y2+y3+y4;

subplot(511)
plot(y1(1:500))
subplot(512)
plot(y2(1:500))
subplot(513)
plot(y3(1:500))
subplot(514)
plot(y4(1:500))
subplot(515)
plot(y5(1:500))




