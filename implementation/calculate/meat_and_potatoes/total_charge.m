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
            if(this_plate_id == 1)
                q = 1;
            end
            if(this_plate_id == 2)
                q = -1;
            end
    
            total_charge(this_plate_id) = total_charge(this_plate_id) + q; 
        end
        
    end
end