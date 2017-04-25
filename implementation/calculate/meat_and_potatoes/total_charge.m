function total_charge = total_charge(centered_xy_coordinates, centered_z_coordinates, plate_thickness_in_elements)
    %% Q = integral rho * dtau = summation of rho(r') for each conductor element
    %% Note, charge is considered as charge per plate. Just as potential is considered as potential to get to /a/ plate.
    total_charge = [0, 0]; 
    
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
            r_prime = [this_x, this_y, this_z];
            
            q = charge_at_position(r_prime, this_plate_id);
    
            total_charge(this_plate_id) = total_charge(this_plate_id) + q; 
        end
        
    end
end