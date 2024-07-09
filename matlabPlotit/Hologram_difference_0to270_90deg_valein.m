% Eero Pietiläinen 27.6.2023
% Plots hologram amplitudes for phase 0,90, 180 and 270 negation 
% of the amplitudes. 90 and 270 phases are shifted to 0 and 180 phase with
% a correction term.

clear all

% choose first file 
[filename, pathname] = uigetfile('*.txt', 'Pick txt file','/Path/to/folder/Data/');
a1 = fullfile(pathname,filename);
filename = a1;

%take element number as a constant
%element_number = extractBetween(filename, "row", "active_phase");
%element_number = str2double(element_number{1});



% read the data from the first file
values_0 = readtable(filename,'NumHeaderLines',61, 'ExpectedNumVariables',4);
amp_0 = values_0.Amp;
phase_0 =values_0.Phase;

% choose the second file
[filename2, pathname2] = uigetfile('*.txt', 'Pick txt file','/Path/to/folder/Data/');
filename2 = fullfile(pathname2,filename2);


% read the data from the second file
values_90 = readtable(filename2,'NumHeaderLines',61, 'ExpectedNumVariables',4);
amp_90 = values_90.Amp;
phase_90 =values_90.Phase;




% choose first file 
[filename3, pathname3] = uigetfile('*.txt', 'Pick txt file','/Path/to/folder/Data/');
filename3 = fullfile(pathname3,filename3);


% read the data from the first file
values_180 = readtable(filename3,'NumHeaderLines',61, 'ExpectedNumVariables',4);
amp_180 = values_180.Amp;
phase_180 =values_180.Phase;

% choose the second file
[filename4, pathname4] = uigetfile('*.txt', 'Pick txt file','/Path/to/folder/Data/');
filename4 = fullfile(pathname4,filename4);

% read the data from the second file
values_270 = readtable(filename4,'NumHeaderLines',61, 'ExpectedNumVariables',4);
amp_270 = values_270.Amp;
phase_270 =values_270.Phase;



% Take the bit of data, where y is zero
amp_0_y0 = [amp_0(20101:20301)];
amp_90_y0 = [amp_90(20101:20301)];
amp_180_y0 = [amp_180(20101:20301)];
amp_270_y0 = [amp_270(20101:20301)];
phase_0_y0 = [phase_0(20101:20301)];
phase_90_y0 = [phase_90(20101:20301)];
phase_180_y0 = [phase_180(20101:20301)];
phase_270_y0 = [phase_270(20101:20301)];

x = linspace(-0.025,0.025,201);



% Diffrence of amplitudes

% moving away from dB 
amp_0_y0ndB = 10.^(amp_0_y0/20).*exp(1i*phase_0_y0 *pi/180);
amp_180_y0ndB = 10.^(amp_180_y0/20).*exp(1i*phase_180_y0 *pi/180);

amp_90_y0ndB = 10.^(amp_90_y0/20).*exp(1i*(phase_90_y0 *pi/180+pi/2));
amp_270_y0ndB = 10.^(amp_270_y0/20).*exp(1i*(phase_270_y0 *pi/180+pi/2));
% magnitude of the negation moved back to dB
amp_tot_y0 = 20 * log10(abs(amp_0_y0ndB+amp_270_y0ndB-amp_90_y0ndB - amp_180_y0ndB));


% Plot images
figure(1)
plot(x,amp_0_y0,'b');
hold on
plot(x,amp_90_y0 );
plot(x,amp_180_y0, 'r');
plot(x,amp_270_y0);
plot(x,amp_tot_y0, 'g');
xlabel('x(m)')
ylabel('Amplitude(dB)')
legend('Phase 0','Phase 90', 'Phase 180','Phase 270', 'Difference of Amplitudes', 'Location', 'best');
%title(['Element ', num2str(element_number), ' amplitudes at phases 0 and 180']);
subtitle('Hologram measurement at 75GHz July 2023')
%max(amp_tot_y0)
hold off

%saveas(gcf,fullfile('VTT_transarray_matlab_pictures', ['Element_', num2str(element_number), '_Hologram_amplitudes_0_vs_180_chessboard_heinakuu_10x10.jpg']));

figure(2)

amp_0_ndB = 10.^(amp_0/20).*exp(1i*phase_0*pi/180);
amp_180_ndB = 10.^(amp_180/20).*exp(1i*phase_180*pi/180);

