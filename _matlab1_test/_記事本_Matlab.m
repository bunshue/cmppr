
----------------many ST----------------









f = imread('picture1.jpg');
[M, N, P] = size(f);
imshow(f)
imfinfo picture1.jpg
imwrite(f, 'ccccc.jpg')




%Matlab算房貸


year_rate = 0.024;
month_rate = year_rate / 12;
r = 1 + month_rate;
year = 10;
AA = 1000;
M = 20;
for i = 1:1:12*year
    AA = (AA) * r - M;
    X = ['第', num2str(i),'個月, 本利和 ', num2str(AA), '   共付 ', num2str(i*M)];
    disp(X)
end
    






%Matlab算經緯度
H1 = 25.047778; V1 = 121.517033;
H2 = 24.801604; V2 = 120.971655;
dh = H1 - H2
dv = V1 - V2


dh = 4;dv = 4;atan(dh/dv)*180/pi

if (theta(i)>=(pi/3*2)) && (theta(i)<=(pi/3*3))

dh = -4;dv = 3;

if (dh > 0) && (dv > 0)
	region = 1;
elseif (dh > 0) && (dv < 0)
	region = 2;
elseif (dh < 0) && (dv < 0)
	region = 3;
else
	region = 4;
end

switch(region)
case 1, disp('111');
case 2, disp('222');
case 3, disp('333');
case 4, disp('444');
otherwise, disp('xxx');
end



dh = 3;dv = 4;acot(dv/dh)*180/pi
dh = 4;dv = 3;acot(dv/dh)*180/pi
dh = 4;dv = 3;atan(dv/dh)*180/pi+90
dh = 3;dv = 4;atan(dv/dh)*180/pi+90
dh = 3;dv = 4;acot(dv/dh)*180/pi+180
dh = 4;dv = 3;acot(dv/dh)*180/pi+180
dh = 4;dv = 3;atan(dv/dh)*180/pi+270
dh = 3;dv = 4;atan(dv/dh)*180/pi+270








24.783361, 121.018231
24.783406, 121.020590


//台北車站	25.047778, 121.517033
//新竹車站	24.801604, 120.971655


H1 = 25.047778; V1 = 121.517033;
H2 = 24.801604; V2 = 120.971655;
dh = H1 - H2
dv = V1 - V2
atan(dh/dv)*180/pi








function y = simple(maxLoop)
x=(1:1000)';    %column vector
for k = 1:maxLoop
    y(:,k)=k*log(x);
end
plot(x,y)


g = simple(10)


MATLAB中的傅立葉轉換
fft，計算向量的DFT
ifft，計算向量的的反DFT
fft2，計算矩陣的DFT
ifft2，計算矩陣的反DFT
ffshift，平移轉換
'
      

a=[zeros(256,128) ones(256,128)];
>> imshow(im2uint8(a/max(a(:))));

>> af=fftshift(fft2(a));





https://ffyy99.pixnet.net/blog/post/30107657
Matlab fft2 和 ifft2 後

對一張圖片做 fft2 後 得到的是一個 二維圖片 fft 後的圖片

可搭配的有 fftshift 也就是 1<->4  2<->3 互換

可用 ifft2 轉回來 不過有個重點就是 從 fft -> 圖片時 要再把點改成 uint8();才行

ex:

I = imread(xxx.bmp);

Ig = rgb2gray(I);

Igf = fft2(Ig);

Igfs  = fftshift(Igf);

Igfsi = uint8(ifft2(Igfs));

在每行下插入 imshow(variable); 就可以看出變化了






https://ww2.mathworks.cn/help/matlab/ref/fftshift.html

小小科學實驗室 
 MATLAB函數指令表 
 http://newscienceview.blogspot.com/2012/04/matlab.html

本範例使用外部 wav 音樂檔來進行 FFT (快速傅立葉轉換)

y = wavread('C:\start.wav');
s = abs(fft(y));

subplot(3,1,1), plot(s);    % 顯示頻譜
subplot(3,1,2), plot(y(:,1));    % 顯示波形
subplot(3,1,3), plot(y(:,2));    % 顯示波形

sound(y, 44100);







for k = 1: length(a)
t(k) = sum(a(1:k))
end


total_point = 500;
start_time = 0;
stop_time = 0.04;

t=linspace(start_time, stop_time,total_point);

f=60;y=sin(2*pi*f*t);plot(t,y)










gps資料處理：

//台北車站	25.047778, 121.517033
//新竹車站	24.801604, 120.971655
在網頁上顯示新竹車站：
http://maps.google.com/maps?q=24.801604%2c120.971655

http://wywu.pixnet.net/blog/post/22338038-%E5%8F%B0%E7%81%A3%E5%9C%B0%E5%8D%80%E7%B6%93%E7%B7%AF%E5%BA%A6%E7%9A%84%E8%B7%9D%E9%9B%A2

World Geodetic System 1984 (WGS 84)

WGS84數值	WGS84座標
121.73816	121度44分17.376秒

0.73816 * 60 = 44.2896
0.2896  *60  = 17.376

經緯度：

papago
   <trkpt lon="121.000002" lat="24.764863">
   <trkpt lon="120.999958" lat="24.76481">
   <trkpt lon="120.511063" lat="24.000008">
   <trkpt lon="120.511025" lat="23.999843">

google
24°47'17.4"N 121°01'18.5"E
24.788171, 121.021796




r = 6371;
x1 = 24.836885;y1=120.922267;
x2 = 24.833224;y2=120.942566;
d=r*sqrt((x1-x2)^2+(y1-y2)^2)



r = 6371;
x1 = 23;y1=120;
x2 = 24;y2=120;
d=r*sqrt((x1-x2)^2+(y1-y2)^2)


經緯度距離計算：
http://m4.hhlink.com/%E7%BB%8F%E7%BA%AC%E5%BA%A6

程式：
http://panyee.cnblogs.com/archive/2006/07/04/442771.html

搜尋特殊資料：
極東、極西、極南、極北、
極長距離、
極久時間、
極高高度、





算sqrt(x)
if x = 10

10/2 = 5
5*5 = 25 > 10	=> 5太大
5/2 = 2.5
2.5%2.5=6.25 <10
故 6.25<10<25
   2.5^2 < sqrt(10) < 5^2

再測 (2.5+5)/2 = 3.75
3.75*3.75 = 14.0625 > 10
故 6.25<10<14.0625
   2.5^2 < sqrt(10) < 3.75^2

再測 (2.5+3.75)/2 = 3.125
3.125*3.125 = 9.7656
故 9.7656<10<14.0625
   3.125^2 < sqrt(10) < 3.75^2

再測 (3.125+3.75)/2 = 3.4375
3.4375*3.4375 = 11.8164
故 9.7656<10<11.8164
   3.125^2 < sqrt(10) < 3.4375^2

再測 (3.125+3.4375)/2 = 3.2813
3.2813*3.2813 = 10.7669
故 9.7656<10<10.7669
   3.125^2 < sqrt(10) < 3.2813^2

再測 (3.125+3.2813)/2 = 3.2031
3.2031*3.2031 = 10.2598
故 9.7656<10<10.2598
   3.125^2 < sqrt(10) < 3.2031^2

再測 (3.125+3.2031)/2 = 3.1641
3.1641*3.1641 = 10.0115
故 9.7656<10<10.0115
   3.125^2 < sqrt(10) < 3.1641^2

再測 (3.125+3.1641)/2 = 3.1445
3.1445*3.1445 = 9.8879
故 9.8879<10<10.0115
   3.1445^2 < sqrt(10) < 3.1641^2

再測 (3.1445+3.1641)/2 = 3.1543
3.1543*3.1543 = 9.9496
故 9.9496<10<10.0115
   3.1543^2 < sqrt(10) < 3.1641^2





----------------many SP----------------

  



MATLAB程式設計：入門篇		Roger Jang (張智星)
http://mirlab.org/jang/books/matlabProgramming4beginner/


 
Matlab 課程 教學資源
http://faculty.stust.edu.tw/~tang/matlab/










vid = videoinput('winvideo',1);
preview(vid)


preview(vid)
stoppreview(vid)	% stop/pause preview
closepreview(vid)	% close preview
closepreview()		% close all preview


imaqhwinfo()，来获取PC上以安装的图像获取硬件信息

info=imaqhwinfo		%没有输入参数时，返回一个结构体， 它包含了系统中存在的适配器和Matlab相关的版本信息
win_info=imaqhwinfo('winvideo')	%有输入参数的时候，返回一个结构体，包含了指定的适配器的数据信息
win_info.DeviceIDs
win_info.DeviceInfo
win_info.DeviceInfo.DeviceName
win_info.DeviceInfo(2).DeviceName		%查看第二個裝置的資訊
win_info.DeviceInfo.SupportedFormats
win_info.DeviceInfo(2).SupportedFormats		%查看第二個裝置的資訊

obj = videoinput('winvideo',1,'YUY2_640x480');
%obj = videoinput('winvideo',2,'YUY2_640x480');

%设置返回色彩 rgb正常颜色（YUY2格式颜色发红），grayscale是灰度
set(obj,'ReturnedColorSpace','rgb');
%set(obj,'ReturnedColorSpace','grayscale');
%获取分辨率，色彩数目等参数
vidRes = get(obj, 'VideoResolution');%视频分辨率
nBands = get(obj, 'NumberOfBands');%色彩数目
figure()	%指定预览窗体显示的figure
axes()		%指定预览窗口显示的坐标系
hImage = image( zeros(vidRes(2), vidRes(1), nBands) );
preview(obj, hImage);

%图像捕捉、显示和保存

Frame = getsnapshot(obj);	% 捕获图像
imshow(Frame);
imwrite(Frame,'snap.jpg','jpg');






用Matlab看WebCam

clear all;
close all;
obj=videoinput('winvideo',1,'YUY2_640x480');
preview(obj);
pause(30);
closepreview(obj);
delete(obj);

clear all;
close all;
obj=videoinput('winvideo',2,'YUY2_640x480');
preview(obj);
pause(30);
closepreview(obj);
delete(obj);


imaqmem(50000000);
imaqmem Limit or display memory in use by the Image Acquisition Toolbox.
 
Matlab的图像获取工具箱为我提供了imaqhwinfo()，来获取PC上以安装的图像获取硬件信息

SupportedFormats
winvideoinfo=imaqhwinfo('winvideo')	%可以看到window裡有安裝視訊截取裝置, 包括webcam和電視卡等
winvideoinfo.DeviceInfo
winvideoinfo.DeviceInfo.SupportedFormats

vid = videoinput('winvideo', 1); 	%假設webcam的裝置DeviceID是1, 可用imaqhwinfo('winvideo')查詢
preview(vid);	%播放

vid = videoinput('winvideo', 2); 	%假設webcam的裝置DeviceID是1, 可用imaqhwinfo('winvideo')查詢
preview(vid);	%播放

DeviceInfo的內容：
winvideoinfo.DeviceInfo	//查看所有裝置的資訊
ans = 
1x2 struct array with fields:
    DefaultFormat
    DeviceFileSupported
    DeviceName
    DeviceID
    VideoInputConstructor
    VideoDeviceConstructor
    SupportedFormats
    
%查看Device2的資訊：	//查看特定裝置的資訊
device2 = winvideoinfo.DeviceInfo(2)
name2   = winvideoinfo.DeviceInfo(2).DeviceName
format2 = winvideoinfo.DeviceInfo(2).SupportedFormats
 







%相位補償資料
clear,clc,clf
angle=[30 35 40 45 50 55 60 65 70 75 80 85];
speed=[5.46 5.52 5.72 5.80 5.82 5.88 5.96 5.82 5.78 5.70 5.66 5.62];
current=[758 715 666 645 630 620 612 638 664 697 740 780];
speed = speed *1e-3;
speed2=1./(speed.*2)./2.*60;
plot(speed2,'r*-');
%plotyy(angle,speed2,'r*-',angle,current,'b*-')
%plotyy(angle,speed2,angle,current)
[AX,H1,H2] = plotyy(angle,speed2,angle,current,'plot');
grid on
legend('轉速','電流')
xlabel('phase angle(degree)','fontname','宋體','fontsize',20,'fontweight','bold','color','r')
%ylabel('speed(rpm)','fontname','宋體','fontsize',20,'fontweight','bold','color','r')

set(get(AX(1),'Ylabel'),'String','轉速(rpm)','fontname','宋體','fontsize',20,'fontweight','bold','color','b')
set(get(AX(2),'Ylabel'),'String','電流(mA)','fontname','宋體','fontsize',20,'fontweight','bold','color','g')


set(H1,'LineWidth',3,'LineStyle','--','Color','b', 'marker', 'o')
set(H2,'LineWidth',3,'LineStyle',':','Color','g', 'marker', 'o')







clear,clc,clf

a=[0 18.4 18.4 18.4 18.4 15.4 15.4 12.3 9.2 9.2 6.1 6.1 6.1 6.1 6.1 6.1 3 3 3 3 3 3 2.8 2.6 2.4 2.2 2.0 1.8 1.6 1.4 1.3 1.2 1.1 1.0 0.9 0.8 0.7 0.6];

for k = 1: length(a)
t(k) = sum(a(1:k))
end

X=[t(1),t(1),t(2),t(2)];Y=[0,3,3,0];line(X,Y,'linewidth',3,'color','r');hold on;
X=[t(2),t(2),t(3),t(3)];Y=[0,4,4,0];line(X,Y,'linewidth',3,'color','r');hold on;
X=[t(3),t(3),t(4),t(4)];Y=[0,4,4,0];line(X,Y,'linewidth',3,'color','r');hold on;
X=[t(4),t(4),t(5),t(5)];Y=[0,5,5,0];line(X,Y,'linewidth',3,'color','r');hold on;
X=[t(5),t(5),t(6),t(6)];Y=[0,5,5,0];line(X,Y,'linewidth',3,'color','r');hold on;
X=[t(6),t(6),t(7),t(7)];Y=[0,6,6,0];line(X,Y,'linewidth',3,'color','r');hold on;
X=[t(7),t(7),t(8),t(8)];Y=[0,6,6,0];line(X,Y,'linewidth',3,'color','r');hold on;
X=[t(8),t(8),t(9),t(9)];Y=[0,6,6,0];line(X,Y,'linewidth',3,'color','r');hold on;
X=[t(9),t(9),t(10),t(10)];Y=[0,7,7,0];line(X,Y,'linewidth',3,'color','r');hold on;
X=[t(10)+0.3,t(10)+0.3,t(11),t(11)];Y=[0,7,7,0];line(X,Y,'linewidth',3,'color','b');hold on;
line([t(11)+3 t(15)]-2, [4 4], 'LineStyle', '--','linewidth',3,'color','b');
X=[t(15),t(15),t(16),t(16)];Y=[0,7,7,0];line(X,Y,'linewidth',3,'color','b');hold on;

X=[t(16)+0.3,t(16)+0.3,t(17),t(17)];Y=[0,7,7,0];line(X,Y,'linewidth',3,'color','g');hold on;
line([t(17)+3 t(21)]-2, [4 4], 'LineStyle', '--','linewidth',3,'color','g');
X=[t(21),t(21),t(22),t(22)];Y=[0,7,7,0];line(X,Y,'linewidth',3,'color','g');hold on;

X=[t(22)+0.3,t(22)+0.3,t(23),t(23)];Y=[0,8,8,0];line(X,Y,'linewidth',3,'color','r');hold on;
X=[t(23),t(23),t(24),t(24)];Y=[0,9,9,0];line(X,Y,'linewidth',3,'color','r');hold on;
X=[t(24),t(24),t(25),t(25)];Y=[0,10,10,0];line(X,Y,'linewidth',3,'color','r');hold on;
X=[t(25),t(25),t(26),t(26)];Y=[0,11,11,0];line(X,Y,'linewidth',3,'color','r');hold on;
X=[t(26),t(26),t(27),t(27)];Y=[0,12,12,0];line(X,Y,'linewidth',3,'color','r');hold on;
X=[t(27),t(27),t(28),t(28)];Y=[0,13,13,0];line(X,Y,'linewidth',3,'color','r');hold on;
X=[t(28),t(28),t(29),t(29)];Y=[0,14,14,0];line(X,Y,'linewidth',3,'color','r');hold on;
X=[t(29),t(29),t(30),t(30)];Y=[0,15,15,0];line(X,Y,'linewidth',3,'color','r');hold on;
X=[t(30),t(30),t(31),t(31)];Y=[0,16,16,0];line(X,Y,'linewidth',3,'color','r');hold on;
X=[t(31),t(31),t(32),t(32)];Y=[0,17,17,0];line(X,Y,'linewidth',3,'color','r');hold on;
X=[t(32),t(32),t(33),t(33)];Y=[0,18,18,0];line(X,Y,'linewidth',3,'color','r');hold on;
X=[t(33),t(33),t(34),t(34)];Y=[0,19,19,0];line(X,Y,'linewidth',3,'color','r');hold on;
X=[t(34),t(34),t(35),t(35)];Y=[0,20,20,0];line(X,Y,'linewidth',3,'color','r');hold on;
X=[t(35),t(35),t(36),t(36)];Y=[0,21,21,0];line(X,Y,'linewidth',3,'color','r');hold on;
X=[t(36),t(36),t(37),t(37)];Y=[0,22,22,0];line(X,Y,'linewidth',3,'color','r');hold on;
X=[t(37),t(37),t(38),t(38)];Y=[0,23,23,0];line(X,Y,'linewidth',3,'color','r');hold on;

axis([0 t(38)+2 1 24]);grid on;

text(3,2,'18.4','FontSize',30,'Color','r');text(21.2,2,'18.4','FontSize',30,'Color','r');
text(40,2,'18.4','FontSize',30,'Color','r');text(58,2,'18.4','FontSize',30,'Color','r');
text(75,2,'15.4','FontSize',30,'Color','r');text(90,2,'15.4','FontSize',30,'Color','r');
text(105,2,'12.3','FontSize',25,'Color','r');
text(119,2,'9.2','FontSize',20,'Color','r');
text(128,2,'9.2','FontSize',20,'Color','r');
text(136,2,'6.1','FontSize',15,'Color','r');

