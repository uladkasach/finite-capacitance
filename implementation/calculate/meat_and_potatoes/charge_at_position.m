function charge = charge_at_position(position, plate_id)
    global charge_density_distribution;
    
    if(plate_id == 1)
        q = 1;
    end
    if(plate_id == 2)
        q = -1;
    end
        
    %%%%%%%%%%%
    %% Currently only supporting uniform charge distribution.
    %%%%%%%%%%%
    q = q * charge_density_distribution;
    charge = q;
end