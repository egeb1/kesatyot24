function setMeasurement(object, frequencyRange, numPoints, measurementType)
% Function that sets the measurement. Essentially part of the Matworks example 
% "Characterizing a low-noise amplifier by measuring its S-parameters", 
% http://se.mathworks.com/help/instrument/examples/characterizing-a-low-noise
% -amplifier-by-measuring-its-s-parameters.html.
% The measurement-specific inputs are added 
% afterwards.
% Inputs:
% object            Reference to PNS object
% frequencyRange    2-valued vector giving the start and stop frequencies
% numPoints         Number of frequency points in the measurement
% measurementType   Measurement type (S11, S21, S12, S22)
% June 2018 by ATa

% Check the measurement type
if strcmp(measurementType, 'S11') || strcmp(measurementType, 'S21') || strcmp(measurementType, 'S12') || strcmp(measurementType, 'S22')
    
    % Define a measurement name and parameter
    fprintf(object,['CALCulate:PARameter:DEFine:EXT ''SParamMeasurement', measurementType, ''',', measurementType]);
    
    % Create a new display window and turn it on
    fprintf(object,'DISPlay:WINDow1:STATE ON');
    
    % Associate the measurements to WINDow1
    fprintf(object,['DISPlay:WINDow1:TRACe1:FEED ''SParamMeasurement',measurementType,'''']);
    
    % Turn ON the Title, Frequency, and Trace Annotation to allow for
    % visualization of the measurements on the instrument display
    fprintf(object,'DISPlay:WINDow1:TITLe:STATe ON');
    fprintf(object,'DISPlay:ANNotation:FREQuency ON');
    fprintf(object,'DISPlay:WINDow1:TRACe1:STATe ON');
    
else
    disp('Unkown measurement type, use ''S11'', ''S21'', ''S12'', or ''S22''');
end

% Turn OFF averaging
fprintf(object,'SENSe1:AVERage:STATe OFF');
% Set the number of points
fprintf(object, sprintf('SENSe:SWEep:POINts %s',num2str(numPoints)));
% Set the frequency ranges
fprintf(object, sprintf('SENSe:FREQuency:STARt %sHz',num2str(frequencyRange(1))));
fprintf(object, sprintf('SENSe:FREQuency:STOP %sHz',num2str(frequencyRange(2))));

if strcmp(measurementType, 'S11') || strcmp(measurementType, 'S21') || strcmp(measurementType, 'S12') || strcmp(measurementType, 'S22')
    % Select measurements and set measurement trigger to immediate
    fprintf(object,['CALCulate:PARameter:SELect ''SParamMeasurement', measurementType, '''']);
    fprintf(object,'TRIG:SOURce IMMediate');
else
    disp('Unkown measurement type, use ''S11'', ''S21'', ''S12'', or ''S22''');
end