
I=imread('mo3.tiff','tiff');
J=fft2(I,256,256);	%圖像的FT
K1 = fftshift(J);	%移動係數
K2 = log(abs(K1));
figure
subplot(121);imshow(I)
subplot(122);imshow(K2,[])



clear,clc,clf
I=imread('mo3.tiff','tiff');
J=fft2(I,256,256);	%圖像的FT
K = ifft2(J,256,256);	%IFT
figure
subplot(121);imshow(log(abs(J)),[]);
subplot(122);imshow(K,[])




MATLAB自動偵測RS232 COM PORT

This function output a cell array with string name of each COM port available on your PC.

Example:
COM_Port = getAvailableComPort();




   1: function lCOM_Port = getAvailableComPort()

   2: % function lCOM_Port = getAvailableComPort()

   3: % Return a Cell Array of COM port names available on your computer

   4:  

   5: try

   6:     s=serial('IMPOSSIBLE_NAME_ON_PORT');fopen(s); 

   7: catch

   8:     lErrMsg = lasterr;

   9: end

  10:  

  11: %Start of the COM available port

  12: lIndex1 = findstr(lErrMsg,'COM');

  13: %End of COM available port

  14: lIndex2 = findstr(lErrMsg,'Use')-3;

  15:  

  16: lComStr = lErrMsg(lIndex1:lIndex2);

  17:  

  18: %Parse the resulting string

  19: lIndexDot = findstr(lComStr,',');

  20:  

  21: % If no Port are available

  22: if isempty(lIndex1)

  23:     lCOM_Port{1}='';

  24:     return;

  25: end

  26:  

  27: % If only one Port is available

  28: if isempty(lIndexDot)

  29:     lCOM_Port{1}=lComStr;

  30:     return;

  31: end

  32:  

  33: lCOM_Port{1} = lComStr(1:lIndexDot(1)-1);

  34:  

  35: for i=1:numel(lIndexDot)+1

  36:     % First One

  37:     if (i==1)

  38:         lCOM_Port{1,1} = lComStr(1:lIndexDot(i)-1);

  39:     % Last One

  40:     elseif (i==numel(lIndexDot)+1)

  41:         lCOM_Port{i,1} = lComStr(lIndexDot(i-1)+2:end);       

  42:     % Others

  43:     else

  44:         lCOM_Port{i,1} = lComStr(lIndexDot(i-1)+2:lIndexDot(i)-1);

  45:     end

  46: end    
  
  
  
