%% Read speech signal
clc
close all
clear all


[X,Fs] = wavread('C:\Users\HRISHI\desktop\sound_files\synthesized sounds\i'); 
sound(X,Fs);

%% Define window size, step size
window_size = round(Fs*5*10^-3); 
if window_size == round(Fs*5*10^-3); 
    posi_tion = 0
elseif window_size == round(Fs*7*10^-3);
    posi_tion = 1
elseif window_size == round(Fs*20*10^-3);
    posi_tion = 2
else posi_tion = 3
end
per_cent = 0.5;
step_size = round(window_size*per_cent);
W = hamming(window_size);


len1 = length(X);
for q = 1:1:len1-1
X1(q) = X(q+1)-X(q); 
end
len2 = length(X1);
X2_inp = X1(1:len2);
X2_inp1 = X2_inp(5000:12000);
len4 = length(X2_inp1);
LPC_order = 12; 

%% Autocorrelation Method

b = 1;
j = 1;
while b < len4-window_size-step_size
x2_acr = X2_inp1(b:b+window_size-1);
    xw = x2_acr.*W'; 
    xc = xcorr(xw,LPC_order);  
    R1 = ac2rc(xc(LPC_order+1:2*LPC_order+1));  
for m = LPC_order
    sA(m) = 1;
end
for m = LPC_order-1:-1:1
    sA(m) = ((1+R1(m))/(1-R1(m)))*sA(m+1);  
    sA1 = sA';
end
SA1(j,1:LPC_order) = sA1(:,1);
b = b+step_size;
j = j+1; 
end



subplot 321;    % Display results for autocorrelation method.
waterfall(1:LPC_order,1:j-1,fliplr(SA1));
view(-40,55);
axis tight;
colormap(gray);
caxis([-10  40]);
axis on;
title('(a)  3 Dimensional figure of VTAF by autocorrelation method','fontname','Times New Roman','fontsize',11,'fontweight','b');
xlabel('Number of sections from glottis to lips  ->','fontname','Times New Roman','fontsize',10,'fontangle','normal');
if    posi_tion == 0     %window_size 5ms
    set(get(gca,'XLabel'),'rotation',11,'position',[1.8 -18 -6.5]);
elseif posi_tion == 1    %window_size 7ms
   set(get(gca,'XLabel'),'rotation',11,'position',[1.5 -20 -6.5]); 
else
    set(get(gca,'XLabel'),'rotation',11,'position',[2 -5 -6.5]); 
end
ylabel('<-  Number of frames','fontname','Times New Roman','fontsize',10,'fontangle','normal');
set(get(gca,'YLabel'),'rotation',-14,'position',[-1.3 5 -1]);
zlabel('Normalized area  ->','fontname','Times New Roman','fontsize',10);



%% Covariance method

q = 20;
p = 1;
while q < len4-window_size-step_size
    x2_cov = X2_inp1(q-LPC_order:q+window_size-1);
  
    cv_lpc = arcov(x2_cov,LPC_order);
    R3 = poly2rc(cv_lpc);   
    
for m = LPC_order                  
    sC(m) = 1;
end
for m = LPC_order-1:-1:1
    sC(m) = ((1+R3(m))/(1-R3(m)))*sC(m+1);
end
sC1 = sC';
SC1(p,1:LPC_order) = sC1(:,1);
 p = p+1; 
q = q+step_size;
end

subplot 323;    % Display results for covariance method.
waterfall(1:LPC_order,1:p-1,fliplr(SC1));
view(-40,55);
colormap(gray);
caxis([-10  40]);
axis tight;
axis on;
title('(b)  3 Dimensional figure of VTAF by covariance method','fontname','Times New Roman','fontsize',11,'fontweight','b');

xlabel('Number of sections from glottis to lips  ->','fontname','Times New Roman','fontsize',10,'fontangle','normal');
if posi_tion == 0   %window_size 5ms
    set(get(gca,'XLabel'),'rotation',11,'position',[-1 -100 -80]);
elseif posi_tion == 1   %window_size 7ms
    set(get(gca,'XLabel'),'rotation',11,'position',[-1.8 -85 -50]);
elseif posi_tion == 2   %window_size 20ms
    set(get(gca,'XLabel'),'rotation',11,'position',[1 -6 -4]);
else set(get(gca,'XLabel'),'rotation',11,'position',[1.3 -15 -6]);  %For other windows
end
    
ylabel('<-  Number of frames','fontname','Times New Roman','fontsize',10,'fontangle','normal');
if posi_tion == 0   %window_size 5ms
    set(get(gca,'YLabel'),'rotation',-14,'position',[-3.5 -38 -6]);
elseif posi_tion == 1 %window_size 7ms
   set(get(gca,'YLabel'),'rotation',-14,'position',[-3.5 -38 -6]); 
else 
    set(get(gca,'YLabel'),'rotation',-14,'position',[-1.1 7 -6]);   %For other windows
end

zlabel('Normalized area  ->','fontname','Times New Roman','fontsize',10);


%% Lattice method

k = 1;
l = 1;
while k < len4-window_size-step_size
    x2_ltc = X2_inp1(k:k+window_size-1);
    [ar_coeffs,N_V,R3] = arburg(x2_ltc,LPC_order);   % Compute reflection coefficients
    
for m = LPC_order                   % Compute area value
    sL(m) = 1;
end
for m = LPC_order-1:-1:1
    sL(m) = ((1+R3(m))/(1-R3(m)))*sL(m+1);
end
sL1 = sL';
SL1(l,1:LPC_order) = sL1(:,1);
l = l+1; 
k = k+step_size;
end

subplot 325;    % Display results for lattice method.
waterfall(1:LPC_order,1:l-1,fliplr(SL1));
view(-40,55);
colormap(gray);
caxis([-10  40]);
axis tight;
axis on;
title('(c)  3 Dimensional figure of VTAF by lattice method','fontname','Times New Roman','fontsize',11,'fontweight','b');

xlabel('Number of sections from glottis to lips  ->','fontname','Times New Roman','fontsize',10,'fontangle','normal');
if posi_tion == 0   %window_size 5ms
    set(get(gca,'XLabel'),'rotation',11,'position',[1.8 -28 -6.5]);
elseif posi_tion == 1    %window_size 7ms
    set(get(gca,'XLabel'),'rotation',11,'position',[1.8 -24 -4]);
else
    set(get(gca,'XLabel'),'rotation',11,'position',[2 -6 -4]);
end
ylabel('<-  Number of frames','fontname','Times New Roman','fontsize',10,'fontangle','normal');
set(get(gca,'YLabel'),'rotation',-14,'position',[-1.3 5]);
zlabel('Normalized area  ->','fontname','Times New Roman','fontsize',10);






