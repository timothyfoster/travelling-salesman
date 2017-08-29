function tspsolve( increment)
    set(0,'RecursionLimit',2000)
    global cities;
    
    if( increment)
        prompt = 'How many should we end with? ';
        send = input(prompt);
        
        depth_first = zeros(1,send);
        breadth_first = zeros(1,send);
        
        for i=1:send
            num_cities = i;
            fid = fopen('cities.txt', 'w');
            for i=1:num_cities,
                position = find_position( 0, 20, cities, i);   
                cities(i).x = position(1);
                cities(i).y = position(2);
                fprintf(fid, '%i,%i\n', position);
            end
            fclose(fid);

            tspread(0);
            [depth_first(i), breadth_first(i)] = evaluation();
        end
        
        if( send ~= 0)
            figure;
            semilogy(depth_first,'b');
            hold on;
            semilogy(breadth_first,'r');
            hold off;
            title('Total Nodes vs Number of Cities');
            xlabel('Cities');
            ylabel('Nodes');
            grid on;
            legend('Depth First', 'Breadth First');
        end
    end
    evaluation();
end

function [df_nodes, bf_nodes] = evaluation()
    global cities;
    
    multi_tree(1) = node(1, cities(1).x, cities(1).y, 0, 0);
    multi_tree = tree_gen( multi_tree, 1, 1, 0, 0);
    
    [df_dist, df_soln] = branch_search(multi_tree, 0);
    df_nodes = size(multi_tree, 2);
    
    [bf_dist, bf_soln] = branch_search(multi_tree, 1);
    bf_nodes = size(multi_tree, 2);
    
    dfsdis = sprintf('\nTotal Nodes: %d\nTotal Distance: %f\nSolution: %s', df_nodes, df_dist,num2str(df_soln, ' %d '));
    display( sprintf('\nDepth First Search\n==================%s', num2str(dfsdis)));
    
    bfsdis = sprintf('\nTotal Nodes: %d\nTotal Distance: %f\nSolution: %s', bf_nodes, bf_dist, num2str(bf_soln, ' %d '));
    display( sprintf('\nBreadth First Search\n====================%s', num2str(bfsdis)));
end

function [multi_tree, total_nodes] = tree_gen(multi_tree, index, total_nodes, max_nodes, parents)
    global cities;
    global max_cities;
    children = 0;
    current_city = 1;
    
    if( max_nodes < max_cities)
        while( current_city <= max_cities)
            if( multi_tree(index).index ~= current_city) % If its not the current node
                node_found = 0;    
                if( max_nodes > 0) % Avoid the initial case
                    for i=1:max_nodes           
                         if( current_city == parents(i))
                             node_found = 1;
                             break;
                         end
                    end
                end
                if( ~node_found)
                    children = children + 1; % Increment child count
                    total_nodes = total_nodes + 1; % Keep count for stats
                    
                    multi_tree(index).child_array(children) = total_nodes; % Create an empty child node in the child array of parent
                    multi_tree(total_nodes) = node(current_city, cities(current_city).x, cities(current_city).y, index, 0); % Add the coordinates to this new node
                    
                    tdist = sqrt((cities(current_city).x - multi_tree(index).xcoord)^2 + (cities(current_city).y - multi_tree(index).ycoord)^2); % Calculate cost from parent to child
                    
                    multi_tree(total_nodes).cost = multi_tree(index).cost + tdist; % Save cost in parent
                end
            end   
            current_city = current_city + 1; % We now dealing with the next city
        end
        
        max_nodes = max_nodes + 1;  
        multi_tree(index).child_number = children; % Update the parent node with the number of kids
        parents(max_nodes) = multi_tree(index).index; % Add parent to list
        
        for i=1:children % Repeat for all the children of current node
            [multi_tree, total_nodes] = tree_gen(multi_tree, multi_tree(index).child_array(i), total_nodes, max_nodes, parents);
        end
    end
end