%% Read speech signal
clc
close all
clear all

% [X,Fs] = wavread('C:\Users\HRISHI\desktop\sound_files\male_1\a');         
[X,Fs] = wavread('C:\Users\HRISHI\desktop\sound_files\synthesized sounds\u'); 
vw = 3;         % a = 1; i = 2; u = 3
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
Frame_no =57;
x2 = x1(:,Frame_no);

%% Plot speech signal.
plot(X,'k');
subplot 321;    
plot(X,'k');
title('\bf(a)  Speech signal','fontname','Times New Roman','fontsize',11); 
xlabel('Sample number','fontname','Times New Roman','fontsize',10);
ylabel('Amplitude','fontname','Times New Roman','fontsize',10);
axis tight;

%% Plot spectrogram.
subplot 323;    
window_size1 = round(Fs*6*10^-3);  
per_cent = 0.5;
step_size = round(per_cent*window_size1);
W = hamming(window_size1);
no_samples=round(30*Fs/1000);
[S F T P] = spectrogram(X2_inp,hamming(window_size1),step_size,no_samples,Fs);
imagesc(T,F,20*log10(abs(P)));
set(gca,'YDir','normal')
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


%% Plot selected frame.
subplot 325;    
plot(x2,'k');
title('\bf(c)   Selected frame','fontname','Times New Roman','fontsize',11);
xlabel('Sample number','fontname','Times New Roman','fontsize',10);
ylabel('Amplitude','fontname','Times New Roman','fontsize',10);
axis on;
axis tight;

%% Vocal tract area function by MRI method.

if vw == 1
sect_no_a = [1 2 3 4  5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44];
a = [0.45 0.20 0.26 0.21 0.32 0.30 0.33 1.05 1.12 0.85 0.63 0.39 0.26 0.28 0.23 0.32 0.29 0.28 0.40 0.66 1.20 1.05 1.62 2.09 2.56 2.78 2.86 3.02 3.75 4.60 5.09 6.02 6.55 6.29 6.27 5.94 5.28 4.70 3.87 4.13 4.25 4.27 4.69 5.03];
subplot 322;
plot(sect_no_a,a,'k');
title('\bf (d)   Vocal tract area function by MRI method','fontname','Times New Roman','fontsize',11);
xlabel('Section number from glottis to lips','fontname','Times New Roman','fontsize',10);
ylabel('Area (cm^2)','fontname','Times New Roman','fontsize',10);
axis on;
axis tight;
elseif vw == 2
sect_no_i = [1 2 3 4  5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42];
i = [0.33 0.30 0.36 0.34 0.68 0.50 2.43 3.15 2.66 2.49 3.39 3.80 3.78 4.35 4.50 4.43 4.68 4.52 4.15 4.09 3.51 2.95 2.03 1.66 1.38 1.05 0.60 0.35 0.32 0.12 0.10 0.16 0.25 0.24 0.38 0.28 0.36 0.65 1.58 2.05 2.01 1.58];
subplot 322;
plot(sect_no_i,i,'k');
title('\bf (d)    Vocal tract area function by MRI method','fontname','Times New Roman','fontsize',11);
xlabel('Section number from glottis to lips','fontname','Times New Roman','fontsize',10);
ylabel('Area (cm^2)','fontname','Times New Roman','fontsize',10);
axis on;
axis tight;
else vw == 3
sect_no_u = [1 2 3 4  5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46];
u = [0.40 0.38 0.28 0.43 0.55 1.72 2.91 2.88 2.37 2.10 3.63 5.86 5.63 5.43 4.80 4.56 4.29 3.63 3.37 3.16 3.31 3.22 2.33 2.07 2.07 1.52 0.74 0.23 0.15 0.22 0.22 0.37 0.60 0.76 0.86 1.82 2.35 2.55 3.73 5.47 4.46 2.39 1.10 0.77 0.41 0.86 ];
subplot 322;  
plot(sect_no_u,u,'k');
title('\bf (d) Vocal tract area function by MRI method','fontname','Times New Roman','fontsize',11);
xlabel('Section number from glottis to lips','fontname','Times New Roman','fontsize',10);
ylabel('Area (cm^2)','fontname','Times New Roman','fontsize',10);
axis on;
axis tight;
end

%% Enter the first three formant values.

% F1 = 852.605066          %synthetic /a/
% F2 = 1167.521552 
% F3 = 3013.116255 

% F1 = 320.635505;      %synthetic /i/ 0.663000
% F2 = 1646.718531;
% F3 = 2501.100532;

F1 = 375.668436;    %synthetic /u/ 0.884000
F2 = 883.408387;
F3 = 2739.075626;   

%% Values of constants t1, t2 and n from table 1
t1 = [0.0000 0.1300 0.3500 0.5949 0.8817 1.0500 1.1640 1.1370 0.9540 0.5536 -0.1349 -0.8719 -1.2590 -1.4060 -1.3190 -0.9063];
t2 = [0.0000 0.6000 1.0500 1.1900 1.0940 0.9461 0.5893 0.0056 -0.4594 -0.9281 -1.2440 -1.4180 -1.3670 -1.2420 -0.9281 -0.4905];
n = [1.23 1.67 1.92 1.72 1.46 1.31 1.36 1.46 1.50 1.45 1.35 1.43 1.69 1.89 1.83 1.75];

%% Constants for equation (3), (4) and (5)
c1 = 2.309;
c2 = 2.105;
c3 = 0.117;
c4 = -2.446;
c5 = -1.913;
c6 = -0.245;
c7 = 0.188;
c8 = 0.584;
c9 = 0.3*10^-3;
c10 = -0.343*10^-6;
c11 = 4.143;
c12 = -2.865;

%% Compute front rising component and second rising component

w1 = c1*(F2/F3)+c2*(F1/F3)+c3*(F3/F1)+c4;
w2 = c5*(F1/F2)+c6*(F2/F1)+c7*(F3/F1)+c8;
sec_x(18) = c9*F2+c10*F2*F3+c11*(F1/F2)+c12;

%% Compute displacement of tongue point
for i = 1:1:16
  d(i) = t1(i)*w1 + t2(i)*w2;
  sec_x(i) = n(i) + d(i);
end

sec_x(17) = 0.5*(sec_x(16)+sec_x(18));

for i = 1:1:16
sec_X(i) = sec_x(i);
end
% sec_X(17) = sec_x(17);
% sec_X(18) = sec_x(18); 

%% Enter the section number 
% sect_no = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18];
sect_no = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16];

%% Display of results.
subplot 324;    
plot(sect_no,sec_X,'k');
title('\bf   (e) Vocal tract area function using formant frequencies','fontname','Times New Roman','fontsize',11);
xlabel('Section number from glottis to lips','fontname','Times New Roman','fontsize',10);
ylabel('Area (cm^2)','fontname','Times New Roman','fontsize',10);  
axis on;
axis tight;












