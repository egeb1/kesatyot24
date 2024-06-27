%% Script that reads data from PNA
% Based on the Matworks example "Characterizing a low-noise amplifier by 
% measuring its S-parameters", http://se.mathworks.com/help/instrument/
% examples/characterizing-a-low-noise-amplifier-by-measuring-its-s-parameters.html.
% The instrument control session code is generated with the Instrument
% Control Toolbox and Test & Measurement Tool.
% This script works with the Agilent PNA E8361C connected via USB to
% measurement laptop.
% 20th June 2018, ATa


clc;
clear all;
close all;

%% Measurement parameters

% The VNA was configured for millimeter-wave extensions before running the
% script. It seems that the preset mm-wave configuration remains.

frequencyRange = [26e9, 30e9];
numPoints = 101;
measurementType = 'S21';
tTimeout = 50;

% The resource name is taken from the Test & Measurement Tool machine
% generated code
% resourceName = 'USB0::0x0957::0x0118::US49010190::0::INSTR';
resourceName = 'USB0::0x0957::0x0118::MY51451451::0::INSTR'; 


obj1 = connectTo(resourceName);
sysPreset(obj1);
% Wait till system is ready as Preset could take time
waitToReady(obj1, tTimeout);
setMeasurement(obj1, frequencyRange, numPoints, measurementType);
setDataFormat(obj1);

% Select a single sweep across the frequency range to trigger a measurement

for i = 1:5
    % Trigger the sweep
    tic;
    fprintf(obj1,':SENSe:SWEep:MODE SINGLE');
    waitToReady(obj1, tTimeout);
    disp(['Sweep took ', num2str(toc), ' s.']);
    % Autoscale display
    tic;
    fprintf(obj1, 'DISPlay:WIND:Y:AUTO');
    waitToReady(obj1, tTimeout);
    disp(['Autoscale took ',  num2str(toc), ' s.']);

    % Request 2-port measurement data from instrument
    tic;
    fprintf(obj1, 'CALC:DATA:SNP:PORTs? ''1,2''');
    rawDataDB = binblockread(obj1, 'double');
    fread(obj1,1);
    waitToReady(obj1, tTimeout);
    disp(['Data readout took ',  num2str(toc), ' s.']);

    % Read back the number of points in the measurement and reshape the
    % measurement data
    numPoints = str2double(query(obj1,' SENSe:SWEep:POINts?'));
    
    % Reshape measurement data to [frequency, real, imag] array
     data(i,:,:) = reshape(rawDataDB, numPoints, 9);
%      pause(1);
end

save;

%% Disconnect and Clean Up

% The following code has been automatically generated to ensure that any
% object manipulated in TMTOOL has been properly disposed when executed
% as part of a function or script.

% Disconnect all objects.
fclose(obj1);
% Clean up all objects.
delete(obj1);
clear obj1;
