function updateDACs(activeElement,comPort)

fileContent = getFileData(activeElement);

% Define paths
projectDir = 'C:\Users\meas\Desktop\2024_mittaukset\VTT_antenna_arduino_automation';
sketchName = 'VTT_antenna_arduino_automation'; % Name of the sketch (without .ino extension)
sketchFile = fullfile(projectDir, [sketchName, '.ino']);
arduinoCliPath = 'C:\Users\meas\Desktop\2024_mittaukset\arduino-cli.exe';

% Define board and port
fqbn = 'chipKIT:pic32:mega_pic32'; % Fully Qualified Board Name
port = comPort; % Replace with your Arduino port

newValues = [newline,'const int tx_ar_vector[beam_count][brd_count][vm_count][dac_count] = {',newline,fileContent,'};',newline];

modifySketch(sketchFile, newValues);

% Compile the sketch
compileCommand = sprintf('%s compile --fqbn %s %s', arduinoCliPath, fqbn, sketchName);
[status, cmdout] = system(compileCommand);

if status == 0
    disp('Compilation successful.');
else
    disp('Compilation failed.');
    disp(cmdout);
end

% Upload the sketch if compilation was successful
if status == 0
    uploadCommand = sprintf('%s upload -p %s --fqbn %s %s', arduinoCliPath, port, fqbn, sketchName);
    [status, cmdout] = system(uploadCommand);

    if status == 0
        disp('Upload successful.');
    else
        disp('Upload failed.');
        disp(cmdout);
    end
end
