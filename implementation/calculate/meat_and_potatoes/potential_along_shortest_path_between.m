%%%%%%%%%%%%%%
%% WARNING: because discretized path may result in xy final element off by one position, must be sure to choose a non border coordinate as position_end
%%%%%%%%%%%%%%

function potential = potential_along_shortest_path_between(position_start, position_end, centered_xy_coordinates, centered_z_coordinates, plate_thickness_in_elements, length_per_element)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Calculate potential along shortest path between position_start and position_end
    %%      shortest path -> straight line
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    motion_vector = position_end - position_start;
    
    
    %%%%%%%%%%%%%%%%
    %% Enumerate positions to calculate E along. i.e., define the shortest path given start and end position.
    %%%%%%%%%%%%%%%%
    %%%%
    %% Discretize Slope by number of elements per 1 motion up in z direction --------------- remember dl is elements * length_per_element
    %%%%
    slope_vector = motion_vector / motion_vector(3);
    
    %%%%
    %% Increase slope per itteration to hop X elements in z direction per itteration --- useless
    %%%%
    z_directional_step_size_for_potential = 1;  
    slope_vector = z_directional_step_size_for_potential * slope_vector;
    
    %%%%
    %% Enumerate Positions due to slope
    %%%%
    positions_along_path = [position_start];
    last_position = position_start;
    position_increment_base = [0, 0, 0];
    i = -1;
    while last_position(3) < position_end(3)
        i = i + 1;
        position_increment_base = position_increment_base + slope_vector;
        pre_increment_position_increment_base = position_increment_base;
        this_increment = [0, 0, 0];
        
        for dimension_index = 1:3
            this_increment(dimension_index) = floor(position_increment_base(dimension_index));
            position_increment_base(dimension_index) = position_increment_base(dimension_index) - this_increment(dimension_index);
        end
        
        last_position = last_position + this_increment;
        positions_along_path = [positions_along_path; last_position];
        
        %pre_increment_position_increment_base
        %post_increment_position_increment_base = position_increment_base
        %this_increment
        
    end
    %positions_along_path
    %position_start
    %position_end
    
    %%%%
    %% Ensure slope results in end position still on conductor, fix if it does not
    %%%%
    %% This is guarenteed to not be a problem due to the constraint that position_end not contain any XY elements on the border
    %%      the discretized slope results in end positions being off by a maximum of 1 element - unless discretization is too coarse
    
    
    
    
    %%%%%%%%%%%%%%%%
    %% Integrate by summation along path, 
    %%      note
    %%            - E dot dl = |E|*|dl|*cos(theta), 
    %%            - theta can be calculated two ways, which one is best?
    %%                  - 1) as the angle between that E and the motion_vector -- assumes ideal "trajectory" of motion, such that the integration is not effected by discretization dl direction
    %%                  - 2) as the angle between that E and the dl vector     -- is the method that enables dot product but is fully effected by discretization  
    %%                  -- Conclusion: going with method 2 because a 'zig-zagy' path will still result in correct potential, since it is conservitive. 
    %%                          This is not guarenteed if we choose method 1, since position and slope_vector are not directly related.
    %%            - dl may vary along path (e.g., if slope is [0.5, 1, 1] dl_in_elements = [0, 1, 1] then [1, 1, 1] and repeat)   
    %%%%%%%%%%%%%%%%
    total_potential = 0;
    last_position = [];
    utilized_positions = [];
    potentials = [];
    fields = [];
    too_close_offset = 0;
    for position_index = 1+too_close_offset:(size(positions_along_path, 1)-1-too_close_offset) %% -1 as we do not want to calculate E at the conductor
        this_position = positions_along_path(position_index, :);
        
        if(mod(position_index, 10) == 0)
            fprintf('at position_index %d/%d for calculating potential\n', position_index,(size(positions_along_path, 1)-1));
        end
        
        %% if last position not defined, we are at start position
        if(isequal(last_position, []))
            last_position = this_position;
            continue;
        end
        

        %% Calculate E at this position
        electric_field = electric_field_at_position(this_position, centered_xy_coordinates, centered_z_coordinates, plate_thickness_in_elements, length_per_element);

        %% Calculate dl
        dl_in_elements = this_position - last_position;
        dl_in_elements;
        dl = dl_in_elements .* length_per_element;
        
        %% Calculate cos(theta)
        %cosine_similarity = cosine_similarity_between_two_vectors(electric_field, slope_vector .* length_per_elemen) %% Method 1
        cosine_similarity = cosine_similarity_between_two_vectors(electric_field, dl); %% Method 2
        
        this_potential = magnitude_of_vector(electric_field) * magnitude_of_vector(dl) * cosine_similarity;
        fprintf('at (%d, %d, %d) E is (%8.3E, %8.3E, %8.8E), dl = (%8.3E, %8.3E, %8.3E), cs = %f, V = %8.8E \n', this_position, electric_field, dl, cosine_similarity, this_potential);
        total_potential = this_potential + total_potential;
        utilized_positions = [utilized_positions; this_position];
        potentials = [potentials; this_potential];
        fields = [fields; electric_field];
        last_position = this_position;
    end
    %scatter(utilized_positions(:, 3), (fields(:, 3)));
    scatter(utilized_positions(:, 3), log10(fields(:, 3)));
    title('Z position vs E_z');
    xlabel('Z position (in elements)');
    ylabel('E_z, electric field in z direction');
    
    
    
    
    potential = -1 * total_potential;
end