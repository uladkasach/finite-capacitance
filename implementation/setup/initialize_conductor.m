%%%%%%%%%%%%%%%%%%%
%% Alert number of elements between plates
%%%%%%%%%%%%%%%%%%%
elements_between_plates = plate_seperation / Dz;
fprintf('Number of z direction elements between plates : %f\n', elements_between_plates);

%%%%%%%%%%%%%%%%%%%
%% Determine Domain Center Coordinates
%%%%%%%%%%%%%%%%%%%
center_xi = Nx/2;
center_yi = Ny/2;
center_zi = Nz/2;

%%%%%%%%%%%%%%%%%%%
%% Return Centered XY Coordinates for Conductor
%%%%%%%%%%%%%%%%%%%
if(plate_type == 'rectangle')
    [centered_xy_coordinates, centered_xy_x_borders, centered_xy_y_borders] = return_centered_rectangular_plate_coordinates(center_xi, center_yi, Dx, Dy, plate_lx, plate_ly);
else 
    error('That plate type is not defined');
end
    
%%%%%%%%%%%%%%%%%%%
%% Return array of z values at which the centered_xy_coordinates exist.
%%      note - this implementation requires the xy distribution of the conductor to be equivilent across any z dimensions specified
%%%%%%%%%%%%%%%%%%%
if(parallel_plates == true)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Two plates seperated at a distance around center Z
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%
    %% Determine where top plate and bottom plate start
    %%%%
    plate_Nz_offset = ceil(plate_seperation/Dz);
    plate_Nz_offset_top = ceil(plate_Nz_offset/2);
    plate_Nz_offset = [center_zi - plate_Nz_offset_top, center_zi + plate_Nz_offset_top - 1];
    %%%%
    %% Determine size of top and bottom plate
    %%%%
    plate_Nz = ceil(plate_lz/Dz);
    if(plate_Nz == 0)
        plate_Nz = 1;
    end
    plate_thickness_in_elements = plate_Nz;
    plate_Nz = plate_Nz - 1;
    %%%%
    %% Define range of Z element indicies at which conductor xy_plane configuration exists
    %%%%
    centered_z_coordinates = [(plate_Nz_offset(1) - plate_Nz):plate_Nz_offset(1), plate_Nz_offset(2):(plate_Nz_offset(2) + plate_Nz)];
    centered_z_plate_edge = plate_Nz_offset;
else 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% One plate starting at center Z
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%
    %% Determine size of plate
    %%%%
    plate_Nz = ceil(plate_lz/Dz);
    if(plate_Nz == 0)
        plate_Nz = 1;
    end
    plate_thickness_in_elements = plate_Nz;
    plate_Nz = plate_Nz - 1;
    %%%%
    %% Define range of Z element indicies at which conductor xy_plane configuration exists
    %%%%
    centered_z_coordinates = [center_zi:(center_zi+plate_Nz)];
end



%%%%%%%%%%%%%%%%%
%% Calculate total charge for domain
%%%%%%%%%%%%%%%%%
total_charge_for_each_plate = total_charge(centered_xy_coordinates, centered_z_coordinates, plate_thickness_in_elements);