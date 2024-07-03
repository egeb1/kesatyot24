% Main code for controlling arduino and VNA
% Eero Pietiläinen 10.8.2023
% modified 14.6.2024 by Eero Pietiläinen
clc
addpath('PNARead\')

% for-loop to go over all 64 elements. 
for activeElement = 1:1:64

disp(['measuring element:',num2str(activeElement)] )
try
% set VNA values from VNA itself. Example set frequency and mmwSetup. Set f
% range in matlab code to same freq range and as in VNA. NumPoints as well
% check from VNA.
% set how many rows of data inputed to arduino
numOfControlUnits = 64;
% Element set to be active -6dB?
%activeElement = 1;
% frequency
f = [60e9, 90e9];
% number of measurement points
numPoints = 31;
% arduino COM port
comPort ='COM5';
% update arduino file with elements DAC values.
updateDACs(activeElement,comPort)
% pause; to stop code from running
% until enter is pressed so there is time to move measurement probe and
% mask.
pause;
measurementName = 'element wise measurements';
% folder where to save measurement data
folderPathAndName = ['C:\Users\meas\Desktop\2024_mittaukset\julyMeas\' [num2str(activeElement),'_D0_16_32_255_D1_16_32_255']];
makeFolder = mkdir(folderPathAndName);
% Connect to arduino

try
    serialConnection = serialport(comPort, 230400);
    disp('Serial monitor opened successfully.');
catch e
    disp('Failed to open serial monitor.');
    disp(['Error: ', e.message]);
    return;
end

%pause for 4seconds to wait for the board to reset
pause(4);
% Loop to go trough diffrent control units and measure data.
for i = 1 : numOfControlUnits
    
    setControlUnit(serialConnection,i-1); %i-1 because control units start from 0 in arduino
    read(serialConnection,serialConnection.NumBytesAvailable,'string')
    pause(3);
    crtlUnitFormatted = sprintf('%03d', i-1); % Format index with leading zeros
    read_measurements([0,1],f,numPoints,folderPathAndName,[num2str(activeElement),'_',crtlUnitFormatted]);
    
end
read(serialConnection,serialConnection.NumBytesAvailable,'string')
% close connection to arduino
delete(serialConnection);




catch ME
    delete(serialConnection);
    rethrow(ME)
end

end
