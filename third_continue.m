clc
clear all;
close all;
d0=input('enter the reference distance:');
d=1000:1000:20000;
n= [2.2 1.8 3.0 2.4 2.6 2.0 2.1 1.8 1.6 3.0 2.1 3.3];
f= [914 914 1500 900 1900 1300 4000 1300 1300 900 4000 1300];
X= 0;
for i=1:12
lambda(i)=3e8/(f(i)*10^6);
PL_d0(i)=-10*log10((lambda(i)^2)/((4*pi*d0)^2))+X;
end
disp('PL_d0->d(dB)=');
for i=1:12
for j=1:20
PL(i,j)= PL_d0(i)+10*n(i)*log10(d(j)/d0);
end
disp(PL(i));
end
 

%DISTANCE VS PATH LOSS
 
plot (d, PL);
legend ('retail store', 'grocery store', 'office hard partition', 'office soft partition', 'office soft partition', 'textile / chemical', 'textile / chemical', 'paper / cereals', 'metalworking', 'indoor street', 'textile / chemical', 'metalworking');
xlabel ('distance in m');
ylabel ('path loss in dB');
title ('LOG-DISTANCE PATH LOSS INDOOR PROPAGATION MODEL (NO SHADOWING EFFECT');
grid on;
