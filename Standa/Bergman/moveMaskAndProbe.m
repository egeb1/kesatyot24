
function moveMaskAndProbe(activeElement)

addpath('src')
try

%% Initialization of variables
% -------------------------------------------------------------------------
% 2.5mm= 1000 * 2.5 µm

% steps to move correct amount each time
dx = 2500; % moving 2500 steps when 1 step is 1 µm
dy = 1000; % means that we move 1000 steps when 1 step is 2.5 µm

% move in y-axis all the time with 2.5 mm step and in x-axis let's move
% every eight element. 
xpos = floor((activeElement - 1) / 8) * dx;
ypos = mod((activeElement - 1), 8) * dy;


%% Initialization of the device
% -------------------------------------------------------------------------

%Check if ximc library is loaded. If not load it
if not(libisloaded('libximc'))
    disp('Loading library')
    [notfound,warnings] = loadlibrary('libximc.dll', @ximcm);
end

%Check for devices and enumerate them.
device_names = ximc_enumerate_devices_wrap(1, '');
devices_count = size(device_names,2);

%This script is made for two stages so check there is exactly two devices
if devices_count ~= 4
    disp('No devices found')
    return
else % Save the device IDs into the device_ids array
    device_ids = [];
    for i=1:devices_count
        disp(['Found device: ', device_names{1,i}]);
        device_ids(i) = calllib('libximc','open_device', device_names{1,i});
        disp(['Using device id ', num2str(device_ids(i))]);
    end
end

%% Move the device
% -------------------------------------------------------------------------

% Start the movement to the position set by xpos and ypos
calllib('libximc','command_move', device_ids(1),ypos,0);
calllib('libximc','command_move', device_ids(2),xpos,0);
calllib('libximc','command_move', device_ids(3),xpos,0);
calllib('libximc','command_move', device_ids(4),ypos,0);


% Continue with code only after both have reached their commanded position.
calllib('libximc','command_wait_for_stop', device_ids(1), 100);
calllib('libximc','command_wait_for_stop', device_ids(2), 100);
calllib('libximc','command_wait_for_stop', device_ids(3), 100);
calllib('libximc','command_wait_for_stop', device_ids(4), 100);




%Close devices so they can be used by another program
for j=1:length(device_ids)
    device_id_ptr = libpointer('int32Ptr', device_ids(j));
    calllib('libximc','close_device', device_id_ptr);
end

% If there's an error somewhere, catch it and close the devices
catch MG
    %Close devices so they can be used by another program
    for j=1:length(device_ids)
        device_id_ptr = libpointer('int32Ptr', device_ids(j));
        calllib('libximc','close_device', device_id_ptr);
    end
    rethrow(MG)
end

end