%Eero Pietiläinen 3.7.2023
% Plot Far-field amplitude in case all elements are on and azimuth angle 
% changes but elevation does not.

clear

[filename, pathname] = uigetfile('*.txt', 'Pick txt file','/Path/to/folder/Data/');
a1 = fullfile(pathname,filename);
filename = a1;

%element_number = extractBetween(filename, "neg", "deg");
%element_number = str2double(element_number{1});
%steering_row = extractBetween(filename, "deg_", "_FFdata");
%steering_row = str2double(steering_row{1});

values = readtable(filename,'NumHeaderLines',72, 'ExpectedNumVariables',4);
amp = values.Amp;
phase = values.Phase;


% taking only the part where elevation is zero
amp = [amp(9871:10011)];
phase = [phase(9871:10011)];


% Plot images
x = linspace(-70,70,141);

plot(x,amp,'b');
xlabel('azimuth (deg.)')
ylabel('Amplitude(dB)')
ylim([-160 -90])
title('Far field amplitude direction 0 deg. and all elements on')
subtitle('Farfield measurement at 75GHz, July 2023')


%saveas(gcf,fullfile('VTT_transarray_matlab_pictures', 'FF_amplitude_0deg__all_elementsON_heina.jpg'));