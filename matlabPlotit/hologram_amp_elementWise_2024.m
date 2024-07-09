% Eero Pietiläinen 8.7.2024
% Plots hologram amplitudes of all elements
% other elements effect negated by negating all elements off data 
% from elements hologram data.

clear all

% choose first file 
[filename, pathname] = uigetfile('*.txt', 'Pick txt file','/Path/to/folder/Data/');
a1 = fullfile(pathname,filename);
filename = a1;

%take element number as a constant
element_number1 = extractBetween(filename, "transarray_element", "_ON_");
element_number1 = str2double(element_number1{1});

% get the used frequency from file name
freq_GHz =69.5 + (str2double(extractBetween(filename, "2024_8dBm_newSetup_9dB_addAtten_70to80_beam", ".txt"))*0.5);

% read the data from the first file
values_1 = readtable(filename,'NumHeaderLines',61, 'ExpectedNumVariables',4);
amp_1 = values_1.Amp;
phase_1 =values_1.Phase;

% choose the second file
[filename2, pathname2] = uigetfile('*.txt', 'Pick txt file','/Path/to/folder/Data/');
filename2 = fullfile(pathname2,filename2);

element_number2 = extractBetween(filename2, "transarray_element", "_ON_");
element_number2 = str2double(element_number2{1});


% read the data from the second file
values_2 = readtable(filename2,'NumHeaderLines',61, 'ExpectedNumVariables',4);
amp_2 = values_2.Amp;
phase_2 =values_2.Phase;




% choose first file 
[filename3, pathname3] = uigetfile('*.txt', 'Pick txt file','/Path/to/folder/Data/');
filename3 = fullfile(pathname3,filename3);

element_number3 = extractBetween(filename3, "transarray_element", "_ON_");
element_number3 = str2double(element_number3{1});

% read the data from the first file
values_3 = readtable(filename3,'NumHeaderLines',61, 'ExpectedNumVariables',4);
amp_3 = values_3.Amp;
phase_3 =values_3.Phase;

% choose the second file
[filename4, pathname4] = uigetfile('*.txt', 'Pick txt file','/Path/to/folder/Data/');
filename4 = fullfile(pathname4,filename4);

element_number4 = extractBetween(filename4, "transarray_element", "_ON_");
element_number4 = str2double(element_number4);

% read the data from the second file
values_4 = readtable(filename4,'NumHeaderLines',61, 'ExpectedNumVariables',4);
amp_4 = values_4.Amp;
phase_4 =values_4.Phase;


[filename5, pathname5] = uigetfile('*.txt', 'Pick txt file','/Path/to/folder/Data/');
filename5 = fullfile(pathname5,filename5);

% read the data from the second file
values_5 = readtable(filename5,'NumHeaderLines',61, 'ExpectedNumVariables',4);
amp_5 = values_5.Amp;
phase_5 =values_5.Phase;
% 
% 
% 
% 
% % Take the bit of data, where y is zero
% amp_1_y0 = [amp_1(20101:20301)];
% amp_2_y0 = [amp_2(20101:20301)];
% amp_3_y0 = [amp_3(20101:20301)];
% amp_4_y0 = [amp_4(20101:20301)];
% amp_5_y0 = [amp_5(20101:20301)];
% phase_1_y0 = [phase_1(20101:20301)];
% phase_2_y0 = [phase_2(20101:20301)];
% phase_3_y0 = [phase_3(20101:20301)];
% phase_4_y0 = [phase_4(20101:20301)];
% phase_5_y0 = [phase_5(20101:20301)];
% 

x = linspace(-0.025,0.025,201);



% Diffrence of amplitudes

% moving away from dB 
amp_1_ndB = 10.^(amp_1/10).*exp(1i*phase_1 *pi/180);
amp_3_ndB = 10.^(amp_3/10).*exp(1i*phase_3 *pi/180);

amp_2_ndB = 10.^(amp_2/10).*exp(1i*phase_2 *pi/180);
amp_4_ndB = 10.^(amp_4/10).*exp(1i*phase_4 *pi/180);
amp_5_ndB = 10.^(amp_5/10).*exp(1i*phase_5 *pi/180);

amp_1_pattern = amp_1_ndB-amp_5_ndB;
amp_1=10*log10(abs(amp_1_pattern));

amp_2_pattern = amp_2_ndB-amp_5_ndB;
amp_2=10*log10(abs(amp_2_pattern));

amp_3_pattern = amp_3_ndB-amp_5_ndB;
amp_3=10*log10(abs(amp_3_pattern));

amp_4_pattern = amp_4_ndB-amp_5_ndB;
amp_4=10*log10(abs(amp_4_pattern));

figure(1)

amp_1_holo = (reshape(amp_1,[201,201]));
k= linspace(-0.0375,0.0375,201);
imagesc(k,k,transpose(amp_1_holo));

colorbar
colormap('jet')
ax = gca;
ax.YDir = 'normal';
clim([-40,-10])
xlabel('x(m)')
ylabel('y(m)')
maximi0 = max(amp_1)
title(['Element ', num2str(element_number1), ' amplitude at ', num2str(freq_GHz),' GHz']);
subtitle('Hologram measurement July 2024, other elements effect negated')

%saveas(gcf, fullfile('VTT_transarray_matlab_pictures_2024', ['Element_', num2str(element_number), '_Hologram_amplitude_noMask_negatedOtherElementsAffect.jpg']));


figure(2)

amp_2_holo = (reshape(amp_2,[201,201]));
k= linspace(-0.0375,0.0375,201);
imagesc(k,k,transpose(amp_2_holo));

colorbar
colormap('jet')
ax = gca;
ax.YDir = 'normal';
clim([-40,-10])
xlabel('x(m)')
ylabel('y(m)')
maximi90 =max(amp_2)
title(['Element ', num2str(element_number2), ' amplitude at ', num2str(freq_GHz),' GHz']);
subtitle('Hologram measurement July 2024, other elements effect negated')

%saveas(gcf, fullfile('VTT_transarray_matlab_pictures_2024', ['Element_', num2str(element_number), '_Hologram_amplitude_noMask_negatedOtherElementsAffect.jpg']));


figure(3)

amp_3_holo = (reshape(amp_3,[201,201]));
imagesc(k,k,transpose(amp_3_holo));

colorbar
colormap('jet')
ax = gca;
ax.YDir = 'normal';
clim([-40,-10])
xlabel('x(m)')
ylabel('y(m)')
maximi180 =max(amp_3)
title(['Element ', num2str(element_number3), ' amplitude at ', num2str(freq_GHz),' GHz']);
subtitle('Hologram measurement July 2024, other elements effect negated')

%saveas(gcf, fullfile('VTT_transarray_matlab_pictures_2024', ['Element_', num2str(element_number), '_Hologram_amplitude_noMask_negatedOtherElementsAffect.jpg']));


figure(4)

amp_4_holo = (reshape(amp_4,[201,201]));
k= linspace(-0.0375,0.0375,201);
imagesc(k,k,transpose(amp_4_holo));

colorbar
colormap('jet')
ax = gca;
ax.YDir = 'normal';
clim([-40,-10])
xlabel('x(m)')
ylabel('y(m)')
maximi270 = max(amp_4)
title(['Element ', num2str(element_number4), ' amplitude at ', num2str(freq_GHz),' GHz']);
subtitle('Hologram measurement July 2024, other elements effect negated')

%saveas(gcf, fullfile('VTT_transarray_matlab_pictures_2024', ['Element_', num2str(element_number), '_Hologram_amplitude_noMask_negatedOtherElementsAffect.jpg']));


