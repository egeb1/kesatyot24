%% SETUP

% Main code for controlling arduino and VNA
% Eero Pietiläinen 10.8.2023
% modified 14.6.2024 by Eero Pietiläinen

clc
addpath('PNARead\')
addpath('VTT_antenna_arduino_automation\')
addpath('Standa\Bergman')

% Loop that runs the moveToHome so many times that all devices are in zero
% position.
keepRunning = true;
while keepRunning
    moveToHome();
    userResponse = input('Do you want to run the function again? (y/n): ', 's');
    if strcmpi(userResponse, 'n')
        keepRunning = false;
    end
end

% set VNA values from VNA itself. Example set frequency and mmwSetup. Set f
% range in matlab code to same freq range and as in VNA. NumPoints as well
% check from VNA.
% set how many rows of data inputed to arduino
numOfControlUnits = 64;
% frequency
f = [70e9, 80e9];
% number of measurement points
numPoints = 21;
% arduino COM port
comPort ='COM5';

%% Main Loop for measurement 


% for-loop to go over all 64 elements. 
for activeElement = 1:1:64

disp(['measuring element:',num2str(activeElement)] )
try

% Script to run the functions in parallel
% Create a parallel pool if it does not exist
if isempty(gcp('nocreate'))
    parpool;
end

% Run updating DACs and moving mask&probe in parallel to save time
f1 = parfeval(@updateDACs, 0,activeElement,comPort); % 0 is the number of output arguments
f2 = parfeval(@moveMaskAndProbe, 0,activeElement);

%w Wait for both to be ready before continuing
wait(f1)
wait(f2)

measurementName = 'element wise measurements';
% folder where to save measurement data
folderPathAndName = ['C:\Users\meas\Desktop\2024_mittaukset\augustMeas\' [num2str(activeElement),'_D0_16_32_255_D1_16_32_255']];
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
    %read_measurements([0,1],f,numPoints,folderPathAndName,[num2str(activeElement),'_',crtlUnitFormatted]);
    
end
read(serialConnection,serialConnection.NumBytesAvailable,'string')

% close connection to arduino
delete(serialConnection);


catch ME
    delete(serialConnection);
    rethrow(ME)
end

end
