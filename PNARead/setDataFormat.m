function setDataFormat(object)
% Sets the data format from PNA to be IBM compatible. This is
% machine-produced code by the Test & Measurement Tool.
% Inputs:
% object    Reference to PNA object
% June 2018 by ATa

% Set instrument to return the data back using binblock format
fprintf(object, 'FORMat REAL,64');

% Set byte order to swapped (little-endian) format. SWAPped is required
% when using IBM compatible computers
fprintf(object, 'FORMat:BORDer SWAP');