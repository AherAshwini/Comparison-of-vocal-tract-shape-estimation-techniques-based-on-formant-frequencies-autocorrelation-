%% Read speech signal
clc
close all
clear all


%% Enter the first three formant values.

F1 = 852.605066          %synthetic /a/
F2 = 1167.521552 
F3 = 3013.116255 

% F1 = 320.635505;      %synthetic /i/ 0.663000
% F2 = 1646.718531;
% F3 = 2501.100532;

% F1 = 375.668436;    %synthetic /u/ 0.884000
% F2 = 883.408387;
% F3 = 2739.075626;   

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
sec_X(17) = sec_x(17);
sec_X(18) = sec_x(18); 

%% Enter the section number 
sect_no = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18];
% sect_no = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16];

%% Display of results.  
plot(sect_no,sec_X,'k');
title('\bf   (e) Vocal tract area function using formant frequencies','fontname','Times New Roman','fontsize',11);
xlabel('Section number from glottis to lips','fontname','Times New Roman','fontsize',10);
ylabel('Area (cm^2)','fontname','Times New Roman','fontsize',10);  
axis on;
axis tight;