text(5,4,'六','FontSize',30,'Color','r');
text(24.2,4.8,'六','FontSize',30,'Color','r');
text(42,4.8,'二','FontSize',30,'Color','r');
text(61,5.8,'二','FontSize',30,'Color','r');
text(77,5.8,'三','FontSize',30,'Color','r');
text(92,6.8,'三','FontSize',30,'Color','r');
text(107,6.8,'三','FontSize',30,'Color','r');
text(119,6.8,'三','FontSize',30,'Color','r');
text(127,7.8,'三','FontSize',30,'Color','r');
text(142,7.8,'連續30步','FontSize',30,'Color','b');
text(170,7.8,'等0.5秒','FontSize',30,'Color','g');
text(160,16,'加速duty/50msec','FontSize',30,'Color','r');

xlabel('time(msec)','fontname','宋體','fontsize',20,'fontweight','bold','color','r')
ylabel('duty(%)','fontname','宋體','fontsize',20,'fontweight','bold','color','r')


annotation('arrow',[0.15 0.55],[0.45,0.45],'linewidth',3,'Color','r');

text(50,11.5,'Freerun 加速','FontSize',30,'Color','r');














----------------Matlab文章一大堆 ST----------------

Matlab 入門教學：撥放 WAV 音樂檔案
http://lolikitty.pixnet.net/blog/category/2713323





Matlab看圖片資訊
 info = imfinfo('Image1.jpg')

播放圖片
imshow('Image1.jpg')

看影片資訊
>> VideoReader('HODV-21020.mp4')







>> peaks(60)
>> colorbar
>> colorbar('horiz')



利用pcode產生p碼檔




title('這是一個測試','fontname','宋體','fontsize',20,'fontweight','bold')
title('這是一個測試','fontname','宋體','fontsize',10,'fontweight','bold','color','r')
title('這是一個測試','fontname','宋體','fontsize',10,'fontweight','bold','color','r','rotation',30)	//逆時針轉30度

xlabel('\it這是一個測試','fontname','宋體','fontsize',10,'fontweight','bold','color','r')	//斜體






%line畫直線
x=0.1:0.1:2*pi;
y=sin(x);
line(x,y)




x = -pi:pi/10:pi;
y = sin(x);
plot(x,y,'--rd','LineWidth',4,...		%線寬
             'MarkerEdgeColor','k',...		%標記點邊框的顏色
             'MarkerFaceColor','y',...		%標記點的顏色
             'MarkerSize',15);			%標記點的大小





Chirp()	//掃頻訊號
square()	//方波訊號


%duty=70%，震幅為0～5的方波
t=0:0.01:30;
%x=(square(t,70)+1)*3;
x=(square(t,70)+1);
plot(t,x,'Linewidth',2);


axis([0 30 0 7]);

set(gca,'xlim',[0 30])




%clear all;
t=-8:0.01:8;
y=sinc(t);
plot(t,y)

獲取影像檔的資訊
info = imfinfo('C:\______test_vcs\bear.jpg', 'jpg')

顯示圖片
I = imread('C:\______test_vcs\bear.jpg');
imshow(I)

Matlab之圖像瀏覽器
imtool('C:\______test_vcs\bear.jpg');

圖像的數值加減
I = imread('C:\______test_vcs\bear.jpg');
J=imadd(I,60);	%變亮
imshow(J)

I = imread('C:\______test_vcs\bear.jpg');
J=imsubtract(I,60);	%變暗
imshow(J)

J=immultiply(I,0.5);	%乘0.5，變暗

J = imrotate(I, 30);	%逆時針旋轉30度




matlab曲线拟合 函数 用法以及例子
http://jingyan.baidu.com/article/9c69d48f409c6013c9024e8c.html



曲線擬合圖形使用者介面

x=[0.2 0.3 0.5 0.6 0.8 0.9 1.2 1.3 1.5 1.8];
y=[1 2 3 5 6 7 6 5 4 1];
plot(x,y,'bo')

在Figure裡面，
按Tools/Basic Fitting
勾選5th degree polynomial







t=(0:0.001:1)';
w=60;
y=sin(2*pi*w*t);% + 2*sin(2*pi*(2*w)*t);
randn('state', 0);
yn=y+0.5*randn(size(t));
plot(t(1:50),y(1:50),'r');hold on
plot(t(1:50),yn(1:50),'g')

'



改
Simulation/Configuration Parameters/Diagnostics/Automatic solver parameter selection/none
Simulation/Solver/Max step size/預設0.2，可以改細一些






做Matlab改變刻度範例
以pi/3、2pi/3、pi為刻度，準備做成tau=RC為刻度之圖


pulse generator

matlab/vcs 之 signal generator

matlab/vcs 如何製造noise






---新進暫存------------------------------------------------------------------------------------------


Simulink之source有無方法吃一個文字檔、變成信號源？





http://blog.csdn.net/sinat_20265495/article/details/50888093



在matlab提示符下輸入powerlib命令,就可以打開電气系統仿真模塊集SimPowerSystems, ...


在命令窗口中输入powerlib 将打开电力系统的工具箱

http://www.doczj.com/doc/aeb2d8d2804d2b160a4ec02d-5.html



http://www.doc01.cc/hkqpcxle.html





Simulink不支援中文檔名




依序點名：
name = {'Alpha','Bravo','Charlie','Delta','Echo', ...
	'Foxtrot','Golf','Hotel','India','Julia'};
for k = 1: length(name)
	display(name{k}),
	pause(1)
end





http://jiaoyu.movesee.com/





Matlab Simulink範例說明：
file:///C:/Program%20Files/MATLAB/R2013a/toolbox/physmod/simscape/simscapedemos/html/ssc_new_elec.html

Matlab輸入
>> ssc_new
>> ssc_new_elec
可得simulink的範本



---網頁------------------------------------------------------------------------------------------



matlab class
http://matlab-hcchao.blogspot.tw/

http://ad87515.pixnet.net/blog/post/184509473


https://www.mathworks.com/help/matlab/ref/fft.html

http://bime-matlab.blogspot.tw/2006_12_31_archive.html


http://lolikitty.pixnet.net/blog/post/187202991


Matlab課程
http://www.yorku.ca/jdc/Matlab/

程序系統工程(PSE)研究室	鄭智成 副教授	有matlab教學
http://www.cc.ntut.edu.tw/~jcjeng/
http://www.cc.ntut.edu.tw/~jcjeng/Matlab_Program.pdf

MATLAB 之工程應用
http://bime-matlab.blogspot.tw/
http://bime-matlab.blogspot.tw/2006/10/935.html
http://bime-matlab.blogspot.tw/2006/10/935.html
http://bime-matlab.blogspot.tw/2006/10/33-if.html

http://www.bisonacademy.com/index.html

http://ee.hacettepe.edu.tr/~solen/Matlab/MatLab/

http://aparate.elth.ucv.ro/POPA/Matla/
http://aparate.elth.ucv.ro/POPA/Matla/tutorialElectro.pdf

https://www.hs-augsburg.de/~wohlfart/download/
https://www.hs-augsburg.de/~wohlfart/download/folien_simulink_grund_e.pdf
http://oz.nthu.edu.tw/~u9762127/hhpeng/slide_icpl_2016/Lec12_Function_20160525.pdf

MATLAB教學
http://www.ecaa.ntu.edu.tw/weifang/matlab/index-matlab.htm


Matlab課程
http://www.cs.cornell.edu/courses/cs100m/2007fa/


Hsu-Hsia Peng	教學網	有matlab
http://oz.nthu.edu.tw/~u9762127/hhpeng/course.html

彭旭霞	Matlab
http://oz.nthu.edu.tw/~u9762127/hhpeng/c_icpl_syllabus_2017.html
http://oz.nthu.edu.tw/~u9762127/hhpeng/slide_icpl_2016/Lec14_CurveFitting&Excel_20160601.pdf






matlab打印希臘字母、特殊符號
https://www.mathworks.com/help/matlab/creating_plots/greek-letters-and-special-characters-in-graph-text.html

Index of /~gmirchan/classes/EE275/2012/Matlab
http://www.emba.uvm.edu/~gmirchan/classes/EE275/2012/Matlab/

Index of /prophys/ael/File/2011
http://ezphysics.nchu.edu.tw/prophys/ael/File/2011/



matlab powerlib

http://aecl.ee.nchu.edu.tw/drupal/AECL/course/102_2/Control%20Lab/Slide/Lec03.pdf
http://aecl.ee.nchu.edu.tw/drupal/AECL/course/101_2/Control_lab/Slide/Lec09.pdf

http://www.iaa.ncku.edu.tw/~chiehli/course/control/Homeworks%202-10%20Dorf%2012ed.pdf


Matlab 課程 教學資源

http://faculty.stust.edu.tw/~tang/matlab/

A simple BLDC speed control by SimuLink
http://faculty.stust.edu.tw/~tang/BLDC/A%20simple%20BLDC%20control%20by%20SimuLink.htm



Matlab Tutorial- Low Pass Filter (Part 1)
https://www.youtube.com/watch?v=RqftMXga3x4


ocw.nthu.edu.tw/ocw/upload/53/663/10-曲線擬合與迴歸分析.ppt

汪群超 Chun-Chao Wang
http://web.ntpu.edu.tw/~ccw/statmath/book.htm

https://ntpuccw.wordpress.com/supplements/matlab-in-statistical-computing/


http://web.ntpu.edu.tw/~ccw/statmath/






输入端Inport 和电路模块之间应该用Controlled Voltage Source或Controlled Current Source进行转换，
输出端Outport和电路模块之间用Voltage Measurement或Current Measurement进行转换。

simulink中小方块与小箭头如何连接？
小方块是电气线路，小箭头是信号流，他们之间是不能连接的。
从信号到电气有受控源，从电气到信号有电压电流测量模块。







Simulink電子電路

Simscape/Foundation Library/Electrical/Electrical Elements/Capacitor
							   Resistor
							   Inductor
							   Diode
							   Op-Amp
							   Ideal Transformer
							   Electrical Reference(GND)
Simscape/Foundation Library/Electrical/Electrical Sources/AC Voltage Source
Simscape/Foundation Library/Electrical/Electrical Sensors/Voltage Sensor

Utilities/Solver Configuration	連到GND
Utilities/PS-Simulink Converter	轉輸出到Scope

Solver改選用：ode15s

Simulink電力電子


Simulink建模RC電路

電源：
Simscape/SimPowerSystems/Electrical Sources/AC Current Source、AC Voltage Source、、、、

RLC元件：
Simscape/SimPowerSystems/Elements/Series RLC Branch	串聯RLC分支

地：
Simscape/SimPowerSystems/Elements/Ground

量測：
Simscape/SimPowerSystems/Measurements/Voltage Measurement


Voltage Measurement再輸出給Scope


要加選：
Simscape/SimPowerSystems/powergui

Breaker 電路斷路器

while(1)

K = menu('Choose a key','A','B','C','D','E','F');

t=(0:2000)./8192;
w=K*pi*500;
sout=sin(w.*t);
%sout=chirp(w.*t);
sound(sout,8192);
plot(t(1:50),sout(1:50))

end



axis('off') 關閉座標系統
歷回台灣人口普查
年份 	人口 	 %±


popolation=[
1905 	3039751
1920 	3955308
1930 	4592537
1940 	5872084
1956 	9311312
1966 	13348096
1980 	17968797
1990 	20286174
2000 	22226879
2010 	23052047
]


K = menu('Choose a color','Red','Blue','Green');
if K == 1
	display('You selected Red');
elseif K == 2
	display('You selected Blue');
elseif K == 3
	display('You selected Green');
else
	display('You did not select a color');
end


製造一個方波
    For example, generate a 30 Hz square wave:
         t = 0:.0001:.0625;
         y = square(2*pi*30*t);, plot(t,y)





fx=@sind;fplot(fx,[0 360])


Create line plot using specific line width, marker color, and marker size.
x = -pi:pi/10:pi;y = sin(x);plot(x,y,'--rs','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',10)


x = -pi:pi/10:pi;plot(sin(x),'r');hold on;plot(sin(x+pi/4),'g')


可否讀出mp3之資訊，改寫並寫回？

目前Matlab可以讀出mp3資訊，可否改寫並寫回？

magic matrix有何用途






製作一個方波：	改變x軸刻度
ip = [zeros(1,25) ones(1,75) zeros(1,25)]; 	% step input
plot([0:length(ip)-1]/fsMHz,ip,'b.-');


fsMHz = 10; 	% frequency, MHz
ip = [zeros(1,25) ones(1,75) zeros(1,25)]; 	% step input
plot([0:length(ip)-1]/fsMHz,ip,'b.-');


xlabel('time, \mus')







Matlab test RC circuit

V=5;R=100e3;C=1e-6;
t=0:0.01:0.5;
VC=V*(1-exp(-t/(R*C)));
I=V/R*(exp(-t/(R*C)));
subplot(411);plot(t,VC);
subplot(412);plot(t,I)


V=5;R=100e3;C=1e-6;Q0=5*C;
t=0:0.01:0.5;

VC=Q0/C*(exp(-t/(R*C)));
I=-Q0/C*(exp(-t/(R*C)));
subplot(413);plot(t,VC);
subplot(414);plot(t,I)


format short 3.1416 5位的數字
format long 3.14159265358979 15位的數字

MATLAB系統指令：
doc
demo
demo simulink
pathtool	//增刪路徑
addpath
ver		//顯示matlab和工具盒的版本
what		//搜尋.m、.mex、.mat檔
which		//找出某檔案所在的路徑
path		//顯示path
clear		//清除所有的變數內容
home		//游標回到home
edit XXX.m	//用m-editor開啟.m檔
membrane



MATLAB用單引號(Single Quote)來界定字串變數
 C語言用雙引號(Double Quote)來界定字串變數


MATLAB的邏輯運算元(Logical Operators)
&	AND
|	OR
~	NOT


MATLAB的switch不用加break


簡易畫函數方法：
fplot('sind',[0 360])
plot(sind(0:1:360))


針頭圖(stem plots)
空心
>> t=0:0.2:4*pi;y=cos(t).*exp(-t/5);stem(t,y)
實心
>> t=0:0.2:4*pi;y=cos(t).*exp(-t/5);stem(t,y,'fill')
>>

stem範例：

clear,clc,clf
x=[0:0.3:4*pi];
y=sin(x);
subplot(211);stem(x,y,'fill'),grid on	%有加fill是實心點，沒加fill是空心點
subplot(212);plot(x,y,'*-'),grid on

積分 x^2+2*x+3，由1積到3
syms x, int(x^2+2*x+3,1,3)



aa=0:1:60;bb=sind(aa*3);cc=floor(40*bb);plot(cc);cc

duty=0:1:100;tmp=(100-duty)*400/100,PWMH=floor(tmp/256),PWML=mod(tmp,256)



目前kilo的Matlab用R2013a
目前oscar的Matlab用R2011b

julia
------------------------------------------------------------------------------------------------
MATLAB Version: 8.1.0.604 (R2013a)
MATLAB License Number: 724504
Operating System: Microsoft Windows 7 Version 6.1 (Build 7600)
Java Version: Java 1.6.0_17-b04 with Sun Microsystems Inc. Java HotSpot(TM) Client VM mixed mode
------------------------------------------------------------------------------------------------
MATLAB                                                Version 8.1        (R2013a)


kilo
>> ver
------------------------------------------------------------------------------------------------
MATLAB Version: 8.1.0.604 (R2013a)
MATLAB License Number: 724504
Operating System: Microsoft Windows 7 Version 6.1 (Build 7600)
Java Version: Java 1.6.0_17-b04 with Sun Microsystems Inc. Java HotSpot(TM) Client VM mixed mode
------------------------------------------------------------------------------------------------

oscar
-------------------------------------------------------------------------------------
MATLAB Version 7.13.0.564 (R2011b)
MATLAB License Number: 161052
Operating System: Microsoft Windows XP Version 5.1 (Build 2600: Service Pack 3)
Java VM Version: Java 1.6.0_17-b04 with Sun Microsystems Inc. Java HotSpot(TM) Client VM mixed mode
-------------------------------------------------------------------------------------




曲線擬合 （Curve Fitting）  The more, the better?


%AC電源
clear,clc,clf
step=0.0001;
%t=0:step:17e-3;
t=0:step:0.1;
VDC=310;
freq=60;
y=VDC*sin(2*pi*freq*t);
plot(t,y);




MATLAB 多行注释的方法

%{
若干语句
%}



t=0:0.01:18;
%y=80*sin(2*pi*1*t);
y=80*sin(2*pi*1*t).*exp(-t/5);
subplot(2,2,1), plot(y); % 原檔案的音波

s = fft(y); % 快速傅立葉轉換
f = abs(s); % 取絕對值
subplot(2,2,2), plot(f); % 原檔案的頻譜

y2 = ifft(s); % 快速傅立葉反轉換
subplot(2,2,3), plot(y2); % 快速傅立葉反轉換後的音波

f2 = abs(fft(y2)); % 快速傅立葉反轉換 後的結果 再進行一次快速傅立葉轉換
subplot(2,2,4), plot(f2); % 快速傅立葉反轉換後的頻譜



logspace(0,2,8)
    1.0000    1.9307    3.7276    7.1969   13.8950   26.8270   51.7947  100.0000
其值落於10^0(=1)與10^2(=100)之間,其對數值係以10為底。點數8點。


       x = -pi:pi/10:pi;
       y = tan(sin(x)) - sin(tan(x));
       plot(x,y,'--rs','LineWidth',2,...
                       'MarkerEdgeColor','k',...
                       'MarkerFaceColor','g',...
                       'MarkerSize',10)
plot(Point,freq,'r','LineWidth',3);hold on;


>> x=0:0.1:20;y1=sin(x);y2=cos(x);plot(x,y1,'r.',x,y2,'gx')
>> x=0:0.1:20;y1=sin(x);y2=cos(x);plot(x,y1,'r.',x,y2,'gx')


曲線擬合圖形使用者介面
x=[1:10];y=[1 5 8 4 3 1 8 9 10 3];plot(x,y,'o')
plot完後，在Figure/Tools/Basic Fitting/Plot fits/選5th degree polynimial


matlab
把兩條線畫在一起
x=0:0.1:20;y1=sin(x);y2=cos(x);plot(x,y1,'r.',x,y2,'gx')

