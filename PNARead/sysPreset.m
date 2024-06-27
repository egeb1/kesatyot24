function sysPreset(object)
% Function that presets the PNA. Essentially part of 
% the Matworks example "Characterizing a low-noise amplifier by measuring 
% its S-parameters", http://se.mathworks.com/help/instrument/examples/
% characterizing-a-low-noise-amplifier-by-measuring-its-s-parameters.html.
% Inputs:
% object            Reference to PNA object
% June 2018 by ATa

% Presetting system:
% Perform a System Preset
fprintf(object,'SYSTem:FPReset');
fprintf(object,'*CLS');