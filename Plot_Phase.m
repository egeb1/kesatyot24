% Eero Pietiläinen 27.6.2023
% Plots hologram amplitudes for phase 0,90, 180 and 270 negation 
% of the amplitudes. 90 and 270 phases are shifted to 0 and 180 phase with
% a correction term.

% read the data from the first file
[filename, pathname] = uigetfile('*.txt', 'Pick txt file','/Path/to/folder/Data/');
a1 = fullfile(pathname,filename);
filename = a1;
element_number = extractBetween(filename, "row", "active_phase");
element_number = str2double(element_number{1});

values_0 = readtable(filename,'NumHeaderLines',61, 'ExpectedNumVariables',4);
amp_0 = values_0.Amp;
phase_0 = table2array(values_0(:, 'Phase'));

% read the data from the second file
[filename2, pathname2] = uigetfile('*.txt', 'Pick txt file','/Path/to/folder/Data/');
a2 = fullfile(pathname2,filename2);
filename2 = a2;

values_90 = readtable(filename2,'NumHeaderLines',61, 'ExpectedNumVariables',4);
amp_90 = values_90.Amp;
phase_90 = table2array(values_90(:, 'Phase'));

% read the data from the third file
[filename3, pathname3] = uigetfile('*.txt', 'Pick txt file','/Path/to/folder/Data/');
filename3 = fullfile(pathname3,filename3);

values_180 = readtable(filename3,'NumHeaderLines',61, 'ExpectedNumVariables',4);
amp_180 = values_180.Amp;
phase_180 = table2array(values_180(:, 'Phase'));

% read the data from the fourth file
[filename4, pathname4] = uigetfile('*.txt', 'Pick txt file','/Path/to/folder/Data/');
filename4 = fullfile(pathname4,filename4);

values_270 = readtable(filename4,'NumHeaderLines',61, 'ExpectedNumVariables',4);
amp_270 = values_270.Amp;
phase_270 = table2array(values_270(:, 'Phase'));
amp_0_y0 = [amp_0(17689:17889)];
amp_90_y0 = [amp_90(17689:17889)];
amp_180_y0 = [amp_180(17689:17889)];
amp_270_y0 = [amp_270(17689:17889)];
phase_0_y0 = [phase_0(17689:17889)];
phase_90_y0 = [phase_90(17689:17889)];
phase_180_y0 = [phase_180(17689:17889)];
phase_270_y0 = [phase_270(17689:17889)];


x = linspace(-0.025,0.025,201);

amp_0_y0ndB = 10.^(amp_0_y0/20) .* exp(1i * phase_0_y0*pi/180);
amp_180_y0ndB = 10.^(amp_180_y0/20) .* exp(1i * phase_180_y0*pi/180);

amp_90_y0ndB = 10.^(amp_90_y0/20) .* exp(1i * (phase_90_y0*pi/180+pi/2));
amp_270_y0ndB = 10.^(amp_270_y0/20) .* exp(1i * (phase_270_y0*pi/180+pi/2));
amp_tot_y0 = 20 * log10(abs(amp_0_y0ndB+amp_270_y0ndB-amp_90_y0ndB - amp_180_y0ndB));

figure(1)
plot(x, amp_0_y0, 'b');
hold on
plot(x, amp_90_y0);
plot(x, amp_180_y0, 'r');
plot(x, amp_270_y0);
plot(x, amp_tot_y0, 'g');
xlabel('x(m)')
ylabel('Amplitude(dB)')
legend('Phase 0', 'Phase 90', 'Phase 180', 'Phase 270', 'Difference of Amplitudes', 'Location', 'best');
title(['Element ', num2str(element_number), ' amplitudes at phases 0 and 180']);
subtitle('Hologram measurement at 75GHz July 2023')
max(amp_tot_y0)
hold off



figure(2)
phase_tot = phase_0 + phase_270 - phase_90 - phase_180; % Phase difference in degrees
phase_tot = reshape(phase_tot, [201, 201]);
k = linspace(-0.025, 0.025, 201);
imagesc(k, k, transpose(phase_tot));

% setting for image
colorbar
colormap('jet')
ax = gca;
ax.YDir = 'normal';
xlabel('x(m)')
ylabel('y(m)')
title(['Element ', num2str(element_number), ' phase difference at phases 0, 90, 180, 270']);
subtitle('Hologram measurement at 75GHz July 2023')