amp_90_ndB = 10.^(amp_90/20).*exp(1i*(phase_90*pi/180+pi/2));
amp_270_ndB = 10.^(amp_270/20).*exp(1i*(phase_270*pi/180+pi/2));
% magnitude of the negation moved back to dB
amp_tot_y0 = 20 * log10(abs(amp_0_ndB+amp_270_ndB-amp_90_ndB - amp_180_ndB));
amp_tot_y0 = (reshape(amp_tot_y0,[201,201]));
k= linspace(-0.025,0.025,201);
% plot 2d image of total amplitude
imagesc(k,k,transpose(amp_tot_y0));
%max(max(amp_tot_y0))
% setting for image
colorbar
colormap('jet')
ax = gca;
ax.YDir = 'normal';
clim([-40,-5])
xlabel('x(m)')
ylabel('y(m)')
%title(['Element ', num2str(element_number), ' amplitude difference at phases 0, 90, 180, 270']);
subtitle('Hologram measurement at 75GHz, mask, July 2023')

%saveas(gcf, fullfile('VTT_transarray_matlab_pictures', ['Element_', num2str(element_number), '_Hologram_amplitudes_0vs180_dif_2D_chessboard_heinakuu_10x10_maski.jpg']));


figure(3)

amp_0_holo = (reshape(amp_0,[201,201]))/(16.1740);
k= linspace(-0.025,0.025,201);
imagesc(k,k,transpose(amp_0_holo));

colorbar
colormap('jet')
ax = gca;
ax.YDir = 'normal';
clim([-5,-1])
xlabel('x(m)')
ylabel('y(m)')
maximi0 = max(amp_0)
%title(['Element ', num2str(element_number), ' amplitude at phases 0']);
subtitle('Hologram measurement at 75GHz, mask, July 2023')

%saveas(gcf, fullfile('VTT_transarray_matlab_pictures', ['Element_', num2str(element_number), '_Hologram_amplitude_phase0_2D_chessboard_heinakuu_10x10_maski_norm.jpg']));


figure(4)

amp_90_holo = (reshape(amp_90,[201,201]))/14.6560;
k= linspace(-0.025,0.025,201);
imagesc(k,k,transpose(amp_90_holo));

colorbar
colormap('jet')
ax = gca;
ax.YDir = 'normal';
clim([-5,-1])
xlabel('x(m)')
ylabel('y(m)')
maximi90 =max(amp_90)
%title(['Element ', num2str(element_number), ' amplitude at phases 90']);
subtitle('Hologram measurement at 75GHz, mask, July 2023')

%saveas(gcf, fullfile('VTT_transarray_matlab_pictures', ['Element_', num2str(element_number), '_Hologram_amplitude_phase90_2D_chessboard_heinakuu_10x10_maski_norm.jpg']));


figure(5)

amp_180_holo = (reshape(amp_180,[201,201]))/19.9690;
imagesc(k,k,transpose(amp_180_holo));

colorbar
colormap('jet')
ax = gca;
ax.YDir = 'normal';
clim([-5,-1])
xlabel('x(m)')
ylabel('y(m)')
maximi180 =max(amp_180)
%title(['Element ', num2str(element_number), ' amplitude at phases 180']);
subtitle('Hologram measurement at 75GHz, mask, July 2023')

%saveas(gcf, fullfile('VTT_transarray_matlab_pictures', ['Element_', num2str(element_number), '_Hologram_amplitude_phase180_2D_chessboard_heinakuu_10x10_maski_norm.jpg']));


figure(6)

amp_270_holo = (reshape(amp_270,[201,201]))/21.5280;
k= linspace(-0.025,0.025,201);
imagesc(k,k,transpose(amp_270_holo));

colorbar
colormap('jet')
ax = gca;
ax.YDir = 'normal';
clim([-5,-1])
xlabel('x(m)')
ylabel('y(m)')
maximi270 = max(amp_270)
%title(['Element ', num2str(element_number), ' amplitude at phases 270']);
subtitle('Hologram measurement at 75GHz, mask, July 2023')

%saveas(gcf, fullfile('VTT_transarray_matlab_pictures', ['Element_', num2str(element_number), '_Hologram_amplitude_phase270_2D_chessboard_heinakuu_10x10_maski_norm.jpg']));


