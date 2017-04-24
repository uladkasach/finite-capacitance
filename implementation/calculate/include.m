%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Calculation consists of averaging the potential experienced by a charge durring travel between two plates
%%      i.e., integral of E dot dl 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%
%% verify that at center of plates, electric field is only in k^ direction
%%%%%%%%%%%%%%%%%%%%%
if(true)
    center_position = [center_xi, center_yi, center_zi];
    field_at_center = electric_field_at_position(center_position, centered_xy_coordinates, centered_z_coordinates, plate_thickness_in_elements, length_per_element)
end

        
        
%%%%%%%%%%%%%%%%%%%%%
%% verify that at center of plates, electric field is only in k^ direction
%%%%%%%%%%%%%%%%%%%%%
if(opt_plot_field == true)
   plot_electric_field_and_conductors(vectors_in_electric_field_plot, field_plot_too_close_range, center_position, centered_xy_coordinates, centered_z_coordinates, centered_z_plate_edge, plate_thickness_in_elements, length_per_element, Nx, Ny, Nz);
end


