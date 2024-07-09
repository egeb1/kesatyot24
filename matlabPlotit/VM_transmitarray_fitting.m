% This function calculates the amplitude and phase matrices for the 
% Transmitarray antenna. The function saves a text file of the DAC values
% of the vector modulators for the different beams. One row is one beam
% (128 DAC values). The beams from text file are manually copy-pasted into Arduino
% code "dac_bist_ctr_lux_8x8_mux_v3_0" into "tx_ar_vector[beam_count][brd_count][vm_count][dac_count]= {...} (on lines >358). 
% After compiling the code, beam is changed in Arduino command line as "WRTTXMZ 00N 144 000 000", where N is the beam number starting from zero. 
% For example "WRTTXMZ 003 144 000 000" is for beam "3". 

clear;
% frequency
f = 71.5e9;
c = 3e8;
lambda0 = c/f;
% element spacing for vivaldi version
d = 2.5e-3;
% element spacing for dipole version
%d = 2.2e-3;
%d/lambda0;

% 8x8-transmitarray-ryhmän amplitudit ja vaiheet, 75 mm etäisyys
% load simulated amplitude and phase data (include correct path)
load 'amp_75mm_all'
load 'ph_75mm_all'

% amplitudi (ensimmäinen täysi ympyrä A=-6)
% 64-el array amplitudit (-6 dB is maximum)
% Pre-compensation of amplitude
% vivaldi
A = (zeros(8,8)) - 4.2602 - (amp_75mm_all - min(min(amp_75mm_all)));
% dipole
%A = (zeros(8,8)) - 6+1.2447 - (amp_75mm_all - min(min(amp_75mm_all)))
% Min amplitudes
%A = (zeros(8,8)) - 50;
% All min except one
%A(1,1) = -6

% Dolph-Chebyschev -20 dB, Henna Paaso 21.11.19
%A = 20*log10([0.34 0.38 0.51 0.58 0.58 0.51 0.38 0.34; ...
%    0.38 0.44 0.58 0.66 0.66 0.58 0.44 0.38; ...
%    0.51 0.58 0.77 0.88 0.88 0.77 0.58 0.51; ...
%    0.58 0.66 0.88 1 1 0.88 0.66 0.58; ...
%    0.58 0.66 0.88 1 1 0.88 0.66 0.58; ...
%    0.51 0.58 0.77 0.88 0.88 0.77 0.58 0.51; ...
%    0.38 0.44 0.58 0.66 0.66 0.58 0.44 0.38; ...
%    0.34 0.38 0.51 0.58 0.58 0.51 0.38 0.34]) - 4.2602 - (amp_75mm_all - min(min(amp_75mm_all)));

% Dolph-Chebyschev -30 dB, Henna Paaso 18.1.23
%A = 20*log10([.07 .14 .21 .26 .26 .21 .14 .07; ...
%    .14 .27 .42 .52 .52 .42 .27 .14; ...
%    .21 .42 .66 .81 .81 .66 .42 .21; ...
%    .26 .52 .81 1 1 .81 .52 .26; ...
%    .26 .52 .81 1 1 .81 .52 .26; ...
%    .21 .42 .66 .81 .81 .66 .42 .21; ...
%    .14 .27 .42 .52 .52 .42 .27 .14; ...
%    .07 .14 .21 .26 .26 .21 .14 .07]) - 4.2602 - (amp_75mm_all - min(min(amp_75mm_all)));


% Beam steering angles
% tilt angle in azimuth (deg.)
tiltaz = 0;
% tilt angle in elevation (deg.)
tiltel = 0;

% File name for the beam text file
fid = fopen('Transmitarray_beams1.txt','w');

ind = -1;
%ind = 288;
% Elevation angles, for example -30 to 30 in 10 steps
for tiltel = -0:1:0
    % Azimuth angles, for example -30 to 30 in 10 steps
    for tiltaz = -30:10:30
        ind = ind+1;
% Vaihe-ero suunnan mukaan
PROGPHASE = ones(8,8);
% Progressive phase shift in azimuth
dPHaz = 360*d*sin(tiltaz/180*pi)/lambda0;
% Progressive phase shift in elevation
dPHel = 360*d*sin(tiltel/180*pi)/lambda0;

% Progressive phase matrix
for m = 1:length(PROGPHASE(1,:))
    for n = 1:length(PROGPHASE(:,1))
        PROGPHASE(n,m) = dPHaz*(m-1) + dPHel*(n-1); 
    end
end

% Final phase matrix of the transmitarray including compensation (in radians)
TH = (-ph_75mm_all + PROGPHASE) * pi/180;

Z = [];
DAC0 = [];
DAC1 = [];
DAC = [];


% These equations calculate the DAC values for the beams (DAC0 & DAC1)
%DAC0:
vect0=10.^(0.05*A).*sin(TH);
DAC0=round(-161.1305*vect0.^4 - 21.2639*vect0.^3 + 113.6065*vect0.^2 + 158.4475*vect0 + 137.2079);
%DAC1:
vect1=10.^(0.05*A).*cos(TH);
DAC1=round(-231.5952*vect1.^4 - 34.9143*vect1.^3 + 142.3675*vect1.^2 + 166.9358*vect1 + 133.5731);

Z = [vect0 + j*vect1];


% Transmitarray DAC matrix
DAC = string(zeros(8,8));
for m = 1:8
    for n = 1:8
         %DAC(n,m) = sprintf('%03d %03d', DAC0(n,m), DAC1(n,m));
         DAC(n,m) = sprintf('%01d,%01d', DAC0(n,m), DAC1(n,m));
    end
end

% off-state DAC
%DACoff = sprintf('%03d %03d', 128, 128);

DAC0;
DAC1;
DAC;
max(max(DAC0));

max(max(DAC1));

min(min(DAC0));
min(min(DAC1));

% print channels, 8 VMs x 8 boards
%  12345678
% 1--------
% 2--------
% 3--------
% 4--------
% 5--------
% 6--------
% 7--------
% 8--------

% DAC vector
DACv = reshape(DAC',[1 64]);

TXCODE = sprintf('%s,', DACv);

fprintf(fid, TXCODE);
fprintf(fid,'\n');

    end
end
fclose(fid);

% Show amplitude (A) [dB], phase (TH) [rad] and DAC matrices
A;
TH;
DAC;

