function [ xy ] = find_position( min, max, city_array, check_val)
    collision = 1;
    while(collision == 1)
        xy(1) = round(min + rand(1) * (max-min));
        xy(2) = round(min + rand(1) * (max-min));
        collision = 0; % We may have found a good position
        for i=1:check_val-1,
            if (city_array(i).x == xy(1) && city_array(i).y == xy(2))
                collision = 1; % Other city already there, repeat process
            end
        end
    end
end