function coordinates = return_random_conductor_non_border_xy_coordinates(centered_XY_coordinates, centered_XY_x_borders, centered_XY_y_borders)
    %%%%%%%%%%%%%%%
    %% Useful, for example, as potential_along_shortest_path must ensure that the end position is not on border since durring path discretization actual end position may be off by one element
    %%%%%%%%%%%%%%%
    
    
    this_xy = [-1, -1];
    while(any(this_xy(1) == centered_XY_x_borders) || any(this_xy(2) == centered_XY_y_borders) || isequal(this_xy, [-1, -1]))
        this_xy = centered_XY_coordinates(randperm(size(centered_XY_coordinates, 1), 1), :);
    end
    coordinates = this_xy;
    
end