% Main code for controlling arduino and VNA
% Eero Pietiläinen 10.8.2023
clc

try
addpath('PNARead\')
% set VNA values from VNA itself. Example set frequency and mmwSetup. Set f
% range in matlab code to same freq range and as in VNA. NumPoints as well
% check from VNA.
% set how many rows of data inputed to arduino
numOfControlUnits = 1;
% Element set to be active -6dB?
activeElement = 16;
% frequency
f = [60e9, 90e9];
% number of measurement points
numPoints = 31;
% arduino COM port
comPort ='COM5';
measurementName = 'extenders_only_vaimennin_OFF';

% folder where to save measurement data
folderPathAndName = ['C:\Users\meas\Desktop\2023-06-20 Mittaukset\augustMeas\' [num2str(activeElement),'_D0_16_32_255_D1_16_32_255']];
makeFolder = mkdir(folderPathAndName);
% Connect to arduino
serialConnection = serial(comPort, 'BAUD', 230400);
fopen(serialConnection);
%pause for 4seconds to wait for the board to reset
pause(4);

% Loop to go trough diffrent control units and measure data.
for i = 1 : numOfControlUnits
    setControlUnit(serialConnection,i-1); %i-1 because control units start from 0 in arduino
    pause(2);
    crtlUnitFormatted = sprintf('%03d', i-1); % Format index with leading zeros
    read_measurements([0,1],f,numPoints,folderPathAndName,[num2str(activeElement),'_',crtlUnitFormatted]);
    
end
% close connection to arduino
fclose(serialConnection);



catch ME
    fclose(serialConnection);
    rethrow(ME)
end

