function [ ] = ximc_set_home_settings(device_id)
dummy_struct = struct('HomeFlags',999);
parg_struct = libpointer('home_settings_t', dummy_struct);
[result, home_settings] = calllib('libximc','get_home_settings', device_id, parg_struct);
clear parg_struct
if result ~= 0
    disp(['Command failed with code', num2str(result)]);
    home_settings = 0;
end
home_settings.HomeFlags = 48;
result = calllib('libximc', 'set_home_settings', device_id, home_settings);
if result ~= 0
    disp(['Command failed with code', num2str(result)]);
end
end