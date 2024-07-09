function send_DACs_to_arduino(activeElement)
    % Construct the full file path
    folderPath = '\\home.org.aalto.fi\pietile6\data\Documents\kesa2024\';
    fileName = [num2str(activeElement),'_D0_16_32_255_D1_16_32_255.txt'];
    fullPath = fullfile(folderPath, fileName);

    % Open the file for reading
    fid = fopen(fullPath, 'r');
    if fid == -1
        error('Cannot open file: %s', fullPath);
    end

    % Read the file content
    fileContent = fscanf(fid, '%c');
    fclose(fid);

    % Split the file content into chunks
end
