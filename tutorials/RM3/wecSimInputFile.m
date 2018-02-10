%% Simulation Data
simu = simulationClass();               % Initialize Simulation Class
simu.simMechanicsFile = 'RM3.slx';      % Specify Simulink Model File
simu.mode = 'normal';                   % Specify Simulation Mode ('normal','accelerator','rapid-accelerator')
simu.explorer='on';                     % Turn SimMechanics Explorer (on/off)
simu.startTime = 0;                     % Simulation Start Time [s]
simu.rampTime = 0;                   	% Wave Ramp Time [s]
simu.endTime= 500;                      % Simulation End Time [s]
simu.solver = 'ode4';                   % simu.solver = 'ode4' for fixed step & simu.solver = 'ode45' for variable step 
simu.dt = 0.1; 							% Simulation time-step [s]

%% Wave Information noWaveCIC, no waves with radiation CIC  

 waves = waveClass('noWaveCIC');       % Initialize Wave Class and Specify Type  

% % Regular Waves  
% waves = waveClass('regular');           % Initialize Wave Class and Specify Type                                 
% waves.H = 2.5;                          % Wave Height [m]
% waves.T = 12;                            % Wave Period [s]

% % Irregular Waves using PM Spectrum 
% waves = waveClass('irregular');         % Initialize Wave Class and Specify Type
% waves.H = 1.75;                          % Significant Wave Height [m]
% waves.T = 4.557772;                            % Peak Period [s]
% waves.spectrumType = 'PM';              % Specify Wave Spectrum Type

% % Irregular Waves using JS Spectrum with Equal Energy
% waves = waveClass('irregular');         % Initialize Wave Class and Specify Type
% waves.H = 2.5;                          % Significant Wave Height [m]
% waves.T = 8;                            % Peak Period [s]
% waves.spectrumType = 'JS';              % Specify Wave Spectrum Type
% waves.freqDisc = 'EqualEnergy';

% % Irregular Waves using BS Spectrum with State Space Calculation
% waves = waveClass('irregular');         % Initialize Wave Class and Specify Type
% waves.H = 2.5;                          % Significant Wave Height [m]
% waves.T = 8;                            % Peak Period [s]
% waves.spectrumType = 'BS';              % Specify Wave Spectrum Type
% simu.ssCalc = 1;                        % Turn on State Space

% % Irregular Waves with imported spectrum
% waves = waveClass('spectrumImport');    % Create the Wave Variable and Specify Type
% waves.spectrumDataFile = 'ndbcBuoyData.txt';  %Name of User-Defined Spectrum File [2,:] = [omega, Sf]

% % Waves with imported wave elevation time-history  
% waves = waveClass('etaImport');         % Create the Wave Variable and Specify Type
% waves.etaDataFile = 'umpqua46229_6_2008.mat'; % Name of User-Defined Time-Series File [:,2] = [time, wave_elev]

%% Body Data
% Float
body(1) = bodyClass('hydroData/rm3.h5');                        %Create the body(1) Variable, Set Location of Hydrodynamic Data File and Body Number Within this File.   
body(1).geometryFile = 'geometry/float.stl';                    %Location of Geomtry File
body(1).mass = 'equilibrium';                                   %Body Mass. The 'equilibrium' Option Sets it to the Displaced Water Weight.
body(1).momOfInertia = [20907301 21306090.66 37085481.11];      %Moment of Inertia [kg*m^2]  
body(1).cg = [ 0 0 -0.72];
body(1).initDisp.initLinDisp = [ 11.5 0 -1.3];                       %Initial Displacement [m]
body(1).initDisp.initAngularDispAxis = [0 1 0];               %Initial displacement axis of rotation default = [0 1 0]
body(1).initDisp.initAngularDispAngle = (-345);               %Initial angle of rotation

% Spar/Plate
body(2) = bodyClass('hydroData/rm3.h5'); 
body(2).geometryFile = 'geometry/plate.stl'; 
body(2).mass = 'equilibrium';                   
body(2).momOfInertia = [94419614.57 94407091.24 28542224.82];
body(2).cg = [ 0 0 -21.29];
body(2).initDisp.initLinDisp = [0 0  0];                               % Initial Displacement [m]
body(2).initDisp.initAngularDispAxis = [0 1 0];                       % Initial displacement axis of rotation default = [0 1 0]
body(2).initDisp.initAngularDispAngle = (-345);                       % Initial angle of rotation

%% PTO and Constraint Parameters
% Floating (3DOF) Joint
constraint(1) = constraintClass('CONSTRAINT1');                     % Initialize Constraint Class for Constraint1
constraint(1).loc = [0 0 0];                                        % Constraint Location [m]
% constraint(1).initDisp.initAngularDispAxis = [0 1 0];             % Initial displacement axis of rotation default = [0 1 0]
% constraint(1).initDisp.initAngularDispAngle = (-345);             % Initial angle of rotation

% Translational PTO
pto(1) = ptoClass('PTO1');                                           % Initialize PTO Class for PTO1
pto(1).k = 1000;                                                     % PTO Stiffness [N/m]
pto(1).c = 1200000;                                                        % PTO Damping [N/(m/s)]
pto(1).loc = [0 0 0];                                                % PTO Location [m]
% pto(1).initDisp.initAngularDispAxis = [0 1 0];                     % Initial displacement axis of rotation default = [0 1 0]
% pto(1).initDisp.initAngularDispAngle = (-345);                     % Initial angle of rotation