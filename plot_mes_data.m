clear all




folderPath = '/path/to/your/folder';  % Replace with your folder path
filePattern = fullfile(folderPath, '*.txt');  % Change '*.txt' to match your file type

% Get a list of file paths in the folder using the dir function
fileList = dir(filePattern);

for i = 1:length(fileList)
    filePath = fullfile(folderPath, fileList(i).name);
    
    % Read data from the file
    fileData = fileread(filePath);
    
    % Process the data as needed (e.g., display, analyze, etc.)
    fprintf('Data from %s:\n%s\n', filePath, fileData);
end





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

[M_0,I_0] = max(amp_0,[],"all");
maxAmp_0 = amp_0(I_0);
maxPha_0 = phase_0(I_0);

[M_90,I_90] = max(amp_90,[],"all");
maxAmp_90 =amp_90(I_90);
maxPha_90 = phase_90(I_90);

[M_180,I_180] = max(amp_180,[],"all");
maxAmp_180 = amp_180(I_180);
maxPha_180 = phase_180(I_180);

[M_270,I_270] = max(amp_270,[],"all");
maxAmp_270 = amp_270(I_270);
maxPha_270 = phase_270(I_270);

A_Holo = [maxAmp_0 maxAmp_90 maxAmp_180 maxAmp_270]
pha_Holo = [maxPha_0 maxPha_90 maxPha_180 maxPha_270]
maxA_Holo = max(A_Holo)
minA_Holo = min(A_Holo)
diffMaxtoMin_Holo = maxA_Holo-minA_Holo

% Normalize amplitude values to phase 0

amp_0_norm = 10.^(maxAmp_0/20) * exp(1i * (maxPha_0) * pi / 180);
amp_90_norm = 10.^(maxAmp_90/20) * exp(1i * (maxPha_90) * pi / 180);
amp_180_norm = 10.^(maxAmp_180/20) * exp(1i * (maxPha_180) * pi / 180);
amp_270_norm = 10.^(maxAmp_270/20) * exp(1i * (maxPha_270) * pi / 180);


B = [amp_0_norm/(amp_0_norm) amp_90_norm/(amp_0_norm) amp_180_norm/(amp_0_norm) amp_270_norm/(amp_0_norm)];

polarplot(B,'-*') 
hold ON
% choose first file 
[filename5, pathname5] = uigetfile('*.txt', 'Pick txt file','/Path/to/folder/Data/');
filename5 = fullfile(pathname5,filename5);

% read the data from the first file
values_0FF = readtable(filename5,'NumHeaderLines',72, 'ExpectedNumVariables',4);
amp_0FF = values_0FF.Amp;
phase_0FF =values_0FF.Phase;


% choose the second file
[filename6, pathname6] = uigetfile('*.txt', 'Pick txt file','/Path/to/folder/Data/');
filename6 = fullfile(pathname6,filename6);


% read the data from the second file
values_90FF = readtable(filename6,'NumHeaderLines',72, 'ExpectedNumVariables',4);
amp_90FF = values_90FF.Amp;
phase_90FF =values_90FF.Phase;

% choose first file 
[filename7, pathname7] = uigetfile('*.txt', 'Pick txt file','/Path/to/folder/Data/');
filename7 = fullfile(pathname7,filename7);

% read the data from the first file
values_180FF = readtable(filename7,'NumHeaderLines',72, 'ExpectedNumVariables',4);
amp_180FF = values_180FF.Amp;
phase_180FF =values_180FF.Phase;

% choose the second file
[filename8, pathname8] = uigetfile('*.txt', 'Pick txt file','/Path/to/folder/Data/');
filename8 = fullfile(pathname8,filename8);

% read the data from the second file
values_270FF = readtable(filename8,'NumHeaderLines',72, 'ExpectedNumVariables',4);
amp_270FF = values_270FF.Amp;
phase_270FF =values_270FF.Phase;


[M_0FF,I_0FF] = max(amp_0FF,[],"all");
maxAmp_0FF = amp_0FF(I_0FF);
maxPha_0FF = phase_0FF(I_0FF);

[M_90FF,I_90FF] = max(amp_90FF,[],"all");
maxAmp_90FF =amp_90FF(I_90FF);
maxPha_90FF = phase_90FF(I_90FF);

[M_180FF,I_180FF] = max(amp_180FF,[],"all");
maxAmp_180FF = amp_180FF(I_180FF);
maxPha_180FF = phase_180FF(I_180FF);

[M_270FF,I_270FF] = max(amp_270FF,[],"all");
maxAmp_270FF = amp_270FF(I_270FF);
maxPha_270FF = phase_270FF(I_270FF);

A_FF = [maxAmp_0FF maxAmp_90FF maxAmp_180FF maxAmp_270FF]
pha_FF = [maxPha_0FF maxPha_90FF maxPha_180FF maxPha_270FF]
maxA_FF = max(A_FF)
minA_FF = min(A_FF)
diffMaxtoMin_FF = maxA_FF-minA_FF
% Normalize amplitude values to phase 0

