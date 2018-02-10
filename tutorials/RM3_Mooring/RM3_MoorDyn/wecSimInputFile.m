
%% Simulation Data
simu = simulationClass();             
simu.simMechanicsFile = 'RM3MoorDyn.slx';      % Location of Simulink Model File with MoorDyn
simu.mode='normal';                
simu.explorer = 'on';
simu.rampTime = 0;                        
simu.endTime= 500;                       
simu.dt = 0.1;                          
simu.dtCITime = 1;           
simu.solver = 'ode45';                      % Runs WEC-Sim with variable time-step
% simu.paraview = 1;                          % Saves data to *.vtp for Paraview
% simu.domainSize = 200;                      % Changes default domain size
 


%% Wave Information
% User-Defined Time-

waves = waveClass('noWaveCIC');

% waves = waveClass('regular');           % Initialize Wave Class and Specify Type                                 
% waves.H = 2.5;                          % Wave Height [m]
% waves.T = 12;                            % Wave Period [s]

% % Irregular Waves using PM Spectrum 
% waves = waveClass('irregular');         % Initialize Wave Class and Specify Type
% waves.H = 2.25;                          % Significant Wave Height [m]
% waves.T = 6.215143;                      % Peak Period [s]
% waves.spectrumType = 'PM';              % Specify Wave Spectrum Type


% waves = waveClass('etaImport');               % Create the Wave Variable and Specify Type
% waves.etaDataFile = 'umpqua46229_6_2008.mat';   % Name of User-Defined Time-Series File [:,2] = [time, wave_elev]

%% Body Data
% Float
body(1) = bodyClass('hydroData/rm3.h5');      
body(1).geometryFile = 'geometry/float.stl';      
body(1).mass = 'equilibrium';                   
body(1).momOfInertia = [20907301 21306090.66 37085481.11];
body(1).cg = [0 0 -0.72];
body(1).initDisp.initLinDisp = [-60 0 0];                  % Initial Displacement
% body(1).initDisp.initLinDisp = [11.5 0 -1.42091];           % Initial Displacement
% body(1).initDisp.initAngularDispAxis = [0 1 0];             % Initial displacement axis of rotation default = [0 1 0]
% body(1).initDisp.initAngularDispAngle = (-345);             % Initial angle of rotation

% Spar/Plate
body(2) = bodyClass('hydroData/rm3.h5');     
body(2).geometryFile = 'geometry/plate.stl';
body(2).mass = 'equilibrium';                   
body(2).momOfInertia = [94419614.57 94407091.24 28542224.82];
body(2).cg = [0 0 -21.29];
body(2).initDisp.initLinDisp = [-60 0 0];                      % Initial Displacement
% body(2).initDisp.initAngularDispAxis = [0 1 0];              % Initial displacement axis of rotation default = [0 1 0]
% body(2).initDisp.initAngularDispAngle = (-345);               % Initial angle of rotation

%% PTO and Constraint Parameters
% Floating (3DOF) Joint
constraint(1) = constraintClass('Constraint1'); 
constraint(1).loc = [0 0 0];


% Translational PTO
pto(1) = ptoClass('PTO1');              	
pto(1).k=1000;                             	
pto(1).c=1200000;                       	
pto(1).loc = [0 0 0];     

%% Mooring
% Moordyn
mooring(1) = mooringClass('mooring1');                   % Initialize mooringClass
mooring(1).moorDynLines = 3;                            % Specify number of lines
mooring(1).moorDynNodes = [21 21 21];       	% Specify number of nodes per line