matlab畫圖
顏色：rgb黑白cmy	cyan青綠色、magenta洋紅色
符號：.ox+* sdv^ <>ph
. Point
o circle
x x-mark
+ plus
* star

s square 正方形
d diamond 菱形
v triangle(down)
^ triangle(up)

< triangle(left)
> triangle(right)
p pentagram	正五邊形
h hexagram      六邊形

-	solid
:	dotted
-.	dashdot
--	dashed
(none)	no line


%spline範例
a=[0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0];
b=[3 1 2 5 1 3 4 1 2 5];
xx=0.1:0.01:1;
yy=spline(a,b,xx);
plot(a,b,'bo',xx,yy)

>> whos
  Name      Size            Bytes  Class     Attributes
  AAAA      5x5               200  double
  aaaa      5x5               200  double
變數有分大小寫、指令皆用小寫

gtext	用滑鼠點選位置顯示文字

gtext({'第一行字','第二行字'})
gtext({'第一行字','第二行字'},'FontName','Times','Fontsize',12)

把資料存起來、把資料叫出來
存起來，存成ASCII格式：
zz = ones(5,3);save aaa.dat zz /ascii
load aaa.dat		%叫出來，自動變成以檔名命名的變數：
bbb = load('aaa.dat')	%叫出來，變成以bbb命名的變數：


求餘數：
rem(20,7)	就是20%7

四捨五入
round

多項式：
x^3+2x^2+3^x+4的根：
aa=[1 2 3 4];roots(aa)
ans =
  -1.6506 + 0.0000i
  -0.1747 + 1.5469i
  -0.1747 - 1.5469i

根為1 2 3，求多項式：
bb=[1 2 3];poly(bb)
ans =
     1    -6    11    -6
也就是x^3-6x^2+11^x-6

----------------Simulink ST----------------



Matlab支援的畫圖顏色：
           b     blue
           g     green
           r     red
           c     cyan 青綠色
           m     magenta 洋紅色的
           y     yellow
           k     black
           w     white


在Simulink的Mux進Scope裡面，信號的顏色依序是：ymcrgb






tout點數：

Configuration Parameters/Solver/Simulation time:
Start time: 0.0
Stop time: 20.0


Configuration Parameters/Solver/Solver options:
Max step size: 0.1	(預設為0.2)

tout內容為：0:0.1:20，共201點

Out1的點數同tout，Out1的變數名稱為yout


Matlab輸入simulink，開啟Simulink。
File/New/Model

Simulation/Model Configuratin Parameters/改Simulation time
Simulation/Run

Simulink/Sources/Signal Generator
Simulink/Sources/Pulse Generator

Simulink/Sinks/Scope
	Scope內畫多個圖：寫 Number of Axes	//類似subplot
Simulink/Math Operations/Gain
多個channel同時進示波器
	Simulink/Signal Routing/Mux		//類似hold on，把多個信號畫在同一張圖
把信號結果同時傳進Matlab
Simulink/Ports&Subsystems/Out1

Simulink/Sinks/Out1	//至Matlab工作平台

電力系統
Simscape/SimPowerSystems
Simscape/SimPowerSystems/Electrical Sources	電源
Simscape/SimPowerSystems/Elements		電器元件
Simscape/SimPowerSystems/Power Electronics	電力電子元件
Simscape/SimPowerSystems/Machines		電機
Simscape/SimPowerSystems/Measurements		電氣量測儀表
Simscape/SimPowerSystems/Application Libraries	應用程序

simulink描述AC220
Sine Wave之Amplitude=310，Frequency(rad/sec)=2*pi*60，
模擬時間：Start Time = 0, Stop Time = 0.08 = 80msec
Max step size = 0.001 = 1msec

----------------simulink SP----------------



畫三相60Hz信號
sine wave信號，Frequency(rad/sec) 填 2*pi*60
sine wave信號，Frequency(Hertz)   填      60
Phase(rad) 填 0、2*pi/3、4*pi/3


%generate a 60 Hz square wave:
f=60;
t = 0:0.0001:0.1;
w=2*pi*f;
y = square(w*t);
plot(t,y)
axis([0 0.1 -1.2 1.2])

雙縱軸繪圖 plotyy
plotyy	//一張圖畫兩個y座標
       	a=[1:10];b=[11:20];c=[ 2 5 6 2 5 8  5 5 8 2];d=[ 10 15 11 13 18 14 16 11 13 16];plotyy(a,c,b,d);
       	以a為x座標，以b為x座標，c為左邊的y座標，d為右邊的y座標。x軸共用y軸刻度不同。
       	但不知如何在一張圖化兩個x座標。
       	不知如何改變連線的格式
       	不知如何寫y2的label

%雙縱軸繪圖plotyy，y軸畫不同刻度
x=linspace(0, 2*pi,100);
y1=sin(x);
y2=exp(-x);
plotyy(x,y1,x,y2)

%雙縱軸繪圖plotyy
x=0.1:0.1:2*pi;
y=sin(x);
z=2.^x;
plotyy(x,y,x,z)





左移、右移
VBUS=6494400;bitsra((bitsra(VBUS,12)*310),13)


result=170;bitsll((bitsll(VBUS,13)/310),12)




clear,clc,clf
Point = 0:10:1000;
freq=(16e6./(1.*Point*2))/1000;
plot(Point,freq,'r','LineWidth',3);hold on;
%grid on;
axis([0 1000 0 50]);
xlabel('PWM period(point)');
ylabel('PWM frequency(kHz)');
line([512 512]',[0 100]');hold on;
line([448 448]',[0 100]');hold on;
text(525,8,'512 points, 15.625kHz')
text(400,23,'448 points, 17.857kHz')






clear,clc,clf
aa=1:1:1000

for i=1:500
    if (mod(aa(i),100)>=65)
        bb1(i)=0;
        bb2(i)=1;
    elseif (mod(aa(i),100)>=45)
        bb1(i)=1;
        bb2(i)=0;
    else
        bb1(i)=0;
        bb2(i)=1;
    end
end




for i=501:1000
    if (mod(aa(i),100)>=85)
        bb1(i)=0;
        bb2(i)=1;
    elseif (mod(aa(i),100)>=15)
        bb1(i)=1;
        bb2(i)=0;
    else
        bb1(i)=0;
        bb2(i)=1;
    end
end



%plot(aa,bb1+1.5,'LineWidth',3);axis([0 1000 -0.5 3.5]);
plot(bb1+1.5,'LineWidth',3);axis([0 1000 -0.5 3]);
hold on;
%plot(aa,bb2,'LineWidth',3);
plot(bb2,'LineWidth',3);
grid on;

%text(2,2.0,'PWM AP');
%text(2,0.5,'PWM AN');



畫線指令line：
連線(0,5)、(10,18)、(20,10)、(30,25)、(40,13)、(50,28)、(60,20)：
X=[0 10 20 30 40 50 60];
Y=[5 18 10 25 13 28 20];
h=line(X,Y)

連線(5,3)、(2,5)：
h=line([5 2],[3 5]);

set(h, 'LineWidth',2,{'LineStyle'},{'--';':';'-.'})
set(h, {'Color'},{'r';'g';'b'})
set(h, 'LineWidth',5)		//設定線寬
set(h, 'Color','g')		//設定線色
set(h, 'LineStyle','--')	//設定樣式 '--'  ':'  '-.'

legend(h, 'First','Last')
title('Test of the Graph')
text(x,y,'Say Hello to Everyone')


bar的語法：
a=[1 2 3; 4 5 6; 7 8 9; 10 11 12]	%4個row
bar(a)			%每個row為一群(由左而右)
bar(a,'grouped')	%每個row為一群(由左而右)
bar(a,'stacked')	%每個row疊在一起(由下而上)

colormap的語法：
colormap(hot)
colormap(lines)
colormap(spring)
colormap('default')	%恢復預設, jet
可用的：jet, hsv, hot, cool, spring, summer, autumn, winter, gray, bone, copper, pink, lines.



figure(4)	%指定圖片編號
grid		%就是grid on
axis([0.9 1 -400 400])
ylabel('V_L_C_A [V]') 		%字的前面加_，會讓字變小
xlabel('Time [Sec]')

指定 X 或 Y 軸的範圍可使用 XLIM 和 YLIM 指令
xlim([-10 30])  % 改變 X 軸範圍
ylim([-2 2]) 	% 改變 Y 軸範圍


改變刻度與刻度名稱：	(以x軸為例)

x=0:600;
plot(sind(x));	%x軸刻度為0、100、200、300、400、、、

xtk=0:60:600;   % 更改後的刻度
set(gca,'xtick',xtk);	%這樣，刻度就會變成0 60 120 180 240、、、

xtk_label={'A','B','C','D','E','F','G','G','I','J','K'};	% 更改坐標軸名稱
set(gca,'xticklabel',xtk_label);	%這樣，刻度就會變成A B C D E、、、

把y軸刻度清除：
ytk_label={' ',' ',' '};
set(gca,'yticklabel',ytk_label);




%改變刻度與刻度名稱：	(以x軸為例)
%每60度為一格
x=0:720;plot(x,sind(x));	%x軸刻度為0、100、200、300、400、、、
xtk=0:60:720;   % 更改後的刻度
set(gca,'xtick',xtk);	%這樣，刻度就會變成0 60 120 180 240、、、


%改變刻度與刻度名稱：	(以x軸為例)
%每pi/3弧度為一格
x=0:0.01:4*pi;plot(x,sin(x));	%x軸刻度為0、100、200、300、400、、、
xtk=0:pi/3:4*pi;   % 更改後的刻度
set(gca,'xtick',xtk);	%這樣，刻度就會變成0 60 120 180 240、、、
xtk_label={'0','p/3','2p/3','p','4p/3','5p/3','2p','7p/3','8p/3','3p','10p/3','11p/3','4p'};	% 更改坐標軸名稱
set(gca,'xticklabel',xtk_label,'fontname','symbol','fontsize',20);	%這樣，刻度就會變成上述label


畫圓型派圖

pie([2 4 3 5],{'North','South','East','West'})
//畫一派圖，比例為2:4:3:5，並標明名稱。
pie(1:3,{'Taxes','Expenses','Profit'})
//畫一派圖，比例為1:2:3，並標明名稱。

pp=[44647 50614 40740 48415 44618 50527]
pie(pp)	//按各比例畫派圖。

pie3(1:3,{'Taxes','Expenses','Profit'})
//承上，立體派圖

 pie3([2 4 3 5],[0 1 1 0],{'North','South','East','West'})
 //承上，立體派圖，South、East兩塊裂出

%畫出兩個派圖：
X = 1:11;
ax1 = subplot(1,2,1);
pie(ax1,X)
title(ax1,'2012');

Y = 12:17;
ax2 = subplot(1,2,2);
pie(ax2,Y)
title(ax2,'2013');


a為一為陣列

a=[4232 4957 4604 5284 4195 4994 4599 5252 4229 4977 4573 5291 4228 4965 4352 5282 4201 5001];
max(a)		//取最大者
min(a)		//取最小者
median(a)	//取中位數
mean(a)		//取平均數
std(a)		//取標準差
unique(a)	//去除重複元素
sort(a,'ascend')	//排列，由小到大
sort(a,'descend')	//排列，由大到小



sind、cosd、tand	//用degree為單位的三角函數運算

印出希臘字母及text的用法：

x=[-2*pi():.1:2*pi()];
plot(x,pi*sin(x))
axis([0 10 0 10])

text(1,1,'\alpha :'); text(2,1,'\\alpha');
text(1,2,'\beta :'); text(2,2,'\\beta');
text(1,3,'\gamma :'); text(2,3,'\\gamma')
text(1,4,'\delta :'); text(2,4,'\\delta')
text(1,5,'\epsilon :'); text(2,5,'\\epsilon')
text(1,6,'\kappa :'); text(2,6,'\\kappa')
text(1,7,'\lambda :'); text(2,7,'\\lambda')
text(1,8,'\mu :'); text(2,8,'\\mu')

text(3,1,'\nu :'); text(4,1,'\\nu')
text(3,2,'\omega :'); text(4,2,'\\omega')
text(3,3,'\phi :'); text(4,3,'\\phi')
text(3,4,'\pi :'); text(4,4,'\\pi')
text(3,5,'\chi :'); text(4,5,'\\chi')
text(3,6,'\psi :'); text(4,6,'\\psi')
text(3,7,'\rho :'); text(4,7,'\\rho')
text(3,8,'\sigma :'); text(4,8,'\\sigma')

text(5,1,'\tau :'); text(6,1,'\\tau')
text(5,2,'\upsilon :'); text(6,2,'\\upsilon')
text(5,3,'\Sigma :'); text(6,3,'\\Sigma')
text(5,4,'\Pi :'); text(6,4,'\\Pi')
text(5,5,'\Lambda :'); text(6,5,'\\Lambda')
text(5,6,'\Omega :'); text(6,6,'\\Omega')
text(5,7,'\Gamma :'); text(6,7,'\\Gamma')



畫圖刻度用pi來表示、圖標使用pi：

x=[-2*pi():.1:2*pi()];
plot(x,pi*sin(x))

set(gca,...
 'xlim',[-2*pi() 2*pi()],...
 'xtick',[-2*pi():pi()/2:2*pi()],...
 'xticklabel',{'-2p' '-3p/2' '-p' '-p/2' '0' 'p/2' 'p' '3p/2' '2p'},...
 'ylim',[-pi() pi()],...
 'ytick',[-pi():pi()/2:pi()],...
 'yticklabel',{'-p' '-p/2' '0' 'p/2' 'p'},...
 'fontname','symbol',...
 'fontsize',20)

xlabel('angle \phi from -2\pi to 2\pi',...
 'fontname','helvetica',...
 'fontsize',30)
ylabel('\pi*sin(\phi)',...
 'fontname','helvetica')




繪圖指令中有關線條顏色、樣式設定的代號：
一、顏色：(rgb黑白cmy)
b: 藍色
c: 藍綠色
g: 綠色
k: 黑色
m: 紫紅色
r: 紅色
w: 白色
y: 黃色
二、符號：
.	點圖
o	圓圈
x	X符號圖
+	加符號圖
*	星星符號圖
-	時線圖
:	冒號符號圖
-.	虛線和點合併圖
--	虛線圖

x=1:1:length(R);
plot(x,R,'r*-');hold on;
plot(x,G,'go-');hold on;
plot(x,B,'bx-');hold on;

% RC電路
R=1;C=1;
t=linspace(0,20*3,200*3);
t2=t-10*floor(t./10);
V0=[linspace(1,1,100) linspace(0,0,100) linspace(1,1,100) linspace(0,0,100) linspace(1,1,100) linspace(0,0,100)];
VR=V0.*exp(-t2./(R*C));
VC=V0.*(1-exp(-t2./(R*C)));
plot(t,V0,'.');
hold on;
plot(t,VR,'-');
plot(t,VC,':');
hold off


syms a s t w x
laplace(t^5)           returns   120/s^6
laplace(exp(a*s))      returns   1/(t-a)
laplace(sin(w*x),t)    returns   w/(t^2+w^2)
laplace(cos(x*w),w,t)  returns   t/(t^2+x^2)
laplace(x^sym(3/2),t)  returns   3/4*pi^(1/2)/t^(5/2)
laplace(diff(sym('F(t)')))   returns   laplace(F(t),t,s)*s-F(0)





%方波
t=0:0.001:2;
f=2;
w=2*pi*f;
y=square(w.*t);
plot(t,y);
axis([0 2 -2 2]);


MATLAB R2011b 安裝：

安裝standalone版：
1. 掛載MATLAB R2011b映像檔
2. 選 "install without using the internet"
   輸入"enter the "file installation key"為：
   59327-00840-06743-08309-05690
3. 安裝後，選用license file：F:\crack\lic_standalone.dat

安裝network版：
1. 掛載MATLAB R2011b映像檔
2. 選 "install without using the internet"
   輸入"enter the "file installation key"為：
   31996-44762-21423-39948-52406
3. 若需要，要安裝："license manager"
4. 安裝後，選用license file：F:\crack\lic_server.dat

需自行拉捷徑。


%三相電壓1
clc;close all;clear all;
t=linspace(0,10,1000);
y1=sin(t);
y2=sin(t+2*pi/3);
y3=sin(t+4*pi/3);
y4=y1+y2+y3;

subplot(4,1,1), plot(t,y1);
subplot(4,1,2), plot(t,y2);
subplot(4,1,3), plot(t,y3);
subplot(4,1,4), plot(t,y4);
axis([0 10 -1 1])


%三相電壓2
clc;close all;clear all;

freq=60; HIGH=5; LOW=0;time=0.03;

t=linspace(0,time,10000);

y1=110*sin( 2*pi*freq*t );
y2=110*sin( 2*pi*freq*t + 2*pi/3);
y3=110*sin( 2*pi*freq*t + 4*pi/3);

subplot(9,1,1), plot(t,y1,'LineWidth',3);axis([0 time -120 120]);
subplot(9,1,2), plot(t,y2,'LineWidth',3);axis([0 time -120 120]);
subplot(9,1,3), plot(t,y3,'LineWidth',3);axis([0 time -120 120]);

Q1=square(2*pi*freq*t - 0*pi/3)+1;
Q4=square(2*pi*freq*t - 3*pi/3)+1;
Q3=square(2*pi*freq*t - 2*pi/3)+1;
Q6=square(2*pi*freq*t - 5*pi/3)+1;
Q5=square(2*pi*freq*t - 4*pi/3)+1;
Q2=square(2*pi*freq*t - 1*pi/3)+1;


subplot(9,1,4), plot(t,Q1,'LineWidth',3);axis([0 time -1 3]);ylabel('Q1');
subplot(9,1,5), plot(t,Q4,'LineWidth',3);axis([0 time -1 3]);ylabel('Q4');
subplot(9,1,6), plot(t,Q3,'LineWidth',3);axis([0 time -1 3]);ylabel('Q3');
subplot(9,1,7), plot(t,Q6,'LineWidth',3);axis([0 time -1 3]);ylabel('Q6');
subplot(9,1,8), plot(t,Q5,'LineWidth',3);axis([0 time -1 3]);ylabel('Q5');
subplot(9,1,9), plot(t,Q2,'LineWidth',3);axis([0 time -1 3]);ylabel('Q2');












