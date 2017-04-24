function plot_electric_field_and_conductors(vectors_in_electric_field_plot, field_plot_too_close_range, center_position, centered_xy_coordinates, centered_z_coordinates, centered_z_plate_edge, plate_thickness_in_elements, length_per_element, Nx, Ny, Nz)


    %%%%%%%%%%%%%%%%%%%%%%
    %% randomly choose positions and draw field vectors for them
    %%%%%%%%%%%%%%%%%%%%%%
    positions_full = [];
    fields_full = [];
    for i = 1:vectors_in_electric_field_plot
        i
        this_x = randperm(Nx,1);
        this_y = randperm(Ny,1);
        
        %% select a z value which is not within 'too close' range
        too_close = true;
        while(too_close)
            this_z = randperm(Nz,1);
            too_close = false;
            for i = centered_z_plate_edge
                this_edge_z_value = i;
                if((this_z > this_edge_z_value - field_plot_too_close_range) && (this_z < this_edge_z_value + field_plot_too_close_range))
                    %% too close
                    too_close = true;
                end
            end
        end
        
        this_position = [this_x, this_y, this_z]
        field_here = electric_field_at_position(this_position, centered_xy_coordinates, centered_z_coordinates, plate_thickness_in_elements, length_per_element)
        %field_here = field_here /magnitude_of_vector(field_here);
        
        positions_full = [positions_full;this_position];
        fields_full = [fields_full;field_here];
    end
    
    %% 
    %% Remove maximum value - often 
    
    positions_full_raw = positions_full;
    length_per_element_matrix = repmat(length_per_element, size(positions_full, 1), 1);
    positions_full = positions_full .* length_per_element_matrix;
    quiver3(positions_full(:, 1), positions_full(:, 2), positions_full(:, 3), fields_full(:, 1), fields_full(:, 2), fields_full(:, 3));
    %quiver(positions_full(:, 1), positions_full(:, 3), fields_full(:, 1),  fields_full(:, 3));
    hold on;
    

    %%%%%%%%%%%%%%%%%%%%%%
    %% randomly choose conductor positions and draw them on map
    %%%%%%%%%%%%%%%%%%%%%%
    conductor_positions = [];
    for i = 1:5000
        this_xy = centered_xy_coordinates(randperm(size(centered_xy_coordinates, 1), 1), :);
        this_z = centered_z_coordinates(randperm(size(centered_z_coordinates, 2), 1));
        conductor_positions = [conductor_positions; [this_xy, this_z]];
    end
    length_per_element_matrix = repmat(length_per_element, size(conductor_positions, 1), 1);
    conductor_positions = conductor_positions .* length_per_element_matrix;
    scatter3(conductor_positions(:,1),conductor_positions(:,2),conductor_positions(:,3))


end 