% Eero Pietiläinen  10.8.2023
% Based on Jan Bergman's code
% Function writes data to file


% data = [5 x dataPoints x 9] array that has measurement data in it
% dataFilename = the path and name of the wanted file
% measurementType = 'S11', 'S21',...; finds the correct section in the file



function write_to_file(data, dataFilename, measurementType)

    % Determine the point in the array to be read based on the wanted data
    switch measurementType
        case 'S11'
            correctSection = 2;

        case 'S21'
            correctSection = 4;

        case 'S12'
            correctSection = 6;

        case 'S22'
            correctSection = 8;

    end



    % Try to open the wanted file, create one if non-existent
    % -a means that the data will be appended to the file
    dataFileID = fopen(dataFilename, 'at');

    if dataFileID == -1
        disp(['Error: Could not open file called "', dataFilename, '"'])
        pause(1)
        return;
    end

    % In data array created by read_measurements (i,:,:) includes the measurement
    % data from one run, (:,:,4) includes the S21 parameter data from all runs.


    % Formatting in the created file:
    % Frequency(Hz) Amplitude(dB) Phase(deg) as the columns

    % Create an array with frequency on row 1, amplitude on row 2 
    % and phase on row 3. Type the data into three columns to the file
    % The items in the array are the averages of the 10 runs of measurements
    arrayToPrint(1,:) = data(1,:,1); % Frequency
    arrayToPrint(2,:) = 0;
    arrayToPrint(3,:) = 0;

    for i = 1:10

        arrayToPrint(2*i,:) = data(i,:,correctSection); % Amplitude
        arrayToPrint(2*i+1,:) = data(i,:,correctSection+1); % Phase




    end

    % Current data layout is: Freq Ampl Phase Ampl Phase......
    fprintf(dataFileID, '%d    %d    %d    %d    %d    %d    %d    %d    %d    %d    %d    %d    %d    %d    %d    %d    %d    %d    %d    %d    %d \n', arrayToPrint);

    fclose(dataFileID);

end

% %{
% 
% 
% totalAmountOfChange = 0;
%     % Calculate the averages of the 10 measurements.
%     for i = 1:10
%         arrayToPrint(2,:) = arrayToPrint(2,:) + data(i,:,correctSection); % Amplitude
% 
%         % Do all of the calculations with positive phase values
%         indexToChange = (data(i,:,correctSection+1) < 0 && data(i,:,correctSection+1) > -160);
%         arrayToPrint(3,:) = arrayToPrint(3,:) + data(i,:,correctSection+1) + (indexToChange * 360);
% 
%         totalAmountOfChange = totalAmountOfChange + indexToChange;
% 
%     end
% 
%     arrayToPrint(2,:) = arrayToPrint(2,:)./10;
% 
%     % To every negative value was added 360 to get make them positive, to
%     % fix this (and simultaneously calculate the average), is n/10 * 360
%     % removed from every value, where n is the amount of negative numbers
%     % (found in totalAmountOfChange array)
% 
%     arrayToPrint(3,:) = (arrayToPrint(3,:) - totalAmountOfChange .* 360)./10;
% 
% 
% 
% %}
