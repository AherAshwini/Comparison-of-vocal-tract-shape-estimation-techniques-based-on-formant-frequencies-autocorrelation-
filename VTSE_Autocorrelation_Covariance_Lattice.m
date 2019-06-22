%% Read speech signal
clc
close all
clear all

[X,Fs] = wavread('C:\Users\HRISHI\desktop\sound_files\male_1\a');          
% [X,Fs] = wavread('C:\Users\HRISHI\desktop\sound_files\synthesized sounds\a'); 
sound(X,Fs);


%% Define window size, step size
window_size = round(Fs*20*10^-3); 
per_cent = 0.50;
step_size = round(window_size*per_cent);
W = hamming(window_size);  


len1 = length(X);
for q = 1:1:len1-1
X1(q) = X(q+1)-X(q); 
end
len2 = length(X1);
num_frames = round(len2/window_size);
X1(len2:num_frames*window_size) = 0;
len3 = length(X1);
X2_inp = X1(1:len3);
x1 = reshape(X2_inp,window_size,len3/window_size);  
Frame_no = 52; 
x2 = x1(:,Frame_no);
LPC_order = 12; 

%% Autocorrelation Method
for i = 1:1:window_size
    xw(i) = x2(i)*W(i); 
    xc = xcorr(xw,LPC_order);  
    R1 = ac2rc(xc(LPC_order+1:2*LPC_order+1));  
end

for m = LPC_order
    sA(m) = 1;
end
for m = LPC_order-1:-1:1
    sA(m) = ((1+R1(m))/(1-R1(m)))*sA(m+1); 
end

SA = fliplr(sA);
% i = 2;
% for m = LPC_order-1:-1:1
%     SA(1) = 1;
%     SA(i) = sA(m);
%     i = i+1;
% end

%% Covariance Method
n = 0;
n =  Frame_no*window_size;
n1 = n-LPC_order;

x2_cov = X2_inp(n1:n1+window_size);
cv_lpc = arcov(x2_cov,LPC_order);
R2 = poly2rc(cv_lpc);

for m = LPC_order    
    sC(m) = 1;
end
for m = LPC_order-1:-1:1
    sC(m) = ((1+R2(m))/(1-R2(m)))*sC(m+1); 
end

SC = fliplr(sC);
% l = 2;
% for m = LPC_order-1:-1:1
%     SC(1) = 1;
%     SC(l) = sC(m);
%     l = l+1;
% end 


%% Lattice Method
[ar_coeffs,N_V,R3] = arburg(x2,LPC_order);   

for m = LPC_order                   
    sL(m) = 1;
end
for m = LPC_order-1:-1:1
    sL(m) = ((1+R3(m))/(1-R3(m)))*sL(m+1);
end

SL = fliplr(sL);
% i = 2;
% for m = LPC_order-1:-1:1
%     SL(1) = 1;
%     SL(i) = sL(m);
%     i = i+1;
% end

%% Display the results
subplot 321;    %Plot speech signal.
plot(X,'k');
title('\bf(a)  Speech signal','fontname','Times New Roman','fontsize',11); 
xlabel('Sample number','fontname','Times New Roman','fontsize',10);
ylabel('Amplitude','fontname','Times New Roman','fontsize',10);
axis on;
axis tight;


subplot 323;    %Plot spectrogram.
window_size1 = round(Fs*7*10^-3);  
per_cent = 0.5;
step_size1 = round(per_cent*window_size1);
W1 = hamming(window_size1);
no_samples=round(30*Fs/1000);
% no_samples = 512
[S F T P] = spectrogram(X2_inp,hamming(window_size1),step_size1,no_samples,Fs);
imagesc(T,F,20*log10(abs(P)));
set(gca,'YDir','normal');
axis on;
axis tight;
colormap(gray);
sgmap = flipud(colormap);
colormap(sgmap);
caxis([-240  -90]);
title('\bf(b)   Wideband spectrogram','fontname','Times New Roman','fontsize',11);
xlabel('Time (sec)','fontname','Times New Roman','fontsize',10);
ylabel('Frequency (Hz)','fontname','Times New Roman','fontsize',10);
axis tight;

subplot 325;    %Plot selected frame.
plot(x2,'k');
title('\bf(c)   Selected frame','fontname','Times New Roman','fontsize',11);
xlabel('Sample number','fontname','Times New Roman','fontsize',10);
ylabel('Amplitude','fontname','Times New Roman','fontsize',10);
axis on;
axis tight;

subplot 322;    %Plot Vocal tract area function by autocorrelation method.
plot(SA,'k');
title('\bf(d)   Vocal tract area function by autocorrelation method','fontname','Times New Roman','fontsize',11);
xlabel('Section number from glottis to lips','fontname','Times New Roman','fontsize',10);
ylabel('Normalized area','fontname','Times New Roman','fontsize',10);
axis on;
axis tight;

subplot 324;    %Plot Vocal tract area function by covariance method.
plot(SC,'k');
title('\bf(e)    Vocal tract area function by covariance method','fontname','Times New Roman','fontsize',11);
xlabel('Section number from glottis to lips','fontname','Times New Roman','fontsize',10);
ylabel('Normalized area','fontname','Times New Roman','fontsize',10);
axis on;
axis tight;

subplot 326;    %Plot Vocal tract area function by lattice method.
plot(SL,'k');
title('\bf(f)   Vocal tract area function by lattice method','fontname','Times New Roman','fontsize',11);
xlabel('Section number from glottis to lips','fontname','Times New Roman','fontsize',10);
ylabel('Normalized area','fontname','Times New Roman','fontsize',10);
axis on;
axis tight;

