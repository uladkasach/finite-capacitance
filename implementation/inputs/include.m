%%%%%%%%%%%%%%%%%%%
%% Define Domain Dimensions in Meters
%%%%%%%%%%%%%%%%%%%
Lx = 0.5; %%  50 cm
Ly = 0.5;
Lz = 0.04;

%%%%%%%%%%%%%%%%%%%
%% Define number of elements per dimension
%%%%%%%%%%%%%%%%%%%
Nx = 500; 
Ny = 500;
Nz = 2000;

%%%%%%%%%%%%%%%%%%%%
%% Define Conductor Plate
%%%%%%%%%%%%%%%%%%%%
plate_type = 'rectangle';
plate_lx = 0.3; %% 30 cm
plate_ly = 0.3;
plate_lz = 0; %% 0 results in a 1 element thick plate
plate_seperation = 0.01; %% 
parallel_plates= true;
 
 
%%%%%%%%%%%%%%%%%%%%%
%% Plot Field Option
%%%%%%%%%%%%%%%%%%%%%
opt_plot_field = true;
field_plot_too_close_range = 30; 
vectors_in_electric_field_plot = 500;