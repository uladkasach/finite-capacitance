%%%%%%%%%%%%%%%%%%%
%% Define Domain Dimensions in Meters
%%%%%%%%%%%%%%%%%%%
Lx = 0.5; %%  50 cm
Ly = 0.5;
Lz = 0.2;

%%%%%%%%%%%%%%%%%%%
%% Define number of elements per dimension
%%%%%%%%%%%%%%%%%%%
Nx = 500; 
Ny = 500;
Nz = 1000;

%%%%%%%%%%%%%%%%%%%%
%% Define Conductor Plate
%%%%%%%%%%%%%%%%%%%%
plate_type = 'rectangle';
plate_lx = 0.3; %% 30 cm
plate_ly = 0.3;
plate_lz = 0; %% 0 results in a 1 element thick plate
plate_seperation = 0.1; %% 
parallel_plates= true;
    