amp_0_normFF = 10.^(maxAmp_0FF/20) * exp(1i * (maxPha_0FF) * pi / 180);
amp_90_normFF = 10.^(maxAmp_90FF/20) * exp(1i * (maxPha_90FF) * pi / 180);
amp_180_normFF = 10.^(maxAmp_180FF/20) * exp(1i * (maxPha_180FF) * pi / 180);
amp_270_normFF = 10.^(maxAmp_270FF/20) * exp(1i * (maxPha_270FF) * pi / 180);


B_FF = [amp_0_normFF/(amp_0_normFF) amp_90_normFF/(amp_0_normFF) amp_180_normFF/(amp_0_normFF) amp_270_normFF/(amp_0_normFF)];

k= polarplot(B_FF,'-o');
k.Color = "green";








[filename9, pathname9] = uigetfile('*.txt', 'Pick txt file','/Path/to/folder/Data/');
filename9 = fullfile(pathname9,filename9);

% read the data from the first file
values_0NF = readtable(filename9,'NumHeaderLines',52, 'ExpectedNumVariables',4);
amp_0NF = values_0NF.Amp;
phase_0NF =values_0NF.Phase;


% choose the second file
[filename10, pathname10] = uigetfile('*.txt', 'Pick txt file','/Path/to/folder/Data/');
filename10 = fullfile(pathname10,filename10);


% read the data from the second file
values_90NF = readtable(filename10,'NumHeaderLines',52, 'ExpectedNumVariables',4);
amp_90NF = values_90NF.Amp;
phase_90NF =values_90NF.Phase;

% choose first file 
[filename11, pathname11] = uigetfile('*.txt', 'Pick txt file','/Path/to/folder/Data/');
filename11 = fullfile(pathname11,filename11);

% read the data from the first file
values_180NF = readtable(filename11,'NumHeaderLines',52, 'ExpectedNumVariables',4);
amp_180NF = values_180NF.Amp;
phase_180NF =values_180NF.Phase;

% choose the second file
[filename12, pathname12] = uigetfile('*.txt', 'Pick txt file','/Path/to/folder/Data/');
filename12 = fullfile(pathname12,filename12);

% read the data from the second file
values_270NF = readtable(filename12,'NumHeaderLines',52, 'ExpectedNumVariables',4);
amp_270NF = values_270NF.Amp;
phase_270NF =values_270NF.Phase;


[M_0NF,I_0NF] = max(amp_0NF,[],"all");
maxAmp_0NF = amp_0NF(I_0NF);
maxPha_0NF = phase_0NF(I_0NF);

[M_90NF,I_90NF] = max(amp_90NF,[],"all");
maxAmp_90NF =amp_90NF(I_90NF);
maxPha_90NF = phase_90NF(I_90NF);

[M_180NF,I_180NF] = max(amp_180NF,[],"all");
maxAmp_180NF = amp_180NF(I_180NF);
maxPha_180NF = phase_180NF(I_180NF);

[M_270NF,I_270NF] = max(amp_270NF,[],"all");
maxAmp_270NF = amp_270NF(I_270NF);
maxPha_270NF = phase_270NF(I_270NF);

A_NF = [maxAmp_0NF maxAmp_90NF maxAmp_180NF maxAmp_270NF]
pha_NF = [maxPha_0NF maxPha_90NF maxPha_180NF maxPha_270NF]
maxA_NF = max(A_NF)
minA_NF = min(A_NF)
diffMaxtoMin_NF = maxA_NF-minA_NF
% Normalize amplitude values to phase 0

amp_0_normNF = 10.^(maxAmp_0NF/20) * exp(1i * (maxPha_0NF) * pi / 180);
amp_90_normNF = 10.^(maxAmp_90NF/20) * exp(1i * (maxPha_90NF) * pi / 180);
amp_180_normNF = 10.^(maxAmp_180NF/20) * exp(1i * (maxPha_180NF) * pi / 180);
amp_270_normNF = 10.^(maxAmp_270NF/20) * exp(1i * (maxPha_270NF) * pi / 180);


B_NF = [amp_0_normNF/(amp_0_normNF) amp_90_normNF/(amp_0_normNF) amp_180_normNF/(amp_0_normNF) amp_270_normNF/(amp_0_normNF)];

p =polarplot(B_NF);
p.LineStyle ="-";
p.Marker = "square";
p.Color = "red";


title(['Element ', num2str(element_number), ' amplitude and phases']);
subtitle('Normalized 75GHz,0 90 180 270, mask, July 2023, active -6dB others -50dB')
legend('Hologram','Far field','Near field', 'Location', 'best');


hold off


saveas(gcf,fullfile('VTT_transarray_matlab_pictures', ['Element_', num2str(element_number), '_polarplot_chessboard_maski_heinakuu_10x10.jpg']));
