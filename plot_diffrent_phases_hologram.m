% Eero Pietiläinen 27.6.2023
% Plots hologram amplitudes for phase 0 and phase 180 and negation 
% of the two amplitudes

clear all

% choose first file 
[filename, pathname] = uigetfile('*.txt', 'Pick txt file','/Path/to/folder/Data/');
a1 = fullfile(pathname,filename);
filename = a1;

%take element number as a constant
element_number = extractBetween(filename, "row", "active_phase");
element_number = str2double(element_number{1});



% read the data from the first file
values_0 = readtable(filename,'NumHeaderLines',61, 'ExpectedNumVariables',4);
amp_0 = values_0.Amp;
phase_0 =values_0.Phase;

% choose the second file
[filename2, pathname2] = uigetfile('*.txt', 'Pick txt file','/Path/to/folder/Data/');
a2 = fullfile(pathname2,filename2);
filename2 = a2;

% read the data from the second file
values_180 = readtable(filename2,'NumHeaderLines',61, 'ExpectedNumVariables',4);
amp_180 = values_180.Amp;
phase_180 =values_180.Phase;

% Take the bit of data, where y is zero
amp_0_y0 = [amp_0(17890:18090)];
amp_180_y0 = [amp_180(17890:18090)];
phase_0_y0 = [phase_0(17890:18090)];
phase_180_y0 = [phase_180(17890:18090)];

x = linspace(-0.025,0.025,201);



% Diffrence of amplitudes

% moving away from dB 
amp_0_y0ndB = 10.^(amp_0_y0/20).*exp(1i*phase_0_y0 *pi/180);
amp_180_y0ndB = 10.^(amp_180_y0/20).*exp(1i*phase_180_y0 *pi/180);

% magnitude of the negation moved back to dB
amp_tot_y0 = 20 * log10(abs(amp_0_y0ndB - amp_180_y0ndB));

amp_max = max(amp_tot_y0)
% Plot images
figure(1)
plot(x,amp_0_y0,'b');
hold on
plot(x,amp_180_y0, 'r');
plot(x,amp_tot_y0, 'g');
max(amp_tot_y0)
xlabel('x(m)')
ylabel('Amplitude(dB)')
clim([-90, -10])
legend('Phase 0', 'Phase 180', 'Diff. of Ampl.', 'Location', 'best');
title(['Element ', num2str(element_number), ' amplitudes at phases 0 and 180']);
subtitle('Hologram measurement, 75GHz, July 2023, y=-0.00275m, 10x10')
hold off

saveas(gcf,fullfile('VTT_transarray_matlab_pictures', ['Element_', num2str(element_number), '_Holo_amplitudes_0vs180_chess_heinakuu_10x10.jpg']));

figure(2)

amp_0_ndB = 10.^(amp_0/20).*exp(1i*phase_0*pi/180);
amp_180_ndB = 10.^(amp_180/20).*exp(1i*phase_180*pi/180);

% magnitude of the negation moved back to dB
amp_tot_y0 = 20 * log10(abs(amp_0_ndB - amp_180_ndB));
amp_tot_y0 = (reshape(amp_tot_y0,[201,201]));
k= linspace(-0.025,0.025,201);
% plot 2d image of total amplitude
max(max(amp_tot_y0))
imagesc(k,k,transpose(amp_tot_y0));

% setting for image
colorbar
colormap('jet')
ax = gca;
ax.YDir = 'normal';
clim([-55,-10])
xlabel('x(m)')
ylabel('y(m)')
title(['Element ', num2str(element_number), ' amplitude difference at phases 0 and 180']);
subtitle('Hologram measurement at 75GHz July 2023, 20x20')

%saveas(gcf, fullfile('VTT_transarray_matlab_pictures', ['Element_', num2str(element_number), '_Hologram_amplitudes_0vs180_dif_2D_chessboard_heinakuu_20x20.jpg']));


figure(3)

amp_0_holo = (reshape(amp_0,[201,201]));
k= linspace(-0.025,0.025,201);
imagesc(k,k,transpose(amp_0_holo));

colorbar
colormap('jet')
ax = gca;
ax.YDir = 'normal';
clim([-45,-10])
xlabel('x(m)')
ylabel('y(m)')
title(['Element ', num2str(element_number), ' amplitude at phases 0']);
subtitle('Hologram measurement at 75GHz July 2023, 20x20')

%saveas(gcf, fullfile('VTT_transarray_matlab_pictures', ['Element_', num2str(element_number), '_Hologram_amplitude_phase0_2D_chessboard_heinakuu_20x20.jpg']));

figure(4)

amp_180_holo = (reshape(amp_180,[201,201]));
imagesc(k,k,transpose(amp_180_holo));

colorbar
colormap('jet')
ax = gca;
ax.YDir = 'normal';
clim([-45,-10])
xlabel('x(m)')
ylabel('y(m)')
title(['Element ', num2str(element_number), ' amplitude at phases 180']);
subtitle('Hologram measurement at 75GHz July 2023, 20x20')

%saveas(gcf, fullfile('VTT_transarray_matlab_pictures', ['Element_', num2str(element_number), '_Hologram_amplitude_phase180_2D_chessboard_heinakuu_20x20.jpg']));