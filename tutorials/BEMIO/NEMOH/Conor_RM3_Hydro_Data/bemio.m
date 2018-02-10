clc; clear all; close all;
hydro = struct();

hydro = Read_NEMOH(hydro,'C:\Users\Conor\Desktop\ESE Maters\Thesis\WEC-Sim\tutorials\BEMIO\NEMOH\Conor_RM3_Hydro_Data\');
% hydro = Read_WAMIT(hydro,'..\..\WAMIT\RM3\rm3.out',[]);
% hydro = Combine_BEM(hydro); % Compare WAMIT
hydro = Radiation_IRF(hydro,20,[],[],[],1.9);
%hydro = Radiation_IRF_SS(hydro,[],[]);
hydro = Excitation_IRF(hydro,20,[],[],[],1.9);
Write_H5(hydro)
%Plot_BEMIO(hydro)

