
clear all

%%Hologram amplitudes
matr_holo = zeros(8,8)+NaN;


 matr_holo (38) = -14.5820/12.296;
 matr_holo (37) = -16.6760/12.296;
 matr_holo(36)=-14.6560/12.296;
 matr_holo(35) = -13.9000/12.296;

 matr_holo (30) = -15.7740/12.296;
 matr_holo (29) =  -16.8580/12.296;
 matr_holo (28) =  -20.3340/12.296;
 matr_holo (27) = -15.3060/12.296;

 matr_holo (22) = -17.759/12.296;
 matr_holo (21) =  -18.598/12.296;
 matr_holo (20) =  -16.994/12.296;
 matr_holo (19) = -16.647/12.296;

 matr_holo (46) = -14.585/12.296;
 matr_holo (45) =  -16.472/12.296;
 matr_holo (44) =  -17.171/12.296;
 matr_holo (43) = -12.296/12.296;

 matr_holo (54) = -16.859/12.296;
 matr_holo (53) =  -20.529/12.296;
 matr_holo (52) =  -15.504/12.296;
 matr_holo (51) = -14.683/12.296;
 matr_holo (50) =  -16.286/12.296;
 matr_holo (49) = -16.478/12.296;

 matr_holo (61) = -17.158/12.296;
 matr_holo (60) =  -16.183/12.296;
 matr_holo (59) =  -12.346/12.296;
 matr_holo (58) = -23.356/12.296;
 matr_holo (57) =  -12.548/12.296;

 matr_holo;
 max(max(matr_holo));
k= linspace(1,8,8);

figure(1)
imagesc(k,k,matr_holo);
colorbar
colormap('Bone')
clim([-2,-1])
title('Max amplitude of each element, hologram, mask on')
subtitle('10x10, 75GHz, active -6dB, others -50dB')
set(gca, 'YDir', 'normal');



%%FF amplitudes


matr_FF = zeros(8,8)+NaN;



 matr_FF (38) = -111.012/108.0020;
 matr_FF (37) = -112.5780/108.0020;
 matr_FF (36) = -110.4420/108.0020;
 matr_FF (35) = -109.3670/108.0020;

 matr_FF (30) = -111.8200/108.0020;
 matr_FF (29) = -112.2960/108.0020;
 matr_FF (28) = -116.1670/108.0020;
 matr_FF (27) = -109.6500/108.0020;

 matr_FF (22) = -113.0400/108.0020;
 matr_FF (21) = -114.0630/108.0020;
 matr_FF (20) = -113.1750/108.0020;
 matr_FF (19) = -112.8490/108.0020;

 matr_FF (46) = -111.6190/108.0020;
 matr_FF (45) = -112.3880/108.0020;
 matr_FF (44) = -113.1400/108.0020;
 matr_FF (43) = -108.0020/108.0020;

 matr_FF (54) = -113.0300/108.0020;
 matr_FF (53) = -116.8850/108.0020;
 matr_FF (52) = -112.1710/108.0020;
 matr_FF (51) = -111.1020/108.0020;
 matr_FF (50) = -113.0850/108.0020;
 matr_FF (49) = -112.7230/108.0020;

 matr_FF (61) = -112.4530/108.0020;
 matr_FF (60) = -111.1390/108.0020;
 matr_FF (59) = -108.2800/108.0020;
 matr_FF (58) = -120.1570/108.0020;
 matr_FF (57) = -109.2700/108.0020;


 max(max(matr_FF))

figure(2)
imagesc(k,k,matr_FF);
colorbar
colormap('Bone')
title('Max amplitude of each element, far field, mask on')
subtitle('10x10, 75GHz, active -6dB, others -50dB')
%clim([-1.6,-1])
set(gca, 'YDir', 'normal');








matr_NF = zeros(8,8)+NaN;



 matr_NF (38) = -39.0400/36.1090;
 matr_NF (37) = -40.5460/36.1090;
 matr_NF (36) = -38.6270/36.1090;
 matr_NF (35) = -37.9910/36.1090;

 matr_NF (30) = -40.3760/36.1090;
 matr_NF (29) = -40.8060/36.1090;
 matr_NF (28) = -44.3870/36.1090;
 matr_NF (27) = -39.6460/36.1090;

 matr_NF (22) = -42.2820/36.1090;
 matr_NF (21) =-42.2820/36.1090;
 matr_NF (20) =-40.9610/36.1090;
 matr_NF (19) =-41.7430/36.1090;

 matr_NF (46) = -39.8040/36.1090;
 matr_NF (45) = -40.2200/36.1090;
 matr_NF (44) = -40.9040/36.1090;
 matr_NF (43) = -36.2930/36.1090;

 matr_NF (54) = -41.9790/36.1090;
 matr_NF (53) = -45.0180/36.1090;
 matr_NF (52) = -40.3550/36.1090;
 matr_NF (51) = -38.8700/36.1090;
 matr_NF (50) = -41.4160/36.1090;
 matr_NF (49) = -41.7270/36.1090;

 matr_NF (61) = -39.8410/36.1090;
 matr_NF (60) = -39.1040/36.1090;
 matr_NF (59) = -36.1090/36.1090;
 matr_NF (58) = -47.9570/36.1090;
 matr_NF (57) = -38.5220/36.1090;


 max(max(matr_NF))

figure(3)
imagesc(k,k,matr_NF);
colorbar
colormap('Bone')
title('Max amplitude of each element, Near field, mask on')
subtitle('10x10, 75GHz, active -6dB, others -50dB')
%clim([-1.6,-1])
set(gca, 'YDir', 'normal');


