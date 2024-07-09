function [ pos, upos ] = ximc_get_position(device_id)

% here is a trick.
% we need to init a struct with any real field from the header.
dummy_struct = struct('Position',0);
parg_struct = libpointer('get_position_t', dummy_struct);

% read current engine settings from motor
[result, get_pos_t] = calllib('libximc','get_position', device_id, parg_struct);

clear parg_struct
if result ~= 0
    disp(['Command failed with code', num2str(result)]);
end

pos = get_pos_t.Position;
upos = get_pos_t.uPosition;

end