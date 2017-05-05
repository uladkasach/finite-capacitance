%%%%%%%%%%%%%%
%% WARNING: because discretized path may result in xy final element off by one position, must be sure to choose a non border coordinate as position_end
%%%%%%%%%%%%%%

function potential = potential_at_position_relative_to_origin(position, centered_xy_coordinates, centered_z_coordinates, plate_thickness_in_elements, length_per_element)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Calculate potential relative to origin (V(inf) = 0) at any point
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    %% 4*pi*e_0 * V = integral of rho(r') / |(r - r')| * dtau'
    %%              = sumation of rho(r') / |(r - r')| over each discrete conductor element position r' 
    %% each discrete conductor element position is specified by centered_xy_coordinates foreach centered_z_coordinates
    e_not = 8.854187817 * 10 ^ (-12); % C/(V*m)
    r = position;
    
    total_potential = 0; %% E is in 3 dimensions
    for k = 1:size(centered_z_coordinates, 2)
        this_z = centered_z_coordinates(k);
        if (k > plate_thickness_in_elements) 
            this_plate_id = 2;
        else
            this_plate_id = 1;
        end
        for xy_index = 1:size(centered_xy_coordinates, 1)
            this_x = centered_xy_coordinates(xy_index, 1);
            this_y = centered_xy_coordinates(xy_index, 2);
            
            %% Get position of discretized conductor element contributing to electric field
            r_prime = [this_x, this_y, this_z];
            
            %% Get charge inside of discreticed conductor element contributing to the field
            q = charge_at_position(r_prime, this_plate_id);
            
            %% Calculate component's potential contribution
            relative_vector = r - r_prime;
            relative_vector_in_physical_units = relative_vector .* length_per_element;
            this_potential = (4*pi*e_not)^(-1) * q * (magnitude_of_vector(relative_vector_in_physical_units))^(-1);
            
            if(xy_index == 1 && false)
                q
                relative_vector_in_physical_units
                this_electric_field
            end
            
            %% Add it to total field
            total_potential = total_potential + this_potential;
        end
    end
    
    potential = total_potential;
end