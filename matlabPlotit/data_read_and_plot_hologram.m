%Eero Pietiläinen 29.6.2023 
% Plotting measurement data for 64 element antenna array.
% Plots Hologram data into 2D image.
clear
figure(1)
values = readtable('VTT_transarray_centred_0deg_004_2_beam7hologram.txt','NumHeaderLines',61, 'ExpectedNumVariables',4);
amp = values.Amp;
amp = (reshape(amp,[201,201]));
k= linspace(-0.025,0.025,201);
imagesc(k,k,transpose(amp));


colorbar
colormap('jet')
ax = gca;
ax.YDir = 'normal';
clim([-45,-15])
xlabel('x(m)')
ylabel('y(m)')
title('element 36 phase 0 amplitude in 2D')

figure(2)
values_180 = readtable('VTT_transarray_centred_plus40deg_008_beam7_holo.txt','NumHeaderLines',61, 'ExpectedNumVariables',4);

amp_180 = values_180.Amp;
amp_180 = (reshape(amp_180,[201,201]));
imagesc(k,k,transpose(amp_180));

colorbar
colormap('jet')
ax = gca;
ax.YDir = 'normal';
clim([-45,-15])
xlabel('x(m)')
ylabel('y(m)')
title('element 36 phase 180 amplitude in 2D')
