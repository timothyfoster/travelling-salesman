function tspgen()
    global cities;

    prompt = 'How many cities should be produced? ';
    num_cities = input(prompt);

    prompt = 'What is the minimum x, y coordinate? ';
    min = input(prompt);

    prompt = 'What is the maximum x, y coordinate? ';
    max = input(prompt);
    
    if ((max - min)^2 >= num_cities && max - min > 0)
        fid = fopen('cities.txt', 'w');
        for i=1:num_cities,
            position = find_position( min, max, cities, i);   
            cities(i).x = position(1);
            cities(i).y = position(2);
            fprintf(fid, '%i,%i\n', position);
        end
        fclose(fid);
    else
        display('Please increase maximum or decrease minimum coordinates.');
    end
end