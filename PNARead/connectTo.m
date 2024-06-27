function object = connectTo(resourceName)
% Function that connects to network analyser via USB
% Machine-generated code with Test & Measurement Tool
% Inputs:
% resourceName  Resource name given by the tmtool
% Outputs:
% object        Object variable referring to the connected
% June 2018 by ATa

% Find a VISA-USB object.
object = instrfind('Type', 'visa-usb', 'RsrcName', resourceName, 'Tag', '');

% Create the VISA-USB object if it does not exist
% otherwise use the object that was found.
if isempty(object)
    disp('Object is empty!');
    object = visa('AGILENT', resourceName);
else
    disp('Object is not empty!');
    fclose(object);
    object = object(1);
end

% These are according to the example given in Mathworks
object.InputBufferSize = 10e6;
object.ByteOrder = 'littleEndian';

% Connect to instrument object, object.
fopen(object);

% Display information about instrument
IDNString = query(object,'*IDN?');
fprintf('Connected to: %s\n',IDNString);