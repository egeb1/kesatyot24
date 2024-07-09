function setControlUnit(serialConnection, Nvalue)
pause(1);
crtlUnitFormatted = sprintf('%03d', Nvalue); % Format index with leading zeros
command = ['WRTTXMZ ', num2str(crtlUnitFormatted), ' 144 000 000'];
%disp(command);
fprintf(serialConnection,command);  

end
