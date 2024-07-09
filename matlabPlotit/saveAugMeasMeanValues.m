clear all


freq1 = 70;
freq2 = 71;
f=60:90;           % operating freaquency
numOfLines = 64;   % startin from 1, 2,3,4,5,6...

% get the right lines from the files that match the wanted freaquency
freqLine1 =freq1-59; 
freqLine2 = freq2-59;

for a=1:64
    elementNumber = sprintf('%02d', a);
    %find the right folder where measured files are
    folderPath = ['\\home.org.aalto.fi\pietile6\data\Documents\Eero_P_VTT_antenna_measurements_summer2023\augustMeas\',elementNumber,'_D0_16_32_255_D1_16_32_255'];  % Replace with your folder path
    filePattern = fullfile(folderPath, '*.txt');  % Change '*.txt' to match your file type
    savePath ='\\home.org.aalto.fi\pietile6\data\Documents\Eero_P_VTT_antenna_measurements_summer2023\augustMeanValues_70_71_complex';

    % gets the measurement files from the folder
    fileList = dir(filePattern);
    
    % Preallocate array for values to plot.
    plotLine1 = zeros(1, length(fileList)); 
    plotLine2 = zeros(1, length(fileList)); 
    
    %phaseToPlot710 = zeros(1, length(fileList)); 
    %phaseToPlot720 = zeros(1, length(fileList)); 
    
    % for-loop to get data from diffrent files.
    for i = 1:length(fileList)
        filePath = fullfile(folderPath, fileList(i).name);
        
        % Read data from the file
        fileData = fileread(filePath);
        
        % Split the file data into lines
        lines = strsplit(fileData, '\n');
        
        % Initialize arrays to store parsed data
        frequency = [];
        amplitude = zeros(1,10);
        phase = zeros(1,10);
        
        for j = 1:length(lines)
            lineData = str2num(lines{j});  % Convert line to numeric array
            
            % Check if the line has valid data
            if ~isempty(lineData)
                frequency(j) = lineData(1);
                % Extract alternating amplitude and phase values
                ampPhaseData = lineData(2:end);
                amplitude(j, :) = ampPhaseData(1:2:end);
                phase(j, :) = ampPhaseData(2:2:end);
            end
        end
    
    
        % get amplitudes and phases to right arrays that correspond to right
        % measurement frequency
    
        ampLine1 = amplitude(freqLine1, :);
        phaseLine1 = phase(freqLine1, :);
    
        ampLine2 = amplitude(freqLine2, :);
        phaseLine2 = phase(freqLine2, :);
    
        meanComplex1 = mean(10.^(ampLine1/20) .* exp(1i * phaseLine1 *pi/180 ));
        meanComplex2 = mean(10.^(ampLine2/20) .* exp(1i * phaseLine2 *pi/180 ));

        %     % Save meanComplex1 to a text file
        % saveFileName1 = ['meanComplex1_', elementNumber,'_', sprintf('%03d', i), '.txt'];
        % saveFilePath1 = fullfile(savePath, saveFileName1);
        % dlmwrite(saveFilePath1, meanComplex1, 'delimiter', '\t');
        % 
        % % Save meanComplex2 to a text file
        % saveFileName2 = ['meanComplex2_', elementNumber,'_', sprintf('%03d', i), '.txt'];
        % saveFilePath2 = fullfile(savePath, saveFileName2);
        % dlmwrite(saveFilePath2, meanComplex2, 'delimiter', '\t');






        plotLine1(i) =meanComplex1 ;%selectedAmplitude710(5);
        %phaseToPlot710(i) = meanComplex720;%selectedPhase710(5);
        plotLine2(i) = meanComplex2;
      %  ampToPlot720(i) = selectedAmplitude720(5);
      %  phaseToPlot720(i) = selectedPhase720(5);
    
    end
for i = 1:length(plotLine1)
    saveFileName1 = ['meanComplex_',num2str(freq1),'_', elementNumber, '.txt'];
    saveFilePath1 = fullfile(savePath, saveFileName1);
    
    % Format the row number as a 3-digit zero-padded string
    rowNumberStr = sprintf('%03d', i - 1);  % Subtract 1 to make it 0-indexed
    
    % Create a string with the row number and the value
    dataToSave = [rowNumberStr,' // ', num2str(plotLine1(i))];
    
    % Open the file in append mode and write the data
    fid = fopen(saveFilePath1, 'a');
    if i == 1
        % Write a header to the file
        header = ['Mean values of steering angles, frequency - ', num2str(freq1), ', element ',num2str(elementNumber)];  % Customize your header here
        fprintf(fid, '%s\n', header);
    end
    fprintf(fid, '%s\n', dataToSave);
    fclose(fid);
end


for i = 1:length(plotLine2)
    saveFileName2 =  ['meanComplex_',num2str(freq2),'_', elementNumber, '.txt'];
    saveFilePath2 = fullfile(savePath, saveFileName2);
    
    % Format the row number as a 3-digit zero-padded string
    rowNumberStr2 = sprintf('%03d', i - 1);  % Subtract 1 to make it 0-indexed
    
    % Create a string with the row number and the value
    dataToSave2 = [rowNumberStr2,' // ', num2str(plotLine2(i))];
    
    % Open the file in append mode and write the data
    fid2 = fopen(saveFilePath2, 'a');
       
    if i == 1
        % Write a header to the file
        header = ['Mean values of steering angles, frequency - ', num2str(freq2), ', element ',num2str(elementNumber)];  % Customize your header here
        fprintf(fid, '%s\n', header);
    end
    fprintf(fid2, '%s\n', dataToSave2);
    fclose(fid2);
end





    %plot amplitude 
    
  %  Line 1
    % figure (1);
    % x=1:1:(numOfLines);
    % plot(x,20*log10(abs(plotLine1)));
    % eval(['title(''Amplitude - Frequency ' num2str(f(freqLine1)) ' GHz'')']);
    % xlabel('file number')
    % ylabel('amplitude dB')
    % ylim([-95, -35])
    % 
    % Line 2 
    %figure (2);
    %plot(x,20*log10(abs(plotLine2)));
    % eval(['title(''Amplitude - Frequency ' num2str(f(freqLine2)) ' GHz'')']);
    % xlabel('file number')
    % ylabel('amplitude dB')
    %ylim([-95, -35])
    
    %print out amplitude vectors.
    % fprintf('amp 71.0GHz:')
    % disp(ampToPlot710);
    % fprintf('amp 72.0GHz:')
    % disp(ampToPlot720);
    % 
    % fprintf('phase 71.0GHz:')
    % disp(phaseToPlot710);
    % fprintf('phase 72.0GHz:')
    % disp(phaseToPlot720);
    
    
    
    % Create a polar plot for the amplitudes and phases
    
    % Convert phases from degrees to radians
    %phaseToPlot710Rad = deg2rad(phaseToPlot710);
    
    %phaseToPlot720Rad = deg2rad(phaseToPlot720);
    
    %complex_710 = 10.^(ampToPlot710/20) .* exp(1i * phaseToPlot710Rad);
    %complex_720 = 10.^(ampToPlot720/20) .* exp(1i * phaseToPlot720Rad);
    

    % 
    % % Polar plot line 1
    % figure;
    % polarplot(plotLine1, 'o');
    % title([elementNumber ' Polar Plot - Frequency ' num2str(freq1) ' GHz']);
    % %rlim([-80 -40])
    % % Polar plot line 2
    % %saveas(gcf,fullfile('VTT_transarray_matlab_pictures',[elementNumber,'_', num2str(freq1) ,'_polarplot_maski_elokuu_D0_16_32_255_D1_16_32_255.jpg']))
    % 
    % 
    % % Polar plot line 2
    % figure;
    % polarplot(plotLine2, 'o');
    % title([elementNumber ' Polar Plot - Frequency ' num2str(freq2) ' GHz']);


    %rlim([-80 -40])
    %saveas(gcf,fullfile('VTT_transarray_matlab_pictures',[elementNumber,'_', num2str(freq2) ,'_polarplot_maski_elokuu_D0_16_32_255_D1_16_32_255.jpg']))
end



