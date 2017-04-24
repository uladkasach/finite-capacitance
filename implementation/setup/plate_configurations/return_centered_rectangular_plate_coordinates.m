%%%%%%%%%%%%%%%%%
%% This function returns the XY coordinates for all elements in the conducting plate, centered around the center of the domain
%%%%%%%%%%%%%%%%%
function centered_XY_coordinates = return_centered_rectangular_plate_coordinates(center_xi, center_yi, Dx, Dy, plate_lx, plate_ly)
    

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Retern coordinates for XY centered plate of Rectangular size
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%
    %% Determine # of Elements in each dimension for a rectangular plate
    %%%%%%%%%%%%%%%%%%%
    plate_Nx = ceil(plate_lx/Dx);
    plate_Ny = ceil(plate_ly/Dy);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Calc positions in XY for plates to be centered
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%
    %% Split XY plate elements in two
    %%%%%%%%%%%%%%%%%%%
    plate_Nx_right = ceil(plate_Nx/2);
    plate_Ny_right = ceil(plate_Ny/2);

    %%%%%%%%%%%%%%%%%%%
    %% Derive both halfs for XY plate elements
    %%%%%%%%%%%%%%%%%%%
    plate_Nx = [plate_Nx - plate_Nx_right, plate_Nx_right];
    plate_Ny = [plate_Ny - plate_Ny_right, plate_Ny_right];

    %%%%%%%%%%%%%%%%%%%
    %% Generate Range of X and range of Y to center plate in XY
    %%%%%%%%%%%%%%%%%%%
    %% Note : include center coordinate in right range, as N_right is ceil(N/2)
    plate_x_coordinates = [(center_xi - plate_Nx(1)):(center_xi+plate_Nx(2)+1)];
    plate_y_coordinates = [(center_yi - plate_Ny(1)):(center_yi+plate_Ny(2)+1)];
    %plate_x_coordinates
    %plate_y_coordinates
    
    %%%%%%%%%%%%%%%%%%%
    %% Build matrix of all xy positions
    %%%%%%%%%%%%%%%%%%%
    x_elements_len = size(plate_x_coordinates, 2);
    y_elements_len = size(plate_y_coordinates, 2);
    centered_XY_coordinates = zeros(x_elements_len*y_elements_len, 2);
    total_index = 0;
    for i = 1:x_elements_len
        this_x_element = plate_x_coordinates(i);
        for j = 1:y_elements_len
            this_y_element = plate_y_coordinates(j);
            total_index = total_index + 1;
            centered_XY_coordinates(total_index, 1) = this_x_element;
            centered_XY_coordinates(total_index, 2) = this_y_element;
        end
    end
    
end