傅立葉級數

s = 4/π (sinπx + 1/3 sin 3πx + 1/5 sin 5πx + ………)

x=0:0.01:5;y=4/pi*(sin(pi*x)+sin(3*pi*x)/3+sin(5*pi*x)/5+sin(7*pi*x)/7+sin(9*pi*x)/9);plot(x,y)

x=0:0.01:5;
y=4/pi*(sin(pi*x));hold on;plot(x,y);
y=4/pi*(sin(pi*x)+sin(3*pi*x)/3);hold on;plot(x,y);
y=4/pi*(sin(pi*x)+sin(3*pi*x)/3+sin(5*pi*x)/5);hold on;plot(x,y);
y=4/pi*(sin(pi*x)+sin(3*pi*x)/3+sin(5*pi*x)/5+sin(7*pi*x)/7);hold on;plot(x,y);
y=4/pi*(sin(pi*x)+sin(3*pi*x)/3+sin(5*pi*x)/5+sin(7*pi*x)/7+sin(9*pi*x)/9)+(sin(11*pi*x)/11+sin(13*pi*x)/13+sin(15*pi*x)/15+sin(17*pi*x)/17+sin(19*pi*x)/19)+(sin(21*pi*x)/13+sin(23*pi*x)/23+sin(25*pi*x)/25+sin(27*pi*x)/27+sin(29*pi*x)/29);plot(x,y)


x=0:0.01:5;
y=4/pi*(sin(pi*x));hold on;plot(x,y);
y=4/pi*(sin(pi*x)+sin(3*pi*x)/3);hold on;plot(x,y);
y=4/pi*(sin(pi*x)+sin(3*pi*x)/3+sin(5*pi*x)/5);hold on;plot(x,y);
y=4/pi*(sin(pi*x)+sin(3*pi*x)/3+sin(5*pi*x)/5+sin(7*pi*x)/7);hold on;plot(x,y);
y=4/pi*(sin(pi*x)+sin(3*pi*x)/3+sin(5*pi*x)/5+sin(7*pi*x)/7+sin(9*pi*x)/9)+(sin(11*pi*x)/11+sin(13*pi*x)/13+sin(15*pi*x)/15+sin(17*pi*x)/17+sin(19*pi*x)/19)+(sin(21*pi*x)/13+sin(23*pi*x)/23+sin(25*pi*x)/25+sin(27*pi*x)/27+sin(29*pi*x)/29);plot(x,y)






MATLAB的.m檔，不能用中文檔名。

MATLAB如何表示16進位值?類似0xAA


關於開源數值分析軟體，詳見「GNU Octave」。

Octave 是一個旨在提供與MATLAB語法相容的開放源碼科學計算及數值分析的工具；它同時也是GNU計畫成員之一。

Octave 教學與技術手冊
https://sites.google.com/site/octavetech/

scilab



F8752_MATLAB7_程式設計

基礎語法
第一章 認識MATLAB
第二章 MATLAB基本運算
第三章 向量與矩陣的運算
第四章 二維平面繪圖
第五章 三維空間繪圖
第六章 特殊圖形的繪製

程式設計
第七章 使用M檔案與函數
第八章 程式控制流程
第九章 字串的處理
第十章 其它的資料型態

數學運算
第十一章 基礎數值分析
第十二章 曲線擬合與插值法
第十三章 微積分與常微分方程式
第十四章 MATLAB的符號運算
第十五章 進階符號運算

進階應用
第十六章 檔案的處理
第十七章 GUI程式設計
第十八章 進階GUI程式設計
第十九章 使用Simulink
第二十章 數位影像處理
第二十一章 使用MATLAB呼叫C函數






MATLAB選long g 與compact

MATLAB7.0用起來有點問題，仍用MATLAB6.5	//可用MATLAB 2011b

MATLAB
tic	//開啟一個碼表
toc	//讀取碼表時間
tic;Operation;toc	//這樣可以量測operation做多久

    See also TOC, CLOCK, ETIME, CPUTIME.
    See also TIC, ETIME, CLOCK, CPUTIME.


disp與display沒什麼太大差別

#電梯評估
plot(len,'g*-')
hold on
plot(len_A_B,'gs:')
plot(len_A,'r^-.')
plot(len_B,'rx--')
plot(diff,'m-.')

xlabel('上樓比例 (下樓比例=100-上樓比例)')
ylabel('電梯所走過的樓層總數（1萬人次累計）')
title('使用一台或兩台電梯所走的樓層數比較')
legend('使用一台電梯','使用兩台電梯','電梯1','電梯2','兩種方法差')
axis([0 100 0 140000])

hold off
grid on

% PWM的範例 1
% PWM Signal Generation
clc;close all;clear all;
t=0:0.001:1;
s=sawtooth(2*pi*10*t+pi);
m=0.75*sin(2*pi*1*t);
n=length(s);
for i=1:n
    if (m(i)>=s(i))
        pwm(i)=1;
    elseif (m(i)<=s(i))
        pwm(i)=0;
    end
end
% plot(t,pwm,'-g',t,m,'--r',t,s,'--b');

subplot(3,1,1), plot(t,s);
subplot(3,1,2), plot(t,m);
subplot(3,1,3), plot(t,pwm);

axis([0 1 -1.5 1.5]);



% PWM的範例 2
clc;
clear all;
close all;
F2=1;	%input(‘Message frequency=’);
F1=10;	%input(‘Carrier Sawtooth frequency=’);
A=5;
t=0:0.001:1;
c=A.*sawtooth(2*pi*F1*t);%Carrier sawtooth
subplot(3,1,1);plot(t,c);xlabel('time');ylabel('Amplitude');title('Carrier sawtooth wave');
grid on;
m=0.75*A.*sin(2*pi*F2*t);%Message amplitude must be less than Sawtooth
subplot(3,1,2);
plot(t,m);
xlabel('Time');
ylabel('Amplitude');
title('Message Signal');
grid on;
n=length(c);%Length of carrier sawtooth is stored to ‘n’
for i=1:n%Comparing Message and Sawtooth amplitudes
if (m(i)>=c(i))
    pwm(i)=1;
else
    pwm(i)=0;
end
end
subplot(3,1,3);
plot(t,pwm);
xlabel('Time');
ylabel('Amplitude');
title('plot of PWM');
axis([0 1 0 2]);%X-Axis varies from 0 to 1 & Y-Axis from 0 to 2
grid on;


% PWM的範例 3
clc;
clear all;
close all;
F2=1; %input(‘Message frequency=’);
F1=10; %input(‘Carrier Sawtooth frequency=’);
A=5;
t=0:0.001:1;
c=A.*sawtooth(2*pi*F1*t);%Carrier sawtooth
subplot(3,1,1);
plot(t,c);
xlabel('time');
ylabel('Amplitude');
title('Carrier sawtooth wave');
grid on;
m=0.75*A.*sin(2*pi*F2*t);%Message amplitude must be less than Sawtooth
subplot(3,1,2);
plot(t,m);
xlabel('Time');
ylabel('Amplitude');
title('Message Signal');
grid on;
n=length(c);%Length of carrier sawtooth is stored to ‘n’
for i=1:n%Comparing Message and Sawtooth amplitudes
if (m(i)>=c(i))
    pwm(i)=1;
else
    pwm(i)=0;
end
end
subplot(3,1,3);
plot(t,pwm);
xlabel('Time');
ylabel('Amplitude');
title('plot of PWM');
axis([0 1 0 2]);%X-Axis varies from 0 to 1 & Y-Axis from 0 to 2
grid on;


% PWM的範例 4
sampling_freq = 1000;

carrying_freq = 50;

t = 0:1/sampling_freq:10;

temp = sawtooth((carrying_freq/2)*2*pi*t);

carrying_signal = (temp)/2+range(temp)/4;

desired_pos_signal = sind(t*360);

desired_vel_signal = zeros(size(desired_pos_signal));

desired_vel_signal(2:end) = sign(diff(desired_pos_signal));

PWM = zeros(size(desired_pos_signal));

for k = 1:length(desired_pos_signal)

if carrying_signal(k)>abs(desired_pos_signal(k)) && desired_vel_signal(k) >0

PWM(k) = 1;

elseif carrying_signal(k)>abs(desired_pos_signal(k)) && desired_vel_signal(k) <0

PWM(k) = -1;

end

end

subplot(3,1,1);

h=plot(t,carrying_signal,'b')

title('carrying signal')

subplot(3,1,2)

plot(t,desired_pos_signal)

hold on

plot(t,PWM,'r')






clc;clear all;close all;
Time=10;
theta=0:0.01:Time;
n=length(theta);

for i=1:n
if (theta(i)>=(pi/3*2)) && (theta(i)<=(pi/3*3))
    y(i)=cos(theta(i))*(3)/2;
else
    y(i)=0;
end
end

plot(theta,y);





clear,clc,clf

X1=[513 814  1154 1360 1440];
Y1=[7.0 17.3 44.5 66.5 77.4];
X2=[493 565 710 806  876  988 1076 1200 1294 1375 1422 1486 1583 1650];
Y2=[7.6 9.4 14  18.5 21.8 29  35.8 46.3 57.6 67.3 75.8 85   105  123];

xx1=513:1:1440;
yy1=spline(X1,Y1,xx1);
plot(X1,Y1,'ro','LineWidth',2);hold on;
plot(xx1,yy1,'r-','LineWidth',1);hold on;

xx2=493:1:1650;
yy2=spline(X2,Y2,xx2);
plot(X2,Y2,'bo','LineWidth',2);hold on;
plot(xx2,yy2,'b-','LineWidth',1);hold on;

xlabel('speed(rpm)')
ylabel('power(W)')

legend('科派','', '世紀民生', '')




clear,clc,clf
VR_SPEED_M_MAX=80;
VR_SPEED_M_MIN=10;
VR_MAX=4500;
VR_MIN=500;
voltage=1:1:5000;

for i=1:1:5000
    if (voltage(i)>=VR_MAX)
    	vr_duty(i) = VR_SPEED_M_MAX;
    elseif (voltage(i)<=VR_MIN)
    	vr_duty(i) = 0;
    else
    	vr_duty(i) = ((voltage(i)-VR_MIN)/((VR_MAX-VR_MIN)/(VR_SPEED_M_MAX-VR_SPEED_M_MIN)))+VR_SPEED_M_MIN;
    end
end
plot(voltage,vr_duty,'r')
xlabel('VR (mV)');
ylabel('svpwm-m');
axis([0 5000 0 100])

clear,clc,clf
speed = 1:1:26;
targ_speed(speed) = 300+50*(speed-1);
targ_speed(25) = 1450;
targ_speed(26) = 1450;
plot(speed,targ_speed,'ro-')
xlabel('speed');
ylabel('rpm');
%X=[0,1,1];Y=[0,0,300];line(X,Y)
X=[0,1,1];Y=[0,0,300];line(X,Y,'linewidth',1,'color','r')
X=[0];Y=[0];line(X,Y,'linewidth',1,'color','r','marker','o')
axis([-1 27 -10 1600])
grid on








Samsung讀音樂CD
TSS_ACD_32k=[90.99 92.75 94.35 98.53 102.33 106.05 109.51 112.62 113.86 116.52 119.29 121.87 124.46 127.66 130.29 131.27]
SPEED_TSS_ACD_32k=21693*2352/1024/150./TSS_ACD_32k
axis equal
hold on
plot(SPEED_TSS_ACD_32k,'rs:')
xlabel('track')
ylabel('speed(x)')
title('Samsung讀音樂CD')
hold off
grid on
axis([0 18 0 5])
legend('Samsung-ACD-32k')
title('Samsung讀音樂CD')



BTC與Samsung讀各式碟片速度比較
ACD_豐後水道
VCD_裏町酒場
DATA_CD_
DATA_DVD_

BTC_VCD_02k=[44.93 41.30 37.79 36.12 36.42 35.65 35.95 36.07 35.90 36.03 35.79 36.29 36.20 36.29 36.55 36.07 37.16 36.51]
BTC_ACD_02k=[51.05 45.62 41.92 39.94 40.05 39.72 39.73 39.84 40.22 40.41 40.25 40.14 40.08 40.08 40.07 39.92]
BTC_VCD_32k=[45.39 41.38 38.34 35.83 33.81 32.02 30.65 29.33 28.12 27.27 26.27 24.96 24.12 23.55 22.68 22.52 21.44 21.15]
BTC_ACD_32k=[51.11 45.61 41.84 38.73 36.46 33.84 32.49 31.18 29.88 28.72 27.03 26.71 25.85 25.22 24.43 23.11]
BTC_DATA_CD_02k=[43.55 40.39 37.34 35.01 32.84 30.57 29.84 28.14 27.52 26.80 26.59 26.95 26.84 27.24 26.79 26.61 27.06 26.86 27.02]
BTC_DATA_CD_64k=[43.17 40.59 37.53 35.04 32.78 30.62 29.74 28.49 27.31 26.35 24.72 24.43 23.87 23.13 22.56 21.38 21.46 20.72 20.43]
BTC_DATA_DVD_64k=[14.86 15.10 14.69 15.29 14.52 14.94 15.17 15.21 14.79 15.19 14.13 14.76 14.74 15.28 14.20 15.20 14.45 15.85 15.40 15.15 14.29]
TSS_VCD_02k=[45.85 44.74 44.64 44.67 44.53 44.29 44.48 44.66 44.34 44.50 44.35 44.34 44.74 44.61 44.58 44.24 44.24 48.42]
TSS_VCD_32k=[31.98 32.30 32.73 31.97 31.93 31.91 31.96 31.92 31.91 31.90 31.93 31.92 32.04 31.97 31.95 32.24 32.16 33.15]
TSS_DATA_CD_64k=[30.67 31.43 31.43 31.40 31.43 30.86 31.39 31.46 31.36 31.43 30.94 31.40 31.32 31.49 31.16 30.92 31.43 31.38 31.64]
TSS_DATA_DVD_64k=[19.12 17.03 15.55 18.45 19.26 15.01 14.47 15.13 14.42 15.09 14.96 15.04 14.50 14.95 14.38 15.15 14.47 15.25 14.54 15.09 14.70]


SPEED_BTC_VCD_32k=19307*2352/1024/150./BTC_VCD_32k
SPEED_BTC_ACD_32k=21693*2352/1024/150./BTC_ACD_32k
SPEED_BTC_DATA_CD_02k=18924*2048/1024/150./BTC_DATA_CD_02k
SPEED_BTC_DATA_CD_64k=18924*2048/1024/150./BTC_DATA_CD_64k
SPEED_BTC_DATA_DVD_64k=21968*2048/1024/150./BTC_DATA_DVD_64k
SPEED_BTC_VCD_02k=19307*2352/1024/150./BTC_VCD_02k
SPEED_BTC_ACD_02k=21693*2352/1024/150./BTC_ACD_02k
SPEED_TSS_VCD_02k=19307*2352/1024/150./TSS_VCD_02k
SPEED_TSS_VCD_32k=19307*2352/1024/150./TSS_VCD_32k
SPEED_TSS_DATA_CD_64k=18924*2048/1024/150./TSS_DATA_CD_64k
SPEED_TSS_DATA_DVD_64k=21968*2048/1024/150./TSS_DATA_DVD_64k

axis equal
hold on
plot(SPEED_BTC_VCD_02k,'g*-')
plot(SPEED_BTC_VCD_32k,'gs:')
plot(SPEED_BTC_ACD_02k,'r^-.')
plot(SPEED_BTC_ACD_32k,'rx--')
plot(SPEED_BTC_DATA_CD_02k,'m-.')
plot(SPEED_BTC_DATA_CD_64k,'m-')
plot(SPEED_BTC_DATA_DVD_64k,'bh:')
plot(SPEED_TSS_VCD_02k,'bo-')
plot(SPEED_TSS_VCD_32k,'bh:')
plot(SPEED_TSS_DATA_CD_64k,'m-')
plot(SPEED_TSS_DATA_DVD_64k,'bh:')
xlabel('track')
ylabel('speed')
title('BTC與Samsung讀各式碟片速度比較')
hold off
grid on
axis([0 20 3 22])
legend('BTC-VCD-2k','BTC-VCD-32k','BTC-ACD-2k','BTC-ACD-32k','BTC-DATA-CD-2k','BTC-DATA-CD-64k','BTC-DATA-DVD-64k','Samsung-VCD-2k','Samsung-VCD-32k','Samsung-DATA-CD-64k','Samsung-DATA-DVD-64k')



----------------MATLAB 語法範例 matmat----------------

%範例：for、if、elseif、else
clear
sum = 0;
for i=1:1:100
    if (i >= 70)
    	sum = sum+i;
    elseif (i <= 30)
    	sum = sum+i;
    else
    	sum = sum+i;
    end
end

fprintf('sum = %d\n',sum);


%範例：input、if、else
reply = input('確認是否離開 Y/N [Y]:','s');
if isempty(reply)
  reply = 'Y';
end

if (reply == 'Y')
	disp('離開');
else
	disp('取消');
end

%範例：選單
k=menu('choose a color','Red','Green','Blue');

reply = menu('確認是否離開？','離開','取消');

if (reply == 1)
	disp('離開');
else
	disp('取消');
end

%範例：while
sum=0;
i=0;
while(i<=100)
sum=sum+i;
i=i+1;
end

fprintf('sum = %d\n',sum);

%範例：fprintf

>> aaa=123;fprintf('number aaa=%d\n',aaa);
number aaa=123

>> name = computer;fprintf('computer name is %s\n',name);
computer name is PCWIN


%範例：信號加雜訊
clear,clc,clf

t=0:0.002:1;
y=sin(2*pi*5*t)+1/3*sin(2*pi*15*t-pi);
plot(t,y,'r-');hold on;

%rand('normal');

yn=y+rand(1,length(t))-0.5;
plot(t,yn,'g');


%範例：顏色範例，共8色
text(0.1,0.5,'紅','FontSize',35,'Color','r');
text(0.2,0.5,'綠','FontSize',35,'Color','g');
text(0.3,0.5,'藍','FontSize',35,'Color','b');
text(0.4,0.5,'黑','FontSize',35,'Color','k');
text(0.5,0.5,'白','FontSize',35,'Color','w');
text(0.6,0.5,'靛','FontSize',35,'Color','c');
text(0.7,0.5,'洋','FontSize',35,'Color','m');
text(0.8,0.5,'黃','FontSize',35,'Color','y');









