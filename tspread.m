function tspread( read)
    global cities;
    global max_cities;
    
    fid = fopen('cities.txt', 'r');
    max_cities = 0;
    while ~feof(fid)
          max_cities = max_cities + 1; % Read first city
          line = fgets(fid);
          split = sscanf(line, '%i,%i');
          cities(max_cities).x = split(1);
          cities(max_cities).y = split(2);
    end
    fclose(fid);
    if( read == 1)
        dis = '';
        xlarge = 0;
        xsmall = 999999;
        for i=1:max_cities
            dis = strcat( dis, sprintf( '\ncity[%d]\t\tx:%d\t\ty:%d', i, cities(i).x, cities(i).y));
            if( cities(i).x > xlarge)
                xlarge = cities(i).x;
            end
            if( cities(i).x < xsmall)
                xsmall = cities(i).x;
            end
            if( cities(i).y > xlarge)
                xlarge = cities(i).y;
            end
            if( cities(i).y < xsmall)
                xsmall = cities(i).y;
            end
        end
        display( sprintf('Contents of cities.txt\n%s', num2str(dis)));

        mat = '';
        matchFound = 0;
        for j=xsmall-1:xlarge+1
            for k=xsmall-1:xlarge+1
                for i=1:max_cities
                    if( cities(i).x == k && cities(i).y == j)
                        mat = strcat( mat, sprintf(' %d', i));
                        matchFound = 1;
                    end
                end
                if( ~matchFound)
                    mat = strcat( mat, ' .');
                end
                matchFound = 0;
            end
            mat = strcat( mat, '\n');
        end
        display( sprintf( mat));
    end
end
