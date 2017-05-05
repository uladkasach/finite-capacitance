%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Calculation consists of averaging the potential experienced by a charge durring travel between two plates
%%      i.e., integral of E dot dl 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%
%% verify that at center of plates, electric field is only in k^ direction
%%%%%%%%%%%%%%%%%%%%%
if(false)
    center_position = [center_xi, center_yi, center_zi];
    field_at_center = electric_field_at_position(center_position, centered_xy_coordinates, centered_z_coordinates, plate_thickness_in_elements, length_per_element)
end
        
        
%%%%%%%%%%%%%%%%%%%%%
%% draw electric field plot if desired
%%%%%%%%%%%%%%%%%%%%%
if(opt_plot_field == true)
   plot_electric_field_and_conductors(vectors_in_electric_field_plot, field_plot_too_close_range, center_position, centered_xy_coordinates, centered_z_coordinates, centered_z_plate_edge, plate_thickness_in_elements, length_per_element, Nx, Ny, Nz);
end



%%%%%%%%%%%%%%%%%%%%%
%% calculate the potential difference between plates along path of shortest distance from center to center
%%%%%%%%%%%%%%%%%%%%%
if(false)
    position_start = [center_xi, center_yi, centered_z_plate_edge(1)];
    position_end = [center_xi, center_yi, centered_z_plate_edge(2)];
    this_potential = potential_along_shortest_path_between(position_start, position_end, centered_xy_coordinates, centered_z_coordinates, plate_thickness_in_elements, length_per_element);
    fprintf('path (%d, %d, %d) to (%d, %d, %d) results in a potential of %8.3E \n', position_start, position_end, this_potential);

    capacitance = capacitance_from_potential(this_potential, total_charge_for_each_plate(2)); %% Note, charge is considered as plate 2's since we are ending our path on plate 2
    capacitance

    for i = 1:0
        this_xy = return_random_conductor_non_border_xy_coordinates(centered_xy_coordinates, centered_xy_x_borders, centered_xy_y_borders);
        position_start = [this_xy, centered_z_plate_edge(1)];
        this_xy = return_random_conductor_non_border_xy_coordinates(centered_xy_coordinates, centered_xy_x_borders, centered_xy_y_borders);
        position_end = [this_xy, centered_z_plate_edge(2)];

        this_potential = potential_along_shortest_path_between(position_start, position_end, centered_xy_coordinates, centered_z_coordinates, plate_thickness_in_elements, length_per_element);

        fprintf('path (%d, %d, %d) to (%d, %d, %d) results in a potential of %8.8E \n', position_start, position_end, this_potential);
        potentials = [potentials; this_potential];
    end
end



%%%%%%%%%%%%%%%%%%%%%
%% calculate the potential difference between plates explicitly
%%%%%%%%%%%%%%%%%%%%%
position_start = [center_xi, center_yi, centered_z_plate_edge(1) + 1];
position_end = [center_xi, center_yi, centered_z_plate_edge(2)-1];
potential_at_start = potential_at_position_relative_to_origin(position_start, centered_xy_coordinates, centered_z_coordinates, plate_thickness_in_elements, length_per_element);
potential_at_start 
potential_at_end = potential_at_position_relative_to_origin(position_end, centered_xy_coordinates, centered_z_coordinates, plate_thickness_in_elements, length_per_element);
potential_at_end
potential_difference = potential_at_end - potential_at_start

capacitance = capacitance_from_potential(potential_difference, total_charge_for_each_plate(2)); %% Note, charge is considered as plate 2's since we are ending our path on plate 2
capacitance