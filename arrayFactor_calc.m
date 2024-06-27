% Eero Pietiläinen 29.6.2023 
% Calculates array factor for a antenna array
clear
clc

freq = 73.5e9;  
c = physconst('LightSpeed');
lam = c/freq;  % wavelenght
d_x = lam/2;   % distance between elements in x-axis
d_y = lam/2;   % distance between elements in y-axis
k = 2*pi/lam;  % same as Beta 

THETA = 90; % elevation
PHI = 0;    % azimuth


tilt_el =pi/2;   % Phase shift between elements in x-axis
tilt_az = 0;     % Phase shift between elements in y-axis
M_x = 8;         % Number of elements in x-axis
N_y = 8;         % Number of elements in y-axis

AF_x = 0;      % Array Factor x-axis
AF_y = 0;      % Array Factor y-axis
phi_x = (k*d_x*sin(THETA).*cos(PHI))+tilt_el;  
phi_y = (k*d_y*sin(THETA).*sin(PHI))+tilt_az;

for m=1:M_x   % Loop to calculate AF_x
    A_m = 1;
    AF_x = AF_x + (A_m*exp(1j*(m-1)*phi_x)); 
end

for n=1:N_y  % Loop to calculate AF_y
    A_n = 1;
    AF_y = AF_y + (A_n*exp(1j*(n-1)*phi_y)); 
end

AF = AF_y.*AF_x;
AF_normalized = abs((AF_y.*AF_x)/(N_y*M_x)); % Normalized value of Array Factor

AF_total = abs(AF_y.*AF_x) % Total value of Array Factor
AF_dB = 20*log10(AF_total) % Array factor in desibels