clc
close all
clear all

% vw = 1;     % a = 1; i = 2; u = 3.

% if vw == 1
% Area values of 44 sections for vowel /a/.
sect_no_a = [1 2 3 4  5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44];
a = [0.45 0.20 0.26 0.21 0.32 0.30 0.33 1.05 1.12 0.85 0.63 0.39 0.26 0.28 0.23 0.32 0.29 0.28 0.40 0.66 1.20 1.05 1.62 2.09 2.56 2.78 2.86 3.02 3.75 4.60 5.09 6.02 6.55 6.29 6.27 5.94 5.28 4.70 3.87 4.13 4.25 4.27 4.69 5.03];
subplot 321;
plot(sect_no_a,a,'k');
title('\bf Vocal tract area function by MRI method','fontname','Times New Roman','fontsize',11);
xlabel('Section number from glottis to lips','fontname','Times New Roman','fontsize',10);
ylabel('Area (cm^2)','fontname','Times New Roman','fontsize',10);
axis on;
axis tight;
% elseif vw == 2
% Area values of 44 sections for vowel /i/.
sect_no_i = [1 2 3 4  5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42];
i = [0.33 0.30 0.36 0.34 0.68 0.50 2.43 3.15 2.66 2.49 3.39 3.80 3.78 4.35 4.50 4.43 4.68 4.52 4.15 4.09 3.51 2.95 2.03 1.66 1.38 1.05 0.60 0.35 0.32 0.12 0.10 0.16 0.25 0.24 0.38 0.28 0.36 0.65 1.58 2.05 2.01 1.58];
subplot 322;
plot(sect_no_i,i,'k');
title('\bf Vocal tract area function by MRI method','fontname','Times New Roman','fontsize',11);
xlabel('Section number from glottis to lips','fontname','Times New Roman','fontsize',10);
ylabel('Area (cm^2)','fontname','Times New Roman','fontsize',10);
axis on;
axis tight;
% else vw == 3
% Area values of 44 sections for vowel /u/. 
sect_no_u = [1 2 3 4  5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46];
u = [0.40 0.38 0.28 0.43 0.55 1.72 2.91 2.88 2.37 2.10 3.63 5.86 5.63 5.43 4.80 4.56 4.29 3.63 3.37 3.16 3.31 3.22 2.33 2.07 2.07 1.52 0.74 0.23 0.15 0.22 0.22 0.37 0.60 0.76 0.86 1.82 2.35 2.55 3.73 5.47 4.46 2.39 1.10 0.77 0.41 0.86 ];
subplot 323;  
plot(sect_no_u,u,'k');
title('\bf Vocal tract area function by MRI method','fontname','Times New Roman','fontsize',11);
xlabel('Section number from glottis to lips','fontname','Times New Roman','fontsize',10);
ylabel('Area (cm^2)','fontname','Times New Roman','fontsize',10);
axis on;
axis tight;
% end



