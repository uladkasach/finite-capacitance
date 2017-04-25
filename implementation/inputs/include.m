%%%%%%%%%%%%%%%%%%%
%% Define Domain Dimensions in Meters
%%%%%%%%%%%%%%%%%%%
Lx = 5; %%  50 cm
Ly = 5;
Lz = 0.02;

%%%%%%%%%%%%%%%%%%%
%% Define number of elements per dimension
%%%%%%%%%%%%%%%%%%%
Nx = 100; 
Ny = 100;
Nz = 1600;

%%%%%%%%%%%%%%%%%%%%
%% Define Conductor Plate
%%%%%%%%%%%%%%%%%%%%
plate_type = 'rectangle';
plate_lx = 4.9; %% 30 cm
plate_ly = 4.9;
plate_lz = 0; %% 0 results in a 1 element thick plate
plate_seperation = 0.005; %% 
parallel_plates= true;
 
 
%%%%%%%%%%%%%%%%%%%%%
%% Plot Field Option
%%%%%%%%%%%%%%%%%%%%%
opt_plot_field = false;
field_plot_too_close_range = 30; 
vectors_in_electric_field_plot = 1000;

