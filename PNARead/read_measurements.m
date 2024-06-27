

% This is a function created from the script 'PNAE8361C20180621.m'
% originally created 20th June 2018, ATa

% Function interpretation 19.06.2019, Bergman Jan

% Based on the Matworks example "Characterizing a low-noise amplifier by 
% measuring its S-parameters", http://se.mathworks.com/help/instrument/
% examples/characterizing-a-low-noise-amplifier-by-measuring-its-s-parameters.html.
% The instrument control session code is generated with the Instrument
% Control Toolbox and Test & Measurement Tool.
% This script works with the Keysight PNA N5225A connected via USB to
% measurement laptop. 


% frequencyRange = The frequency range the sweep will be done with
% numPoints = The amount of data points to be in the measurements

function read_measurements(wantedMeasurements, frequencyRange, numPoints,...
    folderPathAndName, dataIdentifier)

    % Measurement parameters

    % The VNA was configured for millimeter-wave extensions before running the
    % script. It seems that the preset mm-wave configuration remains.
    
    % This loop makes it possible to gather data from multiple S-parameters
    % (one at a time). They will be inserted into .txt files labelled with
    % their corresponding measurementType
    
    disp('aSd')
    for wantedMeasurementIndex = 1:2
        
        if wantedMeasurements(wantedMeasurementIndex) == 1
            
            switch wantedMeasurementIndex    
                
                case 1
                    measurementType = 'S11';
                    
                case 2
                    measurementType = 'S21';
                    
            end
            
        else
            disp('aSd')
            continue;
            
        end
        
        tTimeout = 50;


        % Create the empty data array %?
        data = zeros(10, numPoints, 9);


        % The resource name is taken from the Test & Measurement Tool machine
        % generated code
        % resourceName = 'USB0::0x0957::0x0118::US49010190::0::INSTR';
        %resourceName = 'USB0::0x0957::0x0118::MY51451451::0::INSTR'; 
        resourceName = 'USB0::0x0957::0x0118::MY51451451::0::INSTR';
        obj1 = connectTo(resourceName)
        %sysPreset(obj1);
        
        % Wait till system is ready as Preset could take time
        waitToReady(obj1, tTimeout);
        % setMeasurement(obj1, frequencyRange, numPoints, measurementType);
         %setDataFormat(obj1);
    
        % Select a single sweep across the frequency range to trigger a measurement

        for i = 1:10
            % Trigger the sweep
            fprintf(obj1,':SENSe:SWEep:MODE SINGLE');
            waitToReady(obj1, tTimeout);
            
            % Autoscale display
            %fprintf(obj1, 'DISPlay:WIND:Y:AUTO');
            %waitToReady(obj1, tTimeout);

            % Request 2-port measurement data from instrument
            fprintf(obj1, 'CALC:DATA:SNP:PORTs? ''1,2''');
            rawDataDB = binblockread(obj1, 'double');
            fread(obj1,1);
            waitToReady(obj1, tTimeout);

            % Read back the number of points in the measurement and reshape the
            % measurement data
            numPoints = str2double(query(obj1,' SENSe:SWEep:POINts?'));

            % Reshape measurement data to [frequency, real, imag] array
             data(i,:,:) = reshape(rawDataDB, numPoints, 9);
            pause(0.1);
        end




        % Will result in a file called "?" where A1 means
        % Antenna 1 and Ps1 means Phase Shifter 1 or "?" where A1
        % and A2 are antennas and S1-Sn are the numbers of states given in the
        % file or something other, explained in manual and comments.
        timestamp = datestr(now, 'yyyymmdd_HHMM');
        dataFilename = [folderPathAndName, '/', measurementType,...
                        '_', dataIdentifier,'_', timestamp, '.txt'];

        write_to_file(data, dataFilename, measurementType);

    end    
    
    % Disconnect and Clean Up

    % The following code has been automatically generated to ensure that any
    % object manipulated in TMTOOL has been properly disposed when executed
    % as part of a function or script.
    fprintf(obj1,':SENSe:SWEep:MODE CONTINUOUS');
    waitToReady(obj1, tTimeout);
    % Disconnect all objects.
    fclose(obj1);
    % Clean up all objects.
    delete(obj1);
    clear obj1;
 
    
    
end
