function modifySketch(filePath,newValues)
    % Read the sketch file
    fileText = fileread(filePath);

    % Replace the delay value
    modifiedText = replaceBetween(fileText,'//START', '//END', (newValues));

    % Write the modified text back to the file
    fid = fopen(filePath, 'w');
    fprintf(fid, '%s', modifiedText);
    fclose(fid);
end