matmat

同時畫幾條線
x=linspace(0, 2*pi,100);plot(x,sin(x),'ro-',x,cos(x),'gx:',x,sin(x)+cos(x),'b*-.')
-實線 、 --虛線 、 :點線 、 -.點虛線

axis用法，inf代表預設值
axis([0 7 -inf inf])

gca: get current axis

標明刻度，x軸標5個點，數字需要單調遞增
set(gca, 'xtick', [0 pi/2 pi pi*3/2 2*pi])

標明刻度，y軸標5個點，數字需要單調遞增
set(gca, 'ytick', [-0.6 -0.2 0 0.3 0.9])

將格點數字改為文字
set(gca, 'yticklabel', {'極小','臨界值','中點','危險值','極大值'})

加上grid on會依標畫上格線

改變圖軸的長寬比(Aspect Ratio)

clear,clc,clf
t=0:0.1:2*pi;x=3*cos(t);y=sin(t);
subplot(221);plot(x,y);axis normal;grid on;
subplot(222);plot(x,y);axis square;grid on;
subplot(223);plot(x,y);axis equal;grid on;
subplot(224);plot(x,y);axis equal tight;grid on;

axis normal	使用預設長寬比(等於圖形長寬比)
axis square	長寬比為1
axis equal	長寬比例不便，但兩軸刻度一致
axis equal tight兩軸刻度比例一致，且圖軸貼緊圖形
axis image	兩軸刻度比例一致(適用於影像顯示)

設定圖軸背景，需要寫在plot之前

colordef white	圖軸背景為白色、視窗背景為淺灰色
colordef black	圖軸背景為黑色、視窗背景為暗灰色
colordef none	圖軸背景為黑色、視窗背景為黑色，即Matlab之預設值。

xlabel、ylabel、title、legend
寫上pi、底線、希臘字母、箭頭，要多一個反斜線，
寫exp(x)，要用大括號

xlabel('t = 0 to 2\pi')
ylabel('values of sin(t) and e^{x}')
xlabel('underscore a\_b')
xlabel('greek \alpha \beta')
xlabel('arrow \leftarrow \rightarrow')


在圖上的特定點劃上箭頭寫說明文字，用text(x,y,'string')

%預設向左對齊
t=0:0.1:2*pi;x=3*cos(t);y=sin(t);plot(x,y);text(3*cos(pi*3/4), sin(pi*3/4), '\leftarrow')
%改成向右對齊
t=0:0.1:2*pi;x=3*cos(t);y=sin(t);plot(x,y);text(3*cos(pi*3/4), sin(pi*3/4), '\rightarrow','HorizontalAlignment','right')



fplot用法：

fplot('sin(x)',[0 10])
fplot('sin(1/x)',[0 0.2])

針頭圖(Stem Plots)
t=0:0.2:4*pi;y=cos(t).*exp(-t/5);stem(t, y)		%空心針頭
t=0:0.2:4*pi;y=cos(t).*exp(-t/5);stem(t, y, 'fill')	%實心針頭

實心圖
t=0:0.4:4*pi;y=sin(t).*exp(-t/5);fill(t,y,'b')


讀取jpg圖
X = imread('bbb.jpg');image(X);size(X)
X = imread('bbb.jpg');image(X);size(X);axis image

取得圖片資訊
imfinfo('bbb.jpg')

 colorbar Display color bar (color scale)


用Windows預設程式來開啟檔案：
!start bbb.jpg





用sound(y, fs)播放音訊
改變y即改變音量大小, 3*y即代表3倍振幅的音訊
改變fs及改變播放速度, 0.6*fs即代表0.6倍速度播放
sound(flipud(y), fs);	%倒著播放此音訊

讀取音訊檔案 .wav
filename='start.wav'
[y, fs] = audioread('start.wav');	%讀取音訊檔案, fs:sample rate
sound(y, fs);				%播放此音訊
time=(1:length(y))/fs;			%時間軸的向量
plot(time,y)				%畫出時間軸上的波形



讀取音訊檔案 .wav	左右聲道分別處理
filename='start.wav'
[y, fs] = audioread('start.wav');	%讀取音訊檔案, fs:sample rate
sound(y, fs);				%播放此音訊
left=y(:,1);
right=y(:,2);
subplot(211),plot((1:length(left))/fs, left)
subplot(212),plot((1:length(right))/fs, right)


讀取音訊檔案 .mp3
filename='aaaa.mp3'
[y, fs] = audioread(filename, [800000 1000000]);	%讀取音訊檔案, fs:sample rate, 只讀取一部份
sound(y, fs);				%播放此音訊
time=(1:length(y))/fs;			%時間軸的向量
plot(time,y)				%畫出時間軸上的波形


取得音訊檔案資訊
filename='start.wav'
info=audioinfo(filename)
fprintf('檔案名稱 = %s\n',info.Filename);
fprintf('壓縮方式 = %s\n',info.CompressionMethod);
fprintf('通道個數 = %g 個\n',info.NumChannels);
fprintf('取樣頻率 = %g Hz\n',info.SampleRate);
fprintf('取樣點總個數 = %g 個\n',info.TotalSamples);
fprintf('音訊長度 = %g 秒\n',info.Duration);
fprintf('取樣點解析度 = %g 位元/取樣點\n',info.BitsPerSample);


filename='aaaa.mp3'
info=audioinfo(filename)
fprintf('檔案名稱 = %s\n',info.Filename);
fprintf('壓縮方式 = %s\n',info.CompressionMethod);
fprintf('通道個數 = %g 個\n',info.NumChannels);
fprintf('取樣頻率 = %g Hz\n',info.SampleRate);
fprintf('取樣點總個數 = %g 個\n',info.TotalSamples);
fprintf('音訊長度 = %g 秒\n',info.Duration);
%fprintf('取樣點解析度 = %g 位元/取樣點\n',info.BitsPerSample);






---------------------------------------------------------------------------
tmp

DO.WAV
RE.WAV
LA.WAV

filename1='DO.WAV';
filename2='RE.WAV';
filename3='LA.WAV';
[y1, fs1] = audioread(filename1);
[y2, fs2] = audioread(filename2);
[y3, fs3] = audioread(filename3);
%sound(y, fs);				%播放此音訊
%left=y(:,1);
%right=y(:,2);
subplot(311),plot((1:length(y1))/fs1, y1)
subplot(312),plot((1:length(y2))/fs2, y2)
subplot(313),plot((1:length(y3))/fs3, y3)


bunshue/name
bunshue@gmail.com








clear,clc,clf
line([150 150],[0 70],'linewidth',5,'color','r');hold on;

PWM_START_DUTY = 60;

for i=1:1:150
    if (i>100)
        duty(i) = PWM_START_DUTY;
    elseif (i>80)
    	duty(i) = floor(PWM_START_DUTY*5/6);
    elseif (i>60)
    	duty(i) = floor(PWM_START_DUTY*4/6);
    elseif (i>40)
    	duty(i) = floor(PWM_START_DUTY*3/6);
    elseif (i>20)
    	duty(i) = floor(PWM_START_DUTY*2/6);
    elseif (i>10)
    	duty(i) = floor(PWM_START_DUTY*1/6);
    else
    	duty(i) = floor(PWM_START_DUTY*1/13);
    end
end

plot(fliplr(duty),'b*-','LineWidth',5)


line([0 150],[60 60],'linewidth',2,'color','g');hold on;
line([50 150],[50 50],'linewidth',2,'color','g');hold on;
line([70 150],[40 40],'linewidth',2,'color','g');hold on;
line([90 150],[30 30],'linewidth',2,'color','g');hold on;
line([110 150],[20 20],'linewidth',2,'color','g');hold on;
line([130 150],[10 10],'linewidth',2,'color','g');hold on;
line([140 150],[4 4],'linewidth',2,'color','g');hold on;

set(gca, 'xtick', [0 50 70 90 110 130 140 150]);
set(gca, 'xticklabel', {'150','100','80','60','40','20','10','0'})
set(gca, 'ytick', [0 4 10 20 30 40 50 60 70]);grid on
xlabel('distance');ylabel('duty')

axis([0 160 0 70])

text(150, 65, '目標\rightarrow','FontSize',25,'Color','r','HorizontalAlignment','right')








由M值算PWMA、PWMB、PWMC

PWM_PERIOD=400;
M=0.1;
theta=0:1:60;

duty_A=0.5+0.5*M*sind(60-theta)+0.5*M*sind(theta);
duty_B=0.5-0.5*M*sind(60-theta)+0.5*M*sind(theta);
duty_C=0.5-0.5*M*sind(60-theta)-0.5*M*sind(theta);

PWMA = floor(PWM_PERIOD* (1-duty_A))
PWMB = floor(PWM_PERIOD* (1-duty_B))
PWMC = floor(PWM_PERIOD* (1-duty_C))

		dutyA=(100+M*sinetable100[angle1]/100+M*sinetable100[angle2]/100)/2;
		dutyB=(100-M*sinetable100[angle1]/100+M*sinetable100[angle2]/100)/2;
		dutyC=(100-M*sinetable100[angle1]/100-M*sinetable100[angle2]/100)/2;

dutyA=(100+M*sind[angle1]/100+M*sind[angle2]/100)/2;
dutyB=(100-M*sind[angle1]/100+M*sind[angle2]/100)/2;
dutyC=(100-M*sind[angle1]/100-M*sind[angle2]/100)/2;


dutyA=(1+M*sind[angle1]+M*sind[angle2])/2;
dutyB=(1-M*sind[angle1]+M*sind[angle2])/2;
dutyC=(1-M*sind[angle1]-M*sind[angle2])/2;



PWM_freq = 25000	%PWM freq = 25kHz
PWM_duty = 30
XTAL=16000000

PWM_period = 1/PWM_freq
one_pixel=1/XTAL
%PWMPRD=PWM_period/one_pixel/2
PWMPRD=(1/PWM_freq)/(1/XTAL)/2
PWMA=PWMPRD*(100-PWM_duty)/100

M=0.5;
alpha=30;

1. 由alpha、M算出Tz、T0、T1、T2

Tz = PWM_period;

T1=Tz*M*sind(60-alpha)/sind(60);
T2=Tz*M*sind(alpha)/sind(60);

T0=Tz-(T1+T2);

2. 由Tz、T0、T1、T2算出dutyA、dutyB、dutyC
dutyA=(1+M*sind[angle1]+M*sind[angle2])/2;
dutyB=(1-M*sind[angle1]+M*sind[angle2])/2;
dutyC=(1-M*sind[angle1]-M*sind[angle2])/2;

3. 由dutyA、PWM_freq、XTAL算出PWMPRD、PWMA，同理，算出PWMB、PWMC

PWM_period = 1/PWM_freq
one_pixel=1/XTAL
%PWMPRD=PWM_period/one_pixel/2
PWMPRD=(1/PWM_freq)/(1/XTAL)/2

PWMA=PWMPRD*(1-PWM_duty)
%PWMA=PWMPRD*(100-PWM_duty)/100

