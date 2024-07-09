clear
clc

freq = 73.5e9;  
c = physconst('LightSpeed');
lam = c/freq;  % wavelenght
d_x = lam/2; % distance between elements in x-axis
d_y = lam/2; % distance between elements in y-axis
k = 2*pi/lam;  % same as Beta 

theta=linspace(-pi,pi,361*3);
phi=linspace(-pi,pi,361*3);
[THETA,PHI]=meshgrid(theta,phi);

alpha_x = pi/2;   % Phase shift between elements in x-axis
alpha_y = 0;   % Phase shift between elements in y-axis
M_x = 8;       % Number of elements in x-axis
N_y = 8;       % Number of elements in y-axis

AF_x = 0;      % Array Factor x-axis
AF_y = 0;      % Array Factor y-axis
phi_x = (k*d_x*sin(THETA).*cos(PHI))+alpha_x;  
phi_y = (k*d_y*sin(THETA).*sin(PHI))+alpha_y;

for m=1:M_x   % Loop to calculate AF_x
    A_m = 1;
    AF_x = AF_x + (A_m*exp(1j*(m-1)*phi_x)); 
end

for n=1:N_y  % Loop to calculate AF_y
    A_n = 1;
    AF_y = AF_y + (A_n*exp(1j*(n-1)*phi_y)); 
end

AF = AF_y.*AF_x;
AF_total = abs(AF_y.*AF_x); % Total value of Array Factor
AF_Ntot = abs((AF_y.*AF_x)/(N_y*M_x)); % Normalized value of Array Factor

% Plotting the array factor
surf(PHI,THETA,AF_Ntot)

%surf(PHI,THETA,AF_Ntot);
shading interp;
colormap('default');

xlabel('\phi[deg]','Fontsize',6);
xlim([-pi/2 pi/2])
set(gca,'XTickLabel',{'-90','-60','-30','0','30','60','90'},'Fontsize',10,'fontweight','bold','box','on');

ylabel('\Theta[deg]','Fontsize',6);
ylim([-pi/2 pi/2])
set(gca,'YTickLabel',{'-90','-60','-30','0','30','60','90'},'Fontsize',10,'fontweight','bold','box','on');

zlabel('Normalized abs(AF)',"FontSize",10)
