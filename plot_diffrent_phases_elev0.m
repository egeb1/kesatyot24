% Eero Pietiläinen 27.6.2023
% Kahden vastakkaisessa vaiheessa olevan elementin FF amplitudin piirettynä.
% Lisäksi piirrettynä on amplitudien erotus. Kaikki arvot desibeleinä.
% Aktiivisena mittauksissa oli elementti 36 ja muut elementit eivät olleet
% aktiivisia ja niiden vaiheet oli laitettu mukailemaan shakkikuviota.
% Viereiset elementit vastakkaisissa vaiheissa.
clear all
values_0 = readtable('VTT_transarray_centred_element_row36active_phase0_chessboard_2d_beam7.txt','NumHeaderLines',72, 'ExpectedNumVariables',4);
amp_0 = values_0.Amp;


values_180 = readtable('VTT_transarray_centred_element_row36active_phase180_chessboard_2d_beam7.txt','NumHeaderLines',72, 'ExpectedNumVariables',4);
amp_180 = values_180.Amp;


% taking only the part where elevation is zero

amp_0 = [amp_0(9871:10011)];
amp_180 = [amp_180(9871:10011)];




% Diffrence of amplitudes

% moving away from dB 
amp_0_ndB = 10.^(amp_0/20);
amp_180_ndB = 10.^(amp_180/20);

% magnitude of the negation moved back to dB
amp_tot = 20 * log10(abs(amp_0_ndB - amp_180_ndB));




% Plot images

x = linspace(-70,70,141);

plot(x,amp_0,'b');
hold on
plot(x,amp_180, 'r');
plot(x,amp_tot, 'g');
title('pahse 0 and 180 amplitudes(0=blue and 180=red)')
hold off