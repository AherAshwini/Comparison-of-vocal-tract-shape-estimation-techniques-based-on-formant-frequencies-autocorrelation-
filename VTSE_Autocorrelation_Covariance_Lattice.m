%% Read speech signal
clc
close all
clear all
   
[X,Fs] = wavread('C:\Users\');   %Input speech signal.

%% Define window size, step size
len1 = length(X);
% window_size = 220;    %Define window size.
% step_size = 110;    %Define step size.
window_size = round(Fs*20*10^-3);  
% window_size = round(window_size);   
step_size = round(window_size/2);
num_frames = floor(len1/step_size); %Calculate number of frames.
W = hamming(window_size);   %Hamming window.
len2 = len1-mod(len1,window_size);
X = X(1:len2);
x1 = reshape(X,window_size,len2/window_size);   %Convert speech signal into matrix.
% x2 = x1(:,42);
% s = 9320;
% x2 = X(s:s+window_size-1);
Frame_no = 47; %Select frame number. 
x2 = x1(:,Frame_no);
P = 12; %Define LPC order.
%n1 = 10000-P:10000+window_size;

%% Autocorrelation Method
for i = 1:1:window_size-1
    xw = x2*W'; %Windowing of signal.
    xp(i) = xw(i+1) - xw(i);    %Pre-emphasis of windowed signal.
    xl(i) = x2(i+1) - x2(i);
    xc = xcorr(xp,P);   %Compute autocorrrelation coefficients.
    R1 = ac2rc(xc(P+1:2*P+1));  %Convert autocorrelation coefficients into reflection coefficients.
end
for m = P
    sA(m) = 1;
end
for m = P-1:-1:1
    sA(m) = ((1+R1(m))/(1-R1(m)))*sA(m+1);  %Compute area value.
end
i = 2;
for m = P-1:-1:1
    SA(1) = 1;
    SA(i) = sA(m);
    i = i+1;
end

%% Covariance Method

for i = 1:1:len2-1
XC(i) = X(i+1)-X(i); 
end

n = 0;
n = Frame_no*window_size;
%   n = Frame_no;
%   x3 = X(n-P:n+window_size);
C1 = zeros(P,P);
for i = 1:P     %Compute covariance matrix.
    for k = 1:P
        C1(i,k) = 0; 
        for n1 = n-P:n+window_size-1
%             for n2 = 0:(window_size-1)
            C1(i,k) = C1(i,k)+XC(n1-i)*XC(n1-k);
%         end
    end
    end
end
C2 = zeros(P,1);    %Compute another covariance matrix.
for i = 1:P
    for n1 = n-P:n+window_size-1
%          for n2 = 0:(window_size-1)
        C2(i) = C2(i)+XC(n1-i)*XC(n1);
%          end
    end
end


lpc = lscov(C1,C2); 
lpc = [1-lpc];
R2 = poly2rc(lpc);%Convert LPC to RC.
for m = P    %Compute area value.
    sC(m) = 1;
end
for m = P-1:-1:1
    sC(m) = ((1+R2(m))/(1-R2(m)))*sC(m+1); 
end
l = 2;
for m = P-1:-1:1
    SC(1) = 1;
    SC(l) = sC(m);
    l = l+1;
end        

        
%% Lattice Method
[ar_coeffs,N_V,R3] = arburg(xl,P);   % Compute reflection coefficients

for m = P                   % Compute area value
    sL(m) = 1;
end
for m = P-1:-1:1
    sL(m) = ((1+R3(m))/(1-R3(m)))*sL(m+1);
end
i = 2;
for m = P-1:-1:1
    SL(1) = 1;
    SL(i) = sL(m);
    i = i+1;
end


%% Display the results
subplot 321;    %Plot speech signal.
plot(X,'k');
title('\bf(a)  Speech signal');
xlabel('Sample number');
ylabel('Amplitude');
axis tight;

subplot 323;    %Plot spectrogram.
spectrogram(X,window_size,step_size,256,Fs,'yaxis'); 
colormap(flipud(gray)); 
caxis([-120 -25]); 
title('\bf(b)   Spectrogram');
axis tight; 

subplot 325;    %Plot selected frame.
plot(x2,'k');
title('\bf(c)   Frame selected');
xlabel('Sample number');
ylabel('Amplitude');
axis tight;

subplot 322;    %Plot Vocal tract area function by autocorrelation method.
plot(SA,'k');
title('\bf(d)   Vocal tract area function by autocorrelation method');
xlabel('Section number from glottis to lips');
ylabel('Normalized area');
axis tight;

subplot 324;    %Plot Vocal tract area function by covariance method.
plot(SC,'k');
title('\bf(e)    Vocal tract area function by covariance method');
xlabel('Section number from glottis to lips');
ylabel('Normalized area');
axis tight;

subplot 326;    %Plot Vocal tract area function by lattice method.
plot(SL,'k');
title('\bf(f)   Vocal tract area function by lattice method');
xlabel('Section number from glottis to lips');
ylabel('Normalized area');
axis tight;

        
        

        
