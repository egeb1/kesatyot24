values_0 = readtable('VTT_transarray_centred_element_row36active_phase0_chessboard_2d_beam7.txt','NumHeaderLines',72, 'ExpectedNumVariables',4);
azi_0 = values_0.Azimuth_deg_;
elev_0 = values_0.Elevation_deg_;
amp_0 = values_0.Amp;


values_180 = readtable('VTT_transarray_centred_element_row36active_phase180_chessboard_2d_beam7.txt','NumHeaderLines',72, 'ExpectedNumVariables',4);
azi_180 = values_180.Azimuth_deg_;
elev_180 = values_180.Elevation_deg_;
amp_180 = values_180.Amp;




%diffrence

amp_0_ndB = 10.^(amp_0/20);
amp_180_ndB = 10.^(amp_180/20);

amp_tot_ndB = amp_0_ndB-amp_180_ndB;
amp_tot = 20 * log10(abs(amp_tot_ndB));

plot(elev_0,amp_0,'b');
hold on
plot(elev_180,amp_180, 'r');
plot(elev_180,amp_tot, 'g');
title('pahse 0 and 180 amplitudes(0=blue and 180=red)')
hold off