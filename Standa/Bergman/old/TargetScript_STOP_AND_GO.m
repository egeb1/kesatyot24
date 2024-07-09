
addpath('src')
%%Config
%##################################################################
%REMEMBER TO CALIBRATE STAGES BEFORE USE!!!
anglestep = 90; %Step size of the rotation in degrees
xstep = 25; %Step size of the translation (x-axis) in mm
waittime = 1; %Length of the pause after each step in seconds

changerot = 0; %Change rotation direction (0 is default, 1 is inverted)
fullrot = 36000; %Step count for full 360 degree rotation
mintran = 10000; %Step count for start position;
maxtran = 40000; %Step count for maximum translation.
len = 100; %Length of translational stage in mm
%##################################################################
%%
posdataarr = [];
%Check if ximc library is loaded. If not load it
if not(libisloaded('libximc'))
    disp('Loading library')
    [notfound,warnings] = loadlibrary('libximc.dll', @ximcm);
end

%Check for devices and enumerate them.
device_names = ximc_enumerate_devices_wrap(1, '');
devices_count = size(device_names,2);

%This script is made for two stages so check there is exactly two devices
if devices_count ~= 2
    disp('No devices found')
    return
else
    device_ids = [];
    for i=1:devices_count
        disp(['Found device: ', device_names{1,i}]);
        device_ids(i) = calllib('libximc','open_device', device_names{1,i});
        disp(['Using device id ', num2str(device_ids(i))]);
    end
end

calllib('libximc','command_home', device_ids(1));
calllib('libximc','command_home', device_ids(2));
calllib('libximc','command_wait_for_stop', device_ids(1), 100);
calllib('libximc','command_wait_for_stop', device_ids(2), 100);



% %Set the starting position
% calllib('libximc', 'command_move', device_ids(1),mintran, 0);
% calllib('libximc','command_wait_for_stop', device_ids(1), 100);
% if changerot == 1
%     calllib('libximc', 'command_move', device_ids(2),maxrot,0);
% else
%     calllib('libximc', 'command_move', device_ids(2),0,0);
% end
% calllib('libximc','command_wait_for_stop', device_ids(2), 100);
% 
% %Convert steps from units to stepper motor steps
% xstep = round(xstep * (maxtran/len));
% anglestep = round(anglestep * (fullrot/360));
% 
% for alpha = 0:anglestep:fullrot
%     if changerot == 1
%         rot = fullrot - alpha;
%     else
%         rot = alpha;
%     end
%     calllib('libximc', 'command_move', device_ids(2),rot, 0);
%     calllib('libximc','command_wait_for_stop', device_ids(2), 100);
%     for x = mintran:xstep:maxtran
%         calllib('libximc', 'command_move', device_ids(1),x, 0);
%         calllib('libximc','command_wait_for_stop', device_ids(1), 100);
%         %After the stages have stopped save the position and rotation data
%         tic
%         [pos1,upos1] = ximc_get_position(device_ids(1));%Stepper position in steps
%         [pos2,upos2] = ximc_get_position(device_ids(2));%Stepper position in steps
%         time = datestr(now,'HH:MM:SS.FFF');
%         pos1d = pos1 * (len/maxtran);%Convert translation from steps to mm
% 
%         %Convert rotation from steps to degrees
%         if changerot == 1
%             pos2d = (fullrot - pos2) * (360/fullrot);
%         else
%             pos2d = pos2 * (360/fullrot);
%         end
%         data = {time,pos1d,pos2d};
%         posdataarr = [posdataarr ; data];
%         pause(waittime)%Wait for the configured time to wait the mmwave measurement
%         toc
%     end
% end
% 
% %Return to start position
% calllib('libximc', 'command_move', device_ids(1),mintran, 0);
% calllib('libximc','command_wait_for_stop', device_ids(1), 100);
% if changerot == 1
%     calllib('libximc', 'command_move', device_ids(2),maxrot,0);
% else
%     calllib('libximc', 'command_move', device_ids(2),0,0);
% end
% calllib('libximc','command_wait_for_stop', device_ids(2), 100); 
% 
% %Write data to a file
% posdatatab = cell2table(posdataarr, 'VariableNames', {'Time','x (mm)','angle (deg)'});
% writetable(posdatatab,['posdata_' datestr(now,'HH;MM;SS') '.txt'])

%Close devices so they can be used by another program
for j=1:length(device_ids)
    device_id_ptr = libpointer('int32Ptr', device_ids(j));
    calllib('libximc','close_device', device_id_ptr);
end