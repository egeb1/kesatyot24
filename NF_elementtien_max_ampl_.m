
clear all
[filename, pathname] = uigetfile('*.txt', 'Pick txt file','/Path/to/folder/Data/');
a1 = fullfile(pathname,filename);
filename = a1;
element_number = extractBetween(filename, "row", "active_phase");
element_number = str2double(element_number{1});
values_0 = readtable(filename,'NumHeaderLines',52, 'ExpectedNumVariables',4);
amp_0 = values_0.Amp;
phase_0 = values_0.Phase;

[filename2, pathname2] = uigetfile('*.txt', 'Pick txt file','/Path/to/folder/Data/');
a2 = fullfile(pathname2,filename2);
filename2 = a2;
values_90 = readtable(filename2,'NumHeaderLines',52, 'ExpectedNumVariables',4);
amp_90 = values_90.Amp;
phase_90 = values_90.Phase;


[filename3, pathname3] = uigetfile('*.txt', 'Pick txt file','/Path/to/folder/Data/');
filename3 = fullfile(pathname3,filename3);

values_180 = readtable(filename3,'NumHeaderLines',52, 'ExpectedNumVariables',4);
amp_180 = values_180.Amp;
phase_180 = values_180.Phase;

[filename4, pathname4] = uigetfile('*.txt', 'Pick txt file','/Path/to/folder/Data/');
filename4 = fullfile(pathname4,filename4);
values_270 = readtable(filename4,'NumHeaderLines',52, 'ExpectedNumVariables',4);
amp_270 = values_270.Amp;
phase_270 = values_270.Phase;
element_number
maximi0 = max(amp_0)
maximi90 = max(amp_90)
maximi180 = max(amp_180)
maximi270 = max(amp_270)