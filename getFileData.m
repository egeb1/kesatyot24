function fileContent = getFileData(activeElement)
    % Construct the full file path
    numFormated = activeElement;
    if(activeElement<10)
            numFormated = sprintf('%02d', numFormated); % Format index with leading zeros
    end
    folderPath = 'C:\Users\meas\Desktop\2024_mittaukset\';
    fileName = [num2str(numFormated),'_D0_16_32_255_D1_16_32_255.txt'];
    fullPath = fullfile(folderPath, fileName);
    % Open the file for reading
    fid = fopen(fullPath, 'r');
    if fid == -1
        error('Cannot open file: %s', fullPath);
    end
    
    % Read the file content
    fileContent = fscanf(fid, '%c');
    fclose(fid);
end