PWMA=PWMPRD*(1-dutyA)=PWMPRD*(1-(1+M*sind[angle1]+M*sind[angle2])/2)
=PWMPRD*((1-M*sind[angle1]-M*sind[angle2])/2)
=PWMPRD*((1-M*(sind[angle1]+sind[angle2])/2)

PWMB=PWMPRD*(1-dutyB)=PWMPRD*(1-(1-M*sind[angle1]+M*sind[angle2])/2)
=PWMPRD*((1+M*sind[angle1]-M*sind[angle2])/2)
=PWMPRD*((1+M*(sind[angle1]-sind[angle2])/2)

PWMC=PWMPRD*(1-dutyC)=PWMPRD*(1-(1-M*sind[angle1]-M*sind[angle2])/2)
=PWMPRD*((1+M*sind[angle1]+M*sind[angle2])/2)
=PWMPRD*((1+M*(sind[angle1]+sind[angle2])/2)




FREQ=1/((1/16M)*PERIOD*2)
=>PERIOD = 8M/FREQ

FREQ=14000:1000:30000
PERIOD=8000000./FREQ;
floor(PERIOD)

clear,clc,clf

dutyA(1)=71;dutyB(1)=28;dutyC(1)=28;
dutyA(2)=72;dutyB(2)=29;dutyC(2)=28;
dutyA(3)=71;dutyB(3)=29;dutyC(3)=28;
dutyA(4)=72;dutyB(4)=30;dutyC(4)=28;
dutyA(5)=72;dutyB(5)=31;dutyC(5)=28;
dutyA(6)=72;dutyB(6)=31;dutyC(6)=27;
dutyA(7)=72;dutyB(7)=32;dutyC(7)=27;
dutyA(8)=73;dutyB(8)=33;dutyC(8)=27;
dutyA(9)=73;dutyB(9)=34;dutyC(9)=27;
dutyA(10)=73;dutyB(10)=34;dutyC(10)=26;
dutyA(11)=73;dutyB(11)=35;dutyC(11)=27;
dutyA(12)=73;dutyB(12)=36;dutyC(12)=27;
dutyA(13)=73;dutyB(13)=36;dutyC(13)=26;
dutyA(14)=73;dutyB(14)=37;dutyC(14)=26;
dutyA(15)=74;dutyB(15)=38;dutyC(15)=26;
dutyA(16)=74;dutyB(16)=39;dutyC(16)=26;
dutyA(17)=74;dutyB(17)=40;dutyC(17)=26;
dutyA(18)=74;dutyB(18)=40;dutyC(18)=26;
dutyA(19)=74;dutyB(19)=41;dutyC(19)=26;
dutyA(20)=74;dutyB(20)=41;dutyC(20)=25;
dutyA(21)=74;dutyB(21)=42;dutyC(21)=25;
dutyA(22)=74;dutyB(22)=43;dutyC(22)=25;
dutyA(23)=74;dutyB(23)=43;dutyC(23)=25;
dutyA(24)=74;dutyB(24)=44;dutyC(24)=25;
dutyA(25)=74;dutyB(25)=45;dutyC(25)=25;
dutyA(26)=74;dutyB(26)=46;dutyC(26)=25;
dutyA(27)=75;dutyB(27)=47;dutyC(27)=25;
dutyA(28)=74;dutyB(28)=47;dutyC(28)=25;
dutyA(29)=74;dutyB(29)=48;dutyC(29)=25;
dutyA(30)=75;dutyB(30)=49;dutyC(30)=25;
dutyA(31)=75;dutyB(31)=50;dutyC(31)=25;
dutyA(32)=75;dutyB(32)=51;dutyC(32)=25;
dutyA(33)=74;dutyB(33)=51;dutyC(33)=25;
dutyA(34)=74;dutyB(34)=52;dutyC(34)=25;
dutyA(35)=75;dutyB(35)=53;dutyC(35)=25;
dutyA(36)=74;dutyB(36)=53;dutyC(36)=25;
dutyA(37)=74;dutyB(37)=54;dutyC(37)=25;
dutyA(38)=74;dutyB(38)=55;dutyC(38)=25;
dutyA(39)=74;dutyB(39)=56;dutyC(39)=25;
dutyA(40)=74;dutyB(40)=56;dutyC(40)=25;
dutyA(41)=74;dutyB(41)=57;dutyC(41)=25;
dutyA(42)=74;dutyB(42)=58;dutyC(42)=25;
dutyA(43)=74;dutyB(43)=59;dutyC(43)=26;
dutyA(44)=74;dutyB(44)=60;dutyC(44)=26;
dutyA(45)=74;dutyB(45)=60;dutyC(45)=26;
dutyA(46)=74;dutyB(46)=61;dutyC(46)=26;
dutyA(47)=74;dutyB(47)=62;dutyC(47)=26;
dutyA(48)=73;dutyB(48)=62;dutyC(48)=26;
dutyA(49)=73;dutyB(49)=63;dutyC(49)=26;
dutyA(50)=73;dutyB(50)=64;dutyC(50)=27;
dutyA(51)=73;dutyB(51)=65;dutyC(51)=27;
dutyA(52)=73;dutyB(52)=65;dutyC(52)=26;
dutyA(53)=73;dutyB(53)=66;dutyC(53)=27;
dutyA(54)=73;dutyB(54)=67;dutyC(54)=27;
dutyA(55)=72;dutyB(55)=67;dutyC(55)=27;
dutyA(56)=72;dutyB(56)=68;dutyC(56)=27;
dutyA(57)=72;dutyB(57)=69;dutyC(57)=28;
dutyA(58)=72;dutyB(58)=70;dutyC(58)=28;
dutyA(59)=71;dutyB(59)=70;dutyC(59)=28;
dutyA(60)=72;dutyB(60)=71;dutyC(60)=28;
dutyA(61)=71;dutyB(61)=71;dutyC(61)=28;
dutyA(62)=71;dutyB(62)=72;dutyC(62)=28;
dutyA(63)=70;dutyB(63)=71;dutyC(63)=28;
dutyA(64)=70;dutyB(64)=72;dutyC(64)=28;
dutyA(65)=69;dutyB(65)=72;dutyC(65)=28;
dutyA(66)=68;dutyB(66)=72;dutyC(66)=27;
dutyA(67)=67;dutyB(67)=72;dutyC(67)=27;
dutyA(68)=67;dutyB(68)=73;dutyC(68)=27;
dutyA(69)=66;dutyB(69)=73;dutyC(69)=27;
dutyA(70)=65;dutyB(70)=73;dutyC(70)=26;
dutyA(71)=65;dutyB(71)=73;dutyC(71)=27;
dutyA(72)=64;dutyB(72)=73;dutyC(72)=27;
dutyA(73)=63;dutyB(73)=73;dutyC(73)=26;
dutyA(74)=62;dutyB(74)=73;dutyC(74)=26;
dutyA(75)=62;dutyB(75)=74;dutyC(75)=26;
dutyA(76)=61;dutyB(76)=74;dutyC(76)=26;
dutyA(77)=60;dutyB(77)=74;dutyC(77)=26;
dutyA(78)=60;dutyB(78)=74;dutyC(78)=26;
dutyA(79)=59;dutyB(79)=74;dutyC(79)=26;
dutyA(80)=58;dutyB(80)=74;dutyC(80)=25;
dutyA(81)=57;dutyB(81)=74;dutyC(81)=25;
dutyA(82)=56;dutyB(82)=74;dutyC(82)=25;
dutyA(83)=56;dutyB(83)=74;dutyC(83)=25;
dutyA(84)=55;dutyB(84)=74;dutyC(84)=25;
dutyA(85)=54;dutyB(85)=74;dutyC(85)=25;
dutyA(86)=53;dutyB(86)=74;dutyC(86)=25;
dutyA(87)=53;dutyB(87)=75;dutyC(87)=25;
dutyA(88)=52;dutyB(88)=74;dutyC(88)=25;
dutyA(89)=51;dutyB(89)=74;dutyC(89)=25;
dutyA(90)=51;dutyB(90)=75;dutyC(90)=25;
dutyA(91)=50;dutyB(91)=75;dutyC(91)=25;
dutyA(92)=49;dutyB(92)=75;dutyC(92)=25;
dutyA(93)=48;dutyB(93)=74;dutyC(93)=25;
dutyA(94)=47;dutyB(94)=74;dutyC(94)=25;
dutyA(95)=47;dutyB(95)=75;dutyC(95)=25;
dutyA(96)=46;dutyB(96)=74;dutyC(96)=25;
dutyA(97)=45;dutyB(97)=74;dutyC(97)=25;
dutyA(98)=44;dutyB(98)=74;dutyC(98)=25;
dutyA(99)=43;dutyB(99)=74;dutyC(99)=25;
dutyA(100)=43;dutyB(100)=74;dutyC(100)=25;
dutyA(101)=42;dutyB(101)=74;dutyC(101)=25;
dutyA(102)=41;dutyB(102)=74;dutyC(102)=25;
dutyA(103)=41;dutyB(103)=74;dutyC(103)=26;
dutyA(104)=40;dutyB(104)=74;dutyC(104)=26;
dutyA(105)=40;dutyB(105)=74;dutyC(105)=26;
dutyA(106)=39;dutyB(106)=74;dutyC(106)=26;
dutyA(107)=38;dutyB(107)=74;dutyC(107)=26;
dutyA(108)=37;dutyB(108)=73;dutyC(108)=26;
dutyA(109)=36;dutyB(109)=73;dutyC(109)=26;
dutyA(110)=36;dutyB(110)=73;dutyC(110)=27;
dutyA(111)=35;dutyB(111)=73;dutyC(111)=27;
dutyA(112)=34;dutyB(112)=73;dutyC(112)=26;
dutyA(113)=34;dutyB(113)=73;dutyC(113)=27;
dutyA(114)=33;dutyB(114)=73;dutyC(114)=27;
dutyA(115)=32;dutyB(115)=72;dutyC(115)=27;
dutyA(116)=31;dutyB(116)=72;dutyC(116)=27;
dutyA(117)=31;dutyB(117)=72;dutyC(117)=28;
dutyA(118)=30;dutyB(118)=72;dutyC(118)=28;
dutyA(119)=29;dutyB(119)=71;dutyC(119)=28;
dutyA(120)=29;dutyB(120)=72;dutyC(120)=28;
dutyA(121)=28;dutyB(121)=71;dutyC(121)=28;
dutyA(122)=28;dutyB(122)=72;dutyC(122)=29;
dutyA(123)=28;dutyB(123)=71;dutyC(123)=29;
dutyA(124)=28;dutyB(124)=72;dutyC(124)=30;
dutyA(125)=28;dutyB(125)=72;dutyC(125)=31;
dutyA(126)=27;dutyB(126)=72;dutyC(126)=31;
dutyA(127)=27;dutyB(127)=72;dutyC(127)=32;
dutyA(128)=27;dutyB(128)=73;dutyC(128)=33;
dutyA(129)=27;dutyB(129)=73;dutyC(129)=34;
dutyA(130)=26;dutyB(130)=73;dutyC(130)=34;
dutyA(131)=27;dutyB(131)=73;dutyC(131)=35;
dutyA(132)=27;dutyB(132)=73;dutyC(132)=36;
dutyA(133)=26;dutyB(133)=73;dutyC(133)=36;
dutyA(134)=26;dutyB(134)=73;dutyC(134)=37;
dutyA(135)=26;dutyB(135)=74;dutyC(135)=38;
dutyA(136)=26;dutyB(136)=74;dutyC(136)=39;
dutyA(137)=26;dutyB(137)=74;dutyC(137)=40;
dutyA(138)=26;dutyB(138)=74;dutyC(138)=40;
dutyA(139)=26;dutyB(139)=74;dutyC(139)=41;
dutyA(140)=25;dutyB(140)=74;dutyC(140)=41;
dutyA(141)=25;dutyB(141)=74;dutyC(141)=42;
dutyA(142)=25;dutyB(142)=74;dutyC(142)=43;
dutyA(143)=25;dutyB(143)=74;dutyC(143)=43;
dutyA(144)=25;dutyB(144)=74;dutyC(144)=44;
dutyA(145)=25;dutyB(145)=74;dutyC(145)=45;
dutyA(146)=25;dutyB(146)=74;dutyC(146)=46;
dutyA(147)=25;dutyB(147)=75;dutyC(147)=47;
dutyA(148)=25;dutyB(148)=74;dutyC(148)=47;
dutyA(149)=25;dutyB(149)=74;dutyC(149)=48;
dutyA(150)=25;dutyB(150)=75;dutyC(150)=49;
dutyA(151)=25;dutyB(151)=75;dutyC(151)=50;
dutyA(152)=25;dutyB(152)=75;dutyC(152)=51;
dutyA(153)=25;dutyB(153)=74;dutyC(153)=51;
dutyA(154)=25;dutyB(154)=74;dutyC(154)=52;
dutyA(155)=25;dutyB(155)=75;dutyC(155)=53;
dutyA(156)=25;dutyB(156)=74;dutyC(156)=53;
dutyA(157)=25;dutyB(157)=74;dutyC(157)=54;
dutyA(158)=25;dutyB(158)=74;dutyC(158)=55;
dutyA(159)=25;dutyB(159)=74;dutyC(159)=56;
dutyA(160)=25;dutyB(160)=74;dutyC(160)=56;
dutyA(161)=25;dutyB(161)=74;dutyC(161)=57;
dutyA(162)=25;dutyB(162)=74;dutyC(162)=58;
dutyA(163)=26;dutyB(163)=74;dutyC(163)=59;
dutyA(164)=26;dutyB(164)=74;dutyC(164)=60;
dutyA(165)=26;dutyB(165)=74;dutyC(165)=60;
dutyA(166)=26;dutyB(166)=74;dutyC(166)=61;
dutyA(167)=26;dutyB(167)=74;dutyC(167)=62;
dutyA(168)=26;dutyB(168)=73;dutyC(168)=62;
dutyA(169)=26;dutyB(169)=73;dutyC(169)=63;
dutyA(170)=27;dutyB(170)=73;dutyC(170)=64;
dutyA(171)=27;dutyB(171)=73;dutyC(171)=65;
dutyA(172)=26;dutyB(172)=73;dutyC(172)=65;
dutyA(173)=27;dutyB(173)=73;dutyC(173)=66;
dutyA(174)=27;dutyB(174)=73;dutyC(174)=67;
dutyA(175)=27;dutyB(175)=72;dutyC(175)=67;
dutyA(176)=27;dutyB(176)=72;dutyC(176)=68;
dutyA(177)=28;dutyB(177)=72;dutyC(177)=69;
dutyA(178)=28;dutyB(178)=72;dutyC(178)=70;
dutyA(179)=28;dutyB(179)=71;dutyC(179)=70;
dutyA(180)=28;dutyB(180)=72;dutyC(180)=71;
dutyA(181)=28;dutyB(181)=71;dutyC(181)=71;
dutyA(182)=28;dutyB(182)=71;dutyC(182)=72;
dutyA(183)=28;dutyB(183)=70;dutyC(183)=71;
dutyA(184)=28;dutyB(184)=70;dutyC(184)=72;
dutyA(185)=28;dutyB(185)=69;dutyC(185)=72;
dutyA(186)=27;dutyB(186)=68;dutyC(186)=72;
dutyA(187)=27;dutyB(187)=67;dutyC(187)=72;
dutyA(188)=27;dutyB(188)=67;dutyC(188)=73;
dutyA(189)=27;dutyB(189)=66;dutyC(189)=73;
dutyA(190)=26;dutyB(190)=65;dutyC(190)=73;
dutyA(191)=27;dutyB(191)=65;dutyC(191)=73;
dutyA(192)=27;dutyB(192)=64;dutyC(192)=73;
dutyA(193)=26;dutyB(193)=63;dutyC(193)=73;
dutyA(194)=26;dutyB(194)=62;dutyC(194)=73;
dutyA(195)=26;dutyB(195)=62;dutyC(195)=74;
dutyA(196)=26;dutyB(196)=61;dutyC(196)=74;
dutyA(197)=26;dutyB(197)=60;dutyC(197)=74;
dutyA(198)=26;dutyB(198)=60;dutyC(198)=74;
dutyA(199)=26;dutyB(199)=59;dutyC(199)=74;
dutyA(200)=25;dutyB(200)=58;dutyC(200)=74;
dutyA(201)=25;dutyB(201)=57;dutyC(201)=74;
dutyA(202)=25;dutyB(202)=56;dutyC(202)=74;
dutyA(203)=25;dutyB(203)=56;dutyC(203)=74;
dutyA(204)=25;dutyB(204)=55;dutyC(204)=74;
dutyA(205)=25;dutyB(205)=54;dutyC(205)=74;
dutyA(206)=25;dutyB(206)=53;dutyC(206)=74;
dutyA(207)=25;dutyB(207)=53;dutyC(207)=75;
dutyA(208)=25;dutyB(208)=52;dutyC(208)=74;
dutyA(209)=25;dutyB(209)=51;dutyC(209)=74;
dutyA(210)=25;dutyB(210)=51;dutyC(210)=75;
dutyA(211)=25;dutyB(211)=50;dutyC(211)=75;
dutyA(212)=25;dutyB(212)=49;dutyC(212)=75;
dutyA(213)=25;dutyB(213)=48;dutyC(213)=74;
dutyA(214)=25;dutyB(214)=47;dutyC(214)=74;
dutyA(215)=25;dutyB(215)=47;dutyC(215)=75;
dutyA(216)=25;dutyB(216)=46;dutyC(216)=74;
dutyA(217)=25;dutyB(217)=45;dutyC(217)=74;
dutyA(218)=25;dutyB(218)=44;dutyC(218)=74;
dutyA(219)=25;dutyB(219)=43;dutyC(219)=74;
dutyA(220)=25;dutyB(220)=43;dutyC(220)=74;
dutyA(221)=25;dutyB(221)=42;dutyC(221)=74;
dutyA(222)=25;dutyB(222)=41;dutyC(222)=74;
dutyA(223)=26;dutyB(223)=41;dutyC(223)=74;
dutyA(224)=26;dutyB(224)=40;dutyC(224)=74;
dutyA(225)=26;dutyB(225)=40;dutyC(225)=74;
dutyA(226)=26;dutyB(226)=39;dutyC(226)=74;
dutyA(227)=26;dutyB(227)=38;dutyC(227)=74;
dutyA(228)=26;dutyB(228)=37;dutyC(228)=73;
dutyA(229)=26;dutyB(229)=36;dutyC(229)=73;
dutyA(230)=27;dutyB(230)=36;dutyC(230)=73;
dutyA(231)=27;dutyB(231)=35;dutyC(231)=73;
dutyA(232)=26;dutyB(232)=34;dutyC(232)=73;
dutyA(233)=27;dutyB(233)=34;dutyC(233)=73;
dutyA(234)=27;dutyB(234)=33;dutyC(234)=73;
dutyA(235)=27;dutyB(235)=32;dutyC(235)=72;
dutyA(236)=27;dutyB(236)=31;dutyC(236)=72;
dutyA(237)=28;dutyB(237)=31;dutyC(237)=72;
dutyA(238)=28;dutyB(238)=30;dutyC(238)=72;
dutyA(239)=28;dutyB(239)=29;dutyC(239)=71;
dutyA(240)=28;dutyB(240)=29;dutyC(240)=72;
dutyA(241)=28;dutyB(241)=28;dutyC(241)=71;
dutyA(242)=29;dutyB(242)=28;dutyC(242)=72;
dutyA(243)=29;dutyB(243)=28;dutyC(243)=71;
dutyA(244)=30;dutyB(244)=28;dutyC(244)=72;
dutyA(245)=31;dutyB(245)=28;dutyC(245)=72;
dutyA(246)=31;dutyB(246)=27;dutyC(246)=72;
dutyA(247)=32;dutyB(247)=27;dutyC(247)=72;
dutyA(248)=33;dutyB(248)=27;dutyC(248)=73;
dutyA(249)=34;dutyB(249)=27;dutyC(249)=73;
dutyA(250)=34;dutyB(250)=26;dutyC(250)=73;
dutyA(251)=35;dutyB(251)=27;dutyC(251)=73;
dutyA(252)=36;dutyB(252)=27;dutyC(252)=73;
dutyA(253)=36;dutyB(253)=26;dutyC(253)=73;
dutyA(254)=37;dutyB(254)=26;dutyC(254)=73;
dutyA(255)=38;dutyB(255)=26;dutyC(255)=74;
dutyA(256)=39;dutyB(256)=26;dutyC(256)=74;
dutyA(257)=40;dutyB(257)=26;dutyC(257)=74;
dutyA(258)=40;dutyB(258)=26;dutyC(258)=74;
dutyA(259)=41;dutyB(259)=26;dutyC(259)=74;
dutyA(260)=41;dutyB(260)=25;dutyC(260)=74;
dutyA(261)=42;dutyB(261)=25;dutyC(261)=74;
dutyA(262)=43;dutyB(262)=25;dutyC(262)=74;
dutyA(263)=43;dutyB(263)=25;dutyC(263)=74;
dutyA(264)=44;dutyB(264)=25;dutyC(264)=74;
dutyA(265)=45;dutyB(265)=25;dutyC(265)=74;
dutyA(266)=46;dutyB(266)=25;dutyC(266)=74;
dutyA(267)=47;dutyB(267)=25;dutyC(267)=75;
dutyA(268)=47;dutyB(268)=25;dutyC(268)=74;
dutyA(269)=48;dutyB(269)=25;dutyC(269)=74;
dutyA(270)=49;dutyB(270)=25;dutyC(270)=75;
dutyA(271)=50;dutyB(271)=25;dutyC(271)=75;
dutyA(272)=51;dutyB(272)=25;dutyC(272)=75;
dutyA(273)=51;dutyB(273)=25;dutyC(273)=74;
dutyA(274)=52;dutyB(274)=25;dutyC(274)=74;
dutyA(275)=53;dutyB(275)=25;dutyC(275)=75;
dutyA(276)=53;dutyB(276)=25;dutyC(276)=74;
dutyA(277)=54;dutyB(277)=25;dutyC(277)=74;
dutyA(278)=55;dutyB(278)=25;dutyC(278)=74;
dutyA(279)=56;dutyB(279)=25;dutyC(279)=74;
dutyA(280)=56;dutyB(280)=25;dutyC(280)=74;
dutyA(281)=57;dutyB(281)=25;dutyC(281)=74;
dutyA(282)=58;dutyB(282)=25;dutyC(282)=74;
dutyA(283)=59;dutyB(283)=26;dutyC(283)=74;
dutyA(284)=60;dutyB(284)=26;dutyC(284)=74;
dutyA(285)=60;dutyB(285)=26;dutyC(285)=74;
dutyA(286)=61;dutyB(286)=26;dutyC(286)=74;
dutyA(287)=62;dutyB(287)=26;dutyC(287)=74;
dutyA(288)=62;dutyB(288)=26;dutyC(288)=73;
dutyA(289)=63;dutyB(289)=26;dutyC(289)=73;
dutyA(290)=64;dutyB(290)=27;dutyC(290)=73;
dutyA(291)=65;dutyB(291)=27;dutyC(291)=73;
dutyA(292)=65;dutyB(292)=26;dutyC(292)=73;
dutyA(293)=66;dutyB(293)=27;dutyC(293)=73;
dutyA(294)=67;dutyB(294)=27;dutyC(294)=73;
dutyA(295)=67;dutyB(295)=27;dutyC(295)=72;
dutyA(296)=68;dutyB(296)=27;dutyC(296)=72;
dutyA(297)=69;dutyB(297)=28;dutyC(297)=72;
dutyA(298)=70;dutyB(298)=28;dutyC(298)=72;
dutyA(299)=70;dutyB(299)=28;dutyC(299)=71;
dutyA(300)=71;dutyB(300)=28;dutyC(300)=72;
dutyA(301)=71;dutyB(301)=28;dutyC(301)=71;
dutyA(302)=72;dutyB(302)=28;dutyC(302)=71;
dutyA(303)=71;dutyB(303)=28;dutyC(303)=70;
dutyA(304)=72;dutyB(304)=28;dutyC(304)=70;
dutyA(305)=72;dutyB(305)=28;dutyC(305)=69;
dutyA(306)=72;dutyB(306)=27;dutyC(306)=68;
dutyA(307)=72;dutyB(307)=27;dutyC(307)=67;
dutyA(308)=73;dutyB(308)=27;dutyC(308)=67;
dutyA(309)=73;dutyB(309)=27;dutyC(309)=66;
dutyA(310)=73;dutyB(310)=26;dutyC(310)=65;
dutyA(311)=73;dutyB(311)=27;dutyC(311)=65;
dutyA(312)=73;dutyB(312)=27;dutyC(312)=64;
dutyA(313)=73;dutyB(313)=26;dutyC(313)=63;
dutyA(314)=73;dutyB(314)=26;dutyC(314)=62;
dutyA(315)=74;dutyB(315)=26;dutyC(315)=62;
dutyA(316)=74;dutyB(316)=26;dutyC(316)=61;
dutyA(317)=74;dutyB(317)=26;dutyC(317)=60;
dutyA(318)=74;dutyB(318)=26;dutyC(318)=60;
dutyA(319)=74;dutyB(319)=26;dutyC(319)=59;
dutyA(320)=74;dutyB(320)=25;dutyC(320)=58;
dutyA(321)=74;dutyB(321)=25;dutyC(321)=57;
dutyA(322)=74;dutyB(322)=25;dutyC(322)=56;
dutyA(323)=74;dutyB(323)=25;dutyC(323)=56;
dutyA(324)=74;dutyB(324)=25;dutyC(324)=55;
dutyA(325)=74;dutyB(325)=25;dutyC(325)=54;
dutyA(326)=74;dutyB(326)=25;dutyC(326)=53;
dutyA(327)=75;dutyB(327)=25;dutyC(327)=53;
dutyA(328)=74;dutyB(328)=25;dutyC(328)=52;
dutyA(329)=74;dutyB(329)=25;dutyC(329)=51;
dutyA(330)=75;dutyB(330)=25;dutyC(330)=51;
dutyA(331)=75;dutyB(331)=25;dutyC(331)=50;
dutyA(332)=75;dutyB(332)=25;dutyC(332)=49;
dutyA(333)=74;dutyB(333)=25;dutyC(333)=48;
dutyA(334)=74;dutyB(334)=25;dutyC(334)=47;
dutyA(335)=75;dutyB(335)=25;dutyC(335)=47;
dutyA(336)=74;dutyB(336)=25;dutyC(336)=46;
dutyA(337)=74;dutyB(337)=25;dutyC(337)=45;
dutyA(338)=74;dutyB(338)=25;dutyC(338)=44;
dutyA(339)=74;dutyB(339)=25;dutyC(339)=43;
dutyA(340)=74;dutyB(340)=25;dutyC(340)=43;
dutyA(341)=74;dutyB(341)=25;dutyC(341)=42;
dutyA(342)=74;dutyB(342)=25;dutyC(342)=41;
dutyA(343)=74;dutyB(343)=26;dutyC(343)=41;
dutyA(344)=74;dutyB(344)=26;dutyC(344)=40;
dutyA(345)=74;dutyB(345)=26;dutyC(345)=40;
dutyA(346)=74;dutyB(346)=26;dutyC(346)=39;
dutyA(347)=74;dutyB(347)=26;dutyC(347)=38;
dutyA(348)=73;dutyB(348)=26;dutyC(348)=37;
dutyA(349)=73;dutyB(349)=26;dutyC(349)=36;
dutyA(350)=73;dutyB(350)=27;dutyC(350)=36;
dutyA(351)=73;dutyB(351)=27;dutyC(351)=35;
dutyA(352)=73;dutyB(352)=26;dutyC(352)=34;
dutyA(353)=73;dutyB(353)=27;dutyC(353)=34;
dutyA(354)=73;dutyB(354)=27;dutyC(354)=33;
dutyA(355)=72;dutyB(355)=27;dutyC(355)=32;
dutyA(356)=72;dutyB(356)=27;dutyC(356)=31;
dutyA(357)=72;dutyB(357)=28;dutyC(357)=31;
dutyA(358)=72;dutyB(358)=28;dutyC(358)=30;
dutyA(359)=71;dutyB(359)=28;dutyC(359)=29;
dutyA(360)=72;dutyB(360)=28;dutyC(360)=29;


plot(dutyA,'r*-','LineWidth',1);hold on;
plot(dutyB,'gs:','LineWidth',1);hold on;
plot(dutyC,'bs:','LineWidth',1);hold on;







clear,clc,clf
myson_rpm=[0 98 248 384 500 594]/2
myson_current=[126 143 168 190 240 290]
fortior_rpm=[0 248 372 494 544 623 722 1046]/2
fortior_curent=[20 98 124 155 157 200 244 396]
plot(myson_rpm,myson_current,'bo-','LineWidth',5);hold on;
plot(fortior_rpm,fortior_curent,'gs:','LineWidth',5);hold on;
xlabel('speed [rpm]');
ylabel('current [mA]');
title('current vs rpm @ 12V');
legend('Myson','Fortior')
axis([0 550 0 420])
grid on




aa=0:1:59;bb=sind(aa)*10000;sinetable10000=round(bb)
aa=0:1:59;bb=sind(aa)*1000;sinetable1000=round(bb)
aa=0:1:59;bb=sind(aa)*100;sinetable100=round(bb)

clear,clc,

sinetable10000 = [
0, 175, 349, 523, 698, 872, 1045, 1219, 1392, 1564, 1736, 1908, 2079, 2250, 2419, 2588, 2756, 2924, 3090, 3256, 3420, 3584, 3746, 3907, 4067, 4226, 4384, 4540, 4695, 4848, 5000, 5150, 5299, 5446, 5592, 5736, 5878, 6018, 6157, 6293, 6428, 6561, 6691, 6820, 6947, 7071, 7193, 7314, 7431, 7547, 7660, 7771, 7880, 7986, 8090, 8192, 8290, 8387, 8480, 8572]
sinetable1000 = [
0, 17, 35, 52, 70, 87, 105, 122, 139, 156, 174, 191, 208, 225, 242, 259, 276, 292, 309, 326, 342, 358, 375, 391, 407, 423, 438, 454, 469, 485, 500, 515, 530, 545, 559, 574, 588, 602, 616, 629, 643, 656, 669, 682, 695, 707, 719, 731, 743, 755, 766, 777, 788, 799, 809, 819, 829, 839, 848, 857]
sinetable100 = [
0,  2,  3,  5,  7,  9, 10, 12, 14, 16, 17, 19, 21, 22, 24, 26, 28, 29, 31, 33, 34, 36, 37, 39, 41, 42, 44, 45, 47, 48, 50, 52, 53, 54, 56, 57, 59, 60, 62, 63, 64, 66, 67, 68, 69, 71, 72, 73, 74, 75, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86]

whos


const int sinetable10000[] = {
0, 175, 349, 523, 698, 872, 1045, 1219, 1392, 1564, 1736, 1908, 2079, 2250, 2419, 2588, 2756, 2924, 3090, 3256, 3420, 3584, 3746, 3907, 4067, 4226, 4384, 4540, 4695, 4848, 5000, 5150, 5299, 5446, 5592, 5736, 5878, 6018, 6157, 6293, 6428, 6561, 6691, 6820, 6947, 7071, 7193, 7314, 7431, 7547, 7660, 7771, 7880, 7986, 8090, 8192, 8290, 8387, 8480, 8572};
const int sinetable1000[] = {
0, 17, 35, 52, 70, 87, 105, 122, 139, 156, 174, 191, 208, 225, 242, 259, 276, 292, 309, 326, 342, 358, 375, 391, 407, 423, 438, 454, 469, 485, 500, 515, 530, 545, 559, 574, 588, 602, 616, 629, 643, 656, 669, 682, 695, 707, 719, 731, 743, 755, 766, 777, 788, 799, 809, 819, 829, 839, 848, 857};
const int sinetable100[] = {
0,  2,  3,  5,  7,  9, 10, 12, 14, 16, 17, 19, 21, 22, 24, 26, 28, 29, 31, 33, 34, 36, 37, 39, 41, 42, 44, 45, 47, 48, 50, 52, 53, 54, 56, 57, 59, 60, 62, 63, 64, 66, 67, 68, 69, 71, 72, 73, 74, 75, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86};







M=50
angle=30

dutyA=(100+M*sind(60-angle)/100+M*sind(angle)/100)/2
dutyB=(100-M*sind(60-angle)/100+M*sind(angle)/100)/2
dutyC=(100-M*sind(60-angle)100-M*sind(angle))/100/2




	printString("angle = ");printd(angle);printString("\n");
	printString("M = ");printd(M);printString("\n");

M=50
angle=30;
sin1=50
sin2=50
dutyA=(100+M*sin2/100+M*sin1/100)/2
dutyB=(100-M*sin2/100+M*sin1/100)/2
dutyC=(100-M*sin2/100-M*sin1/100)/2




plot(dutyA,'r*-','LineWidth',1);hold on;
plot(dutyB,'gs:','LineWidth',1);hold on;
plot(dutyC,'bs:','LineWidth',1);hold on;







Format compact
aa=0:1:59;bb=sind(aa)*10000;sinetable10000=round(bb)
aa=0:1:59;bb=sind(aa)*1000;sinetable1000=round(bb)
aa=0:1:59;bb=sind(aa)*100;sinetable100=round(bb)




調制比的極大極小值為何？



M=0.1
angle=30;


dutyA=(1+M*sind(60-angle)+M*sind(angle))/2
dutyB=(1-M*sind(60-angle)+M*sind(angle))/2
dutyC=(1-M*sind(60-angle)-M*sind(angle))/2

aa=0:1:59;bb=sind(aa)*100;c1=floor(bb),c2=round(bb);
plot(aa,c1,'r*-','LineWidth',3);hold on;
plot(aa,c2,'gs:','LineWidth',3);hold on;
x=linspace(0,59,60);
c3=sind(x)*100;
plot(x,c3,'-','LineWidth',3);hold on;


PWM_AA2=[PWM_AA fliplr(PWM_BB) fliplr(PWM_CC) (PWM_CC) (PWM_BB) fliplr(PWM_AA)];
PWM_BB2=[PWM_BB fliplr(PWM_AA) (PWM_AA) fliplr(PWM_BB) fliplr(PWM_CC) (PWM_CC)];
PWM_CC2=[PWM_CC fliplr(PWM_CC) (PWM_BB) fliplr(PWM_AA) (PWM_AA) fliplr(PWM_BB)];

plot(alpha,PWM_AA,'r*-','LineWidth',5);hold on;
plot(alpha,PWM_BB,'gs:','LineWidth',5);hold on;
plot(alpha,PWM_CC,'b^-.','LineWidth',5);hold on;

PWM_M40_A=[PWM_AA,fliplr(PWM_BB),PWM_CC,fliplr(PWM_CC),PWM_BB,fliplr(PWM_AA)];
PWM_M40_B=[PWM_BB,fliplr(PWM_AA),PWM_AA,fliplr(PWM_BB),PWM_CC,fliplr(PWM_CC)];
PWM_M40_C=[PWM_CC,fliplr(PWM_CC),PWM_BB,fliplr(PWM_AA),PWM_AA,fliplr(PWM_BB)];

alpha=60:10:120;
plot(alpha,fliplr(PWM_BB),'r*-','LineWidth',5);hold on;
plot(alpha,fliplr(PWM_AA),'gs:','LineWidth',5);hold on;
plot(alpha,fliplr(PWM_CC),'b^-.','LineWidth',5);hold on;

alpha=120:10:180;
plot(alpha,PWM_CC,'r*-','LineWidth',5);hold on;
plot(alpha,PWM_AA,'gs:','LineWidth',5);hold on;
plot(alpha,PWM_BB,'b^-.','LineWidth',5);hold on;


subplot(9,1,1), plot(t,y1,'LineWidth',3);axis([0 time -120 120]);

plot(DUTY_I,'m-','LineWidth',3);hold on;
plot(DUTY_A,'r-','LineWidth',3);hold on;
plot(DUTY_B,'g-','LineWidth',3);hold on;
plot(DUTY_C,'b-','LineWidth',3);hold on;




plot(DUTY_I,'m-');hold on;
plot(DUTY_A,'r-');hold on;
plot(DUTY_B,'g-');hold on;
plot(DUTY_C,'b*-');hold on;





BYTE PWM_1_0[3][7]={{93, 96, 99, 99, 99, 96, 93},{ 6, 20, 34, 50, 65, 79, 93},{ 6,  3, 0,  0,  0,  3,  6}};
BYTE PWM_0_8[3][7]={{84, 87, 89, 89, 89, 87, 84},{15, 26, 37, 50, 62, 73, 84},{15, 12, 10, 10, 10, 12, 15}};
BYTE PWM_0_6[3][7]={{75, 78, 79, 80, 79, 78, 75},{24, 32, 40, 50, 59, 67, 75},{24, 21, 20, 20, 20, 21, 24}};







%KPWM
clear,clc,clf

A=50;
for angle=1:1:60
PWM(angle) = A;
KPWM(angle) = A*1.4*sind(angle*3);
KKPWM(angle) = A*1*sind(angle*3)+20;
end

subplot(311);bar(PWM, 'r');hold on;
subplot(312);bar(KPWM, 'b');hold on;
subplot(313);bar(KKPWM, 'g');hold on;










一般

新進
x=0:0.5:4*pi;
y=sin(x);
plot(x,y);pause
plot(x,y,'linewidth',3)     % 線寬會是前者的3倍



可以利用print的指令，到matlab下打help print會有詳細的介紹。
若想存成jpg格式，指令如下
    print -djpeg 存檔路徑及檔名

ezplot('sin'),print -djpeg sinn.jpg  //這樣會把sin的圖形直接存進檔案


標題加變數
   title([ 'Temp. = ', num2str(T),' C;   hr = ', num2str(hr), ' h;   neff = ', num2str(neff)])


__MATLAB有關_tmp

按 help & 可查算數有關指令。



 bitand( bitand( hex2dec( '3fffff' ),hex2dec('1e0010') ), hex2dec('100'))



//用MATLAB讀文字檔，一次讀一行
fid=fopen('name.dat');
while feof(fid)==0
    line=fgetl(fid);
    disp(line);
end

尋找4的倍數：
1.除四	2.無條件捨去	3.乘四
in MATLAB
a='1118',b=hex2dec(a),c=floor(b/4),d=c*4,e=dec2hex(d),f=a-e,

bar3(aaa) 可用來畫矩陣aaa的值

at the matlab prompt, generate
random 8x8 matrix;
a = round(150+10*rand(8))
a =
   160   155   152   154   157   152   157   155
   155   151   152   158   157   154   157   159
   158   157   156   159   153   151   159   159
   156   155   150   150   159   154   158   155
   153   152   153   157   153   159   155   158
   157   157   153   158   151   154   156   157
   154   151   150   157   157   153   151   150
   159   160   151   160   160   154   155   151

還沒測2項：
x=randn(5:1);		%A random vector of length 5.
d=gcd(48000,44100);	%求gcd

[y, fs] = wavread(‘toilet.wav’);
subplot(2,1,1), plot((1:length(y))/fs, y);
xlabel(‘Time in seconds’); ylabel(‘Amplitude’);

%qqq
clear
m=1:10;
for i=1:length(m)
   n=m.^2;
   nf=[m' n'];
   %   save(['data'int2str(i)],'nf','m','n')	%只存3個變數
   %save(['data'int2str(i)],'nf')		%只存一個變數
   save(['data'int2str(i)])		%儲存所有變數
end

FOR variable = expr, statement, ..., statement END

FOR I = 1:N,
	FOR J = 1:N,
        	A(I,J) = 1/(I+J-1);
	END
END

IF expression
       	statements
		ELSEIF expression
			statements
		ELSE
		statements
END

if I == J
	A(I,J) = 2;
		elseif abs(I-J) == 1
			A(I,J) = -1;
       		else
         	A(I,J) = 0;
end


//檢視是否為空矩陣
A=[1];isempty(A)	=> 0
B=[ ];isempty(B)	=> 1

//取較長的邊
A=[1 1 1;1 1 1]
size(A)		=> 	2  3
length(A)	=>	3

a = magic(10)
image(a)		//把矩陣圖形畫出來

aaa=imread('think.bmp','bmp');
bar3(aaa);pause;
imwrite(aaa,'think1_nodct.bmp','bmp');
bbb=dct2(aaa);
imwrite(bbb,'think2_dcted.bmp','bmp');
bar3(bbb);pause;
ccc=idct2(bbb);
imwrite(ccc,'think3_idcted.bmp','bmp');
bar3(ccc);
//可是存檔後一律變黑白，不知為什麼，但輪廓對。

    row column
a=j(428,374,1)	//紅色灰階值	R
b=j(428,374,2)	//綠色灰階值	G
c=j(428,374,3)	//藍色灰階值	B

MATLAB之影像處理
image秀圖
imread讀取
imwrite存檔

INFO = IMFINFO('think.bmp')把圖形的資料叫出來

你可以利用 matlab 裡的一些 functions
然後自己轉換.
這些 function 如:
bin2dec,dec2bin,hex2dec,dec2hex,dec2base
> 請問各位高手
> 要如何把做完運算後的圖使用imwrite的指令寫成.bmp的檔
> 我可以存成.ttf檔  但就是沒辦法存成.bmp檔
> 這是啥原因呢？
> 請賜教  謝謝

你可以試著用 print 指令去做
例如: print -dbitmap test
將會把你的圖形存成 test.bmp 檔
詳細請 help print


> 小弟在做bmp檔影像處理時  發現要結果的
> 將array的值  利用bmpwrite
> or  imwrite去做儲存的動作
> 可是他都會告訴我那個colormap有問題
> 請教一下各位大哥  bmpwrite或imwrite的使用方法
> 謝謝 !


   imwrite(x,newmap,'new.bmp','bmp');

     x為圖檔的data,newmap為你處後的map,new.bmp則是新檔名....這樣應該可以...

         不知有沒解決你的問題!!
--

   imwrite(ccc,newmap,'thinkkk.bmp','bmp');


?help sign
 SIGN   Signum function.
    For each element of X, SIGN(X) returns 1 if the element
    is greater than zero, 0 if it equals zero and -1 if it is
    less than zero.  For complex X, SIGN(X) = X ./ ABS(X).

?help round
 ROUND  Round towards nearest integer.
    ROUND(X) rounds the elements of X to the nearest integers.

    See also FLOOR, CEIL, FIX.










MATLAB	bin2dec指令

whos


一、基本指令
%	//註解。
who	//查詢用了哪些常數。
clear	//清除所有變數的內容，亦可清除單一變數，如clear a。
clc	//清除畫面。
clf	//清除圖形視窗。
ctrl+c	//中斷程式進行。
quit	//結束MATLAB
exit	//結束MATLAB，兩個指令好像差不多。
save	save filename.dat E1 /ascii	//用ascii的格式儲存矩陣資料E1於檔案filename.dat中。
load	load filename.dat -ascii	//用ascii的格式讀取資料於檔案filename.dat中。矩陣名稱為filename。
print	print -djpeg 存檔路徑及檔名。
	print -djpeg test.jpg	//把目前的圖存成test.jpg。
	ezplot('sin'),print -djpeg sinn.jpg  //這樣會把sin的圖形直接存進檔案。
...	一行不夠寫，在該行之最後面連點三點或三點以上(如”…”)，代表將延續到下一行。
edit	edit filename.m	//直接編輯某程式，MATLAB會自動去搜尋程式，並用M-edit開啟。
:	x=-100:.1:100	//定義x。
linspace	x=linspace(-100,100,50)	//定義x。
meshgrid	[x,y]=meshgrid(-2:.2:2,-2:.2:2)	//定義一個x y網狀結構。x、y的個數可以不一樣多。
	ex: 製作網狀結構矩陣：
	x=linspace(-2,2,40); y=linspace(-1,1,60); 	%故意讓x、y不一樣大，個數也不一樣多。
	[xx,yy]=meshgrid(x,y);		%製作網狀交錯矩陣的方法。
syms x y	//令x y為變數。
length(a)	//取a向量陣列的長度(個數) 。
max(size(x))	//取x向量的長度(個數)(結果同上) 。
size(A)		//求A矩陣的維度。
A(a,b)		//求A矩陣中(a,b)位置的值。
f=[a;t]		//上下合併矩陣。
f=[a;t']	//左右合併矩陣。
pause(n)	//暫停n秒鐘。不加時間只寫pause則是按鍵繼續。
fix;round	//將浮點數作整數的輸出
digits(n)	//有效數字, n代表所要求的位數。
c=input('提示字元，要求輸入的情況')	//像C一樣如scanf的功能。
disp('單引號內是要顯示出的');disp(A)	//顯示提示字和數值A。
fix;round	//將浮點數作整數的輸出
floor		//無條件捨去	一律往左
ceil		//無條件進位	一律往右
round		//四捨五入	一律往外
fix		//四捨五入	一律往內
num2str		//數字轉字串
str2num		//字串轉數字


二、計算
.op		//陣列(array)運算。  .*  array  multiply。
 op		//矩陣(matrix)運算。 * matrix multiply。
' (prime)		//轉置(Transpose) 。
B'*A*B		//矩陣的轉置與乘法(求相似矩陣)。
sqrt(A)		//取A矩陣或陣列的所有值的平方根。
n!	n=10;p=1;for i=1:n;p=i*p;end;p	//n階乘。=factorial(n)
	x=1:n;result=prod(x);		//n階乘。=factorial(n)
diff	diff(f,x)			//對x偏微分。
int	int(exp(-i*x),x,0,pi/2)		//對x積分。
int	int(sin(x)*sin(x),x,0,pi)	//對x積分。
x=[1 3 5 2 6];mean(x)		//取向量x的平均值
A=[1 3 5; 2 3 6];mean(A)	//取矩陣A的行平均值
mean	//平均值	std	//標準差
cross(A,B)		//求AB兩三元素向量的外積，其結果亦為三元素向量。
sum(A.*B)		//求AB兩三元素向量的內積，其結果為一純量。
det(A)			//求方陣A之行列式值。
eval(多項式表示式)	//把多項式的值代進去。
			ex:      solve('5*cos(x)=3')   得 acos(3/5)
			    eval(solve('5*cos(x)=3'))  得 0.9273
expand	syms x y,expand(tan(x+y))	//把多項式展開。
fourier	//富利葉
	ex: x='heaviside(t)',syms x,f=fourier(x)
	    f = 2*i*pi*Dirac(1,w)
矩陣E，E^2代表E*E，E.^2代表每個元素分別平方。
矩陣逆向排列：
若aa=[1 2 3 4 5],逆向排列則：bb=aa(length(aa):-1:1)

三、繪圖
menu	K=MENU('Choose a color','Red','Blue','Green')		//選單的使用
questdlg	//問題對話盒的使用範例1
	button = questdlg('Ready to quit?','Exit Dialog','Yes','No','No');
         	switch button
            	case 'Yes',
              ......
            	case 'No',
              ......
         	end
         	//問題對話盒的使用範例2
	ButtonName=questdlg('What is your wish?','Genie Question','Food','Clothing','Money','Money');
     	switch ButtonName,
        	case 'Food',
         	disp('Food is delivered');
       	case 'Clothing',
         	disp('The Emperor''s  new clothes have arrived.')
       	case 'Money',
         	disp('A ton of money falls out the sky.');
     	end 	% switch

fplot	fplot('tanh',[-2 2])	fplot('sin',[-2 2])	fplot('myfun',[-20 20],50,2)	//直接把函式畫出來
ezplot	ezplot('sin(x)*sin(10*x)')	//直接把函數畫出來
	ezplot('sin')		//直接把sin函數畫出來
	EZPLOT(f) plots f = f(x) over the default domain -2*pi < x < 2*pi
	EZPLOT(f, [a,b]) plots f = f(x) over a < x < b
plot	plot(x,y)	//2D繪圖。
	plot(x,y,'linewidth',3)	// 線寬會是原設定的3倍。
	plot(a)	//畫出a向量陣列。
	plot(a,b)	//畫出a向量陣列對b向量陣列做圖。跟line指令差不多。可用來連坐標點做圖。
圖形的點和線:	y     yellow	.     point             -     solid
           	m     magenta   o     circle            :     dotted
           	c     cyan      x     x-mark            -.    dashdot
           	r     red       +     plus		--    dashed
           	g     green     *     star
           	b     blue      s     square
           	w     white     d     diamond
           	k     black     v     triangle (down)
                               	^     triangle (up)
                                <     triangle (left)
                                >     triangle (right)
                                p     pentagram
                                h     hexagram
plot3	plot3(x,y,z)	//3D繪圖。


mesh meshc meshz	//網狀繪圖
colormap gray		//將圖形改成黑白
loglog(x,y) semilogx(x,y) semilogy(x,y)			//對數做圖
contour	[c,h] = contour(peaks); clabel(c,h), colorbar	//畫輪廓線，並色帶意義圖。
	contour(E,10)	//畫10條線
	contour(E1.^2)	//把E1平方再取contour?
	[C,h]=contour(x,y,z,10);clabel(C,h);		//標出峰值(最大或最小值)
quiver3	三維空間畫出3維的向量
	[x,y] = meshgrid(-2:.2:2,-1:.15:1);
        	z = x .* exp(-x.^2 - y.^2);
        	[u,v,w] = surfnorm(x,y,z);
        	quiver3(x,y,z,u,v,w); hold on, surf(x,y,z), hold off
subplot	subplot(324)	//分割畫面畫圖(3X2圖中第4圖(Z字形算法))。
hold on		//重疊圖形。		hold off	//覆蓋前圖。
figure		//另開新繪圖視窗。	figure(n)	//指明第n個繪圖視窗
lenend	legend('point','small','large');//說明、圖例。
gtext	gtext('Function')	//由方向鍵或是滑鼠來定位輸出。
	gtext({'This is the first line','This is the second line'})
       	gtext({'First line','Second line'},'FontName','Times','Fontsize',12)
 	使用變數
	ex:	k=pi;	sometext=sprintf('k=%g',k);	gtext(sometext);
		用help sprintf看一下格式使用說明。

ginput	//用滑鼠從圖上輸入座標。
	[X,Y] = GINPUT	//抓到按下Enter為止的點的座標。
	[X,Y,BUTTON] = GINPUT(N)	//N為要取的點數
axis	axis([1 8 -.5 .5]);	//設定要的XY軸邊界。	axis('auto')	//自動軸界。

axis	axis([X最小 X最大 Y最小 Y最大]);
	axis([1 8 -.5 .5]);	//設定要的XY軸邊界。	axis('auto')	//自動軸界。
	axis('square')		//方形圖案。		axis('equal')	//刻度相等。
grid	//加格線。
xlabel	//x軸標記。	ylabel	//y軸標記。
title	title('XXXX')	//註明標題。	title內可顯示中文！！ex: title('顯示中文字')'
	標題加變數  title([ 'Temp. = ', num2str(T),' C;   hr = ', num2str(hr), ' h;   neff = ', num2str(neff)])
	note:要加中括號。
zoom	//把圖放大縮小，按滑鼠左鍵放大按滑鼠右鍵縮小。
畫統計的圖：hist(直方圖)、area(面積圖)、bar(垂直長條圖)、pie(扇形圖)、、、、

畫函數圖形及求極值:
ex: 	f='x.^3-2*x-1';x=fmin('f',0,2)
	fplot('f',[-4 4])
	fplot('x.^3-2*x-1',[-4 4])

四、程式指令
for~end	ex:	for i=1:10 A(i)=A(i+1)-A(i) end

解方程式與代值
solve('a*x+c=0'),subs(ans,'a',100)	//解方程式，並代值進去，將100代入a。

最小平方法
polyfit	ex:有一筆資料(x,y),用最小平方法...fit一條直線y=ax+b....
	sol:使用一階的 polyfit 就是最小平方解了
	    [m,n]=polyfit(x,y,1);
    	    其中m(1)與m(2)就是所要的係數a與b,n不知道是什麼意思
聯立解
[x,y] = solve('x^2 + x*y + y = 3','x^2 - 4*x + 3 = 0')
[x,y,z]=solve('6*x + 2*y + 3*z = 6','3*x + 5*y + 4*z = 1',' 3*x + 7*y + 3*z=  9')

矩陣解法：     [6 2 3 ; 3 5 4 ; 3 7 3] * [x ; y ; z] = [6 1 9]
   	        =>            A            *      X      =    B
        	        A*X=B  =>  X = inv(A)*B   =>   X = A \ B
寫好的副程式
note: 副程式有沒有return沒有關係  (??)

副程式寫法 fplot('myfun',[-20 20],50,2) 所的即為畫出myfun的圖形。
function y=myfun(x)
% statement 1		//若鍵入：help 副程式，則會顯示出function下幾行註解敘述。
% statement 2
% statement 3
y(:,1)=200*sin(x(:))./x(:);
y(:,2)=x(:).^2;

副程式寫法  circle([0 0],1)  所畫出即為圓心是(0,0),半徑為1的圓了。
function circle(o,r);
% o is the center,r is the radius
k=linspace(0,2*pi,360);
x=o(1)+r*cos(k); y=o(2)+r*sin(k);
plot(x,y) axis equal
return

副程式寫法  factorial(5) 所得即為5階乘。
function factorial(n);
for i=1:n;
n=i;p=1;for i=1:n;p=i*p;end;
end
ans=p
return

五、心得
1.檔名、註解都可用中文，但m-edit看不懂，用Ultra-Edit就可以看懂。
  在win2000下，則顯示可正常。
2.檔名有時可以用中文有時不行，不知為什麼，故少用為妙！！
3.檔名不可以使用數字作開頭，否則MATLAB會不認識。
4.依據經驗，若製造一個含16百萬元素的矩陣，約需要430M的硬碟空間來儲存資料
平均每處存一個元素要26.87byte，而處理矩陣的大小應無上限，受限於硬碟空間。
5.變數的命名，英文字大小寫代表不一樣的意義。但檔名則大小寫一樣！
6.抓MATLAB的圖應該是要先在MATLAB裏把圖編輯好，選用MATLAB裏面的Copy figure，直接貼到PowerPoint即可。


六、繪圖及程式範例：
1.畫出：	二次方程式	ax*y^2+bx*y+c=0
	通常我們會先令 z=ax*y^2+bx*y+c;
	然後再以以 "contour" 這個指令畫出 z 這個函數的的等高線。
ex:	 [x,y] = meshgrid(-10:0.1:10,-10:0.1:10);
	 z=x.^2+y.^2;
	 mesh(z);
	 contour(z,10);		//畫10條contour線

2.畫出：	 x^2+y^2 >= 1 的圖形
暴力法
 x=linspace(-5,5,512);	 y=linspace(-5,5,512);
 [XX,YY]=meshgrid(x,y);
  ZZ=XX.^2+YY.^2;
 [C,h]=contourf(XX,YY,ZZ,[1 1]); axis('square'), axis([-5 5 -5 5])

3.畫出：	(1-x)*(1-y) 的圖形
 x=linspace(-1,1,20); y=linspace(-1,1,20);
 [xx,yy]=meshgrid(x,y);
 zz=(1-xx).*(1-yy);
 mesh(xx,yy,zz)

4.各種3D繪圖比較：
[x,y]=meshgrid(-2:.2:2);
z=sqrt(x.^2+y.^2);
subplot(221),mesh(x,y,z)
subplot(222),meshc(x,y,z)
subplot(223),meshz(x,y,z)
subplot(224),plot3(x,y,z)

5.動態正弦波：	//王：效果不是很好
x=0:0.1:10;y=[];
for i=1:length(x),
   y=[y sin(x(i))];
   plot(y,'o');
   AXIS([1 length(x) -1 1]);
   pause(0.2);
end

6.另一個動畫檔：	//王：但是看不懂
n = 10;
peaks;
M = moviein(n);
for j=1:n
view([-37.5+j*10, 30]); % 改變觀測角度
M(:, j) = getframe; % 抓取畫面，並存入電影矩陣M
end


6.梯度、散度、旋度、內外積運算：
% grad
clear,clc,
syms x,syms y,syms z,
f='sin(x)*sin(y)*sin(z)',
grad(1)=diff(f,x);
grad(2)=diff(f,y);
grad(3)=diff(f,z);
grad_f=grad

% div
clear,
syms x,syms y,syms z,
A=[sin(x*y),sin(x*y),exp(x*y*z)],
div_A=diff(A(1),x)+diff(A(2),y)+diff(A(3),z)

% curl
clear,
syms x,syms y,syms z,
A=[sin(x*y),sin(x*y),exp(x*y*z)],
curl(1)=diff(A(3),y)-diff(A(2),z);
curl(2)=diff(A(1),z)-diff(A(3),x);
curl(3)=diff(A(2),x)-diff(A(1),y);
curl_A=curl

% det
clear,
syms x,syms y,syms z,
A=[x y z;x*y y*z z*x; x^2 y^2 z^2],
det_A=det(A)

% cross
clear,
syms x,syms y,syms z,
A=[sin(x*y),sin(x*y),exp(x*y*z)],
B=[cos(z),cos(x*y),sin(x*y)],
disp('The cross product of A and B is');disp(cross(A,B))

7.畫圖大全集
%畫出各式各樣的GaussianBeam
clear,clc,
x=linspace(-2,2,40); y=linspace(-1,1,60); 	%故意讓x、y不一樣大，個數也不一樣多。
[xx,yy]=meshgrid(x,y);		%製作交錯矩陣的方法
zz=exp(-(xx.^2+yy.^2));
clf,mesh (xx,yy,zz),title(' mesh '),xlabel('x'),ylabel('y'),zlabel('z'),axis([-3 3 -3 3 0 1]),grid on,pause,
clf,meshc(xx,yy,zz),title('meshc = mesh + contour'),xlabel('x'),ylabel('y'),zlabel('z'),axis([-3 3 -3 3 0 1]),grid on,pause,
clf,meshz(xx,yy,zz),title('meshz = mesh + curtain'),xlabel('x'),ylabel('y'),zlabel('z'),axis([-3 3 -3 3 0 1]),grid on,pause,
clf,plot3(xx,yy,zz),title('plot3 = 3D plot'),xlabel('x'),ylabel('y'),zlabel('z'),axis([-3 3 -3 3 0 1]),grid on,pause,

clf,contour (xx,yy,zz,20),title('contour '),xlabel('x'),ylabel('y'),zlabel('z'),axis('equal'),grid on,pause,  %2D
clf,contourf(xx,yy,zz,20),title('contourf = filled contour'),xlabel('x'),ylabel('y'),zlabel('z'),axis('equal'),grid on,pause,  %2D
clf,contour3(xx,yy,zz,20),title('contour3 = 3D contour'),xlabel('x'),ylabel('y'),zlabel('z'),axis('equal'),grid on,pause,  %2D
clf,surf (xx,yy,zz),title('surf = 3D colored surface '),xlabel('x'),ylabel('y'),zlabel('z'),axis('equal'),grid on,pause,  %2D
clf,surfc(xx,yy,zz),title('surfc = surf + contour'),xlabel('x'),ylabel('y'),zlabel('z'),axis('equal'),grid on,pause,  %2D
clf,surfl(xx,yy,zz),title('surfl = surf + lighting'),xlabel('x'),ylabel('y'),zlabel('z'),axis('equal'),grid on,pause,  %2D
%若不標明zz對xx、yy做圖，則x座標指的是x的個數，則y座標指的是y的個數。

subplot(221), mesh(xx,yy,zz),title(' mesh'),xlabel('x'),ylabel('y'),zlabel('z'),grid on,axis([-3 3 -3 3 0 1]),
subplot(222),meshc(xx,yy,zz),title('meshc = mesh + contour'),xlabel('x'),ylabel('y'),zlabel('z'),grid on,axis([-3 3 -3 3 0 1]),
subplot(223),meshz(xx,yy,zz),title('meshz = mesh + curtain'),xlabel('x'),ylabel('y'),zlabel('z'),grid on,axis([-3 3 -3 3 0 1]),
subplot(224),plot3(xx,yy,zz),title('plot3 = 3D plot'),xlabel('x'),ylabel('y'),zlabel('z'),grid on,axis([-3 3 -3 3 0 1]),pause,
clf
subplot(231),contour (xx,yy,zz,20),title('contour '),xlabel('x'),ylabel('y'),zlabel('z'),axis('equal'),grid on,  %2D
subplot(232),contourf(xx,yy,zz,20),title('contourf = filled contour'),xlabel('x'),ylabel('y'),zlabel('z'),axis('equal'),grid on,  %2D
subplot(233),contour3(xx,yy,zz,20),title('contour3 = 3D contour'),xlabel('x'),ylabel('y'),zlabel('z'),axis('equal'),grid on,  %2D
subplot(234),surf (xx,yy,zz),title('surf = 3D colored surface'),xlabel('x'),ylabel('y'),zlabel('z'),axis('equal'),grid on,%2D
subplot(235),surfc(xx,yy,zz),title('surfc = surf + contour '),xlabel('x'),ylabel('y'),zlabel('z'),axis('equal'),grid on,%2D
subplot(236),surfl(xx,yy,zz),title('surfl = surf + lighting'),xlabel('x'),ylabel('y'),zlabel('z'),axis('equal'),grid on,%2D







