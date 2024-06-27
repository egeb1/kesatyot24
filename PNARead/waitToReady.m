function waitToReady(object, tTimeout)
% Function that waits until the system is ready or timeout. Essentially 
% part of the Matworks example "Characterizing a low-noise amplifier by 
% measuring its S-parameters", http://se.mathworks.com/help/instrument/
% examples/characterizing-a-low-noise-amplifier-by-measuring-its-s-
% parameters.html.
% Inputs:
% object    Reference to the object
% tTimeout  Timeout time in seconds
% June 2018 by ATa

opcStatus = 0;
wait = 1;

% Loop until PNA is ready to continue with measurement
% Loop continues until opcStatus == 1 or wait == 0
tic
while ~opcStatus && wait
    
    % Ask the opc status
    opcStatus = str2double(query(object, '*OPC?'));
    
    % Wait unless timed out
    wait = toc < tTimeout;
end

% Alert on timeout!
if ~wait
    disp('PNA timeout!');
end