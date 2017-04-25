function electric_field = electric_field_at_position(position, centered_xy_coordinates, centered_z_coordinates, plate_thickness_in_elements, length_per_element)
    %% 4*pi*e_0 * E = integral of rho(r') * (r - r') / |(r - r')|^3 * dtau'
    %%              = sumation of rho(r') * (r - r') / |(r - r')|^3 over each discrete conductor element position r' 
    %% each discrete conductor element position is specified by centered_xy_coordinates foreach centered_z_coordinates
    e_not = 8.854187817 * 10 ^ (-12); % C/(V*m)
    r = position;
    
    total_electric_field = [0, 0, 0]; %% E is in 3 dimensions
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
            
            %% Calculate component's electric field contribution
            %this_electric_field = electric_field_due_to_one_element(r, r_prime, q);
            relative_vector = r - r_prime;
            %relative_vector_in_physical_units = [relative_vector(1)*length_per_element(1), relative_vector(2)*length_per_element(2), relative_vector(3)*length_per_element(3)];
            relative_vector_in_physical_units = relative_vector .* length_per_element;
            this_electric_field = (4*pi*e_not)^(-1) * q * relative_vector_in_physical_units * (magnitude_of_vector(relative_vector_in_physical_units))^(-3);
            
            if(xy_index == 1 && false)
                q
                relative_vector_in_physical_units
                this_electric_field
            end
            
            %% Add it to total field
            total_electric_field = total_electric_field + this_electric_field;
        end
        
    end
    
    electric_field = total_electric_field;
end 


%{
function electric_field = electric_field_due_to_one_element(r, r_prime, q)
            relative_vector = r - r_prime
            electric_field = q * relative_vector * (magnitude_of_vector(relative_vector))^(-3)
end
%}