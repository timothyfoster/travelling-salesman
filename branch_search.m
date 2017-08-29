function [shortest_path, solution_order] = branch_search(multi_tree, search)
    global cost;
    global current_soln;
    global limit;
    
    limit = 1;
    current_soln(1,1) = 1;
    solution_order(1) = 1;

    if( search)
        [children] = bfs_recursive(multi_tree, 0, 1, 1);
    else
        [children] = dfs_recursive(multi_tree, 1, 0);
    end
    
    shortest_path = cost(1);
    max = multi_tree(1).child_number + 1;
    
    for i = 1:max
        solution_order(i) = current_soln(1,i);
    end
    for j=2:children
        if( cost(j) > 0 && cost(j) < shortest_path)
            shortest_path = cost(j); % If a cost is less than the least cost, update
            for i = 1:max
                solution_order(i) = current_soln(j,i); % Place that node in the currect position
            end
        end
    end
end

function [child_check, late_search, late_count] = bfs_recursive(multi_tree, child_check, late_search, late_count)
    global cost;
    global limit;
    
    cur_node = multi_tree( late_search( late_count));
    late_count = late_count + 1; 
    
    if( cur_node.child_number) % If the current node has children
        for i=1:cur_node.child_number
            limit = limit + 1;
            late_search(limit) = cur_node.child_array(i); % Add each of the children to the list to be searched later
        end
        
        for i=1:multi_tree( late_search( late_count-1)).child_number % For each of the children in the list
            [child_check, late_search, late_count] = bfs_recursive(multi_tree, child_check, late_search, late_count); % Search deeper
        end
    else       
        child_check = child_check + 1;  
        cost(child_check) = cur_node.cost; 
        index = late_search( late_count-1);
        update_solution(multi_tree, index, child_check);
    end
end

function [child_check] = dfs_recursive(multi_tree, index, child_check)
    global cost;
    if ( multi_tree(index).child_number) % If the current node has children
        for i=1:multi_tree(index).child_number % Loop through all the children
            tval = multi_tree(index).child_array(i);
            [child_check] = dfs_recursive(multi_tree, tval, child_check); % Recursive search each child
        end
    else
        child_check = child_check + 1;
        cost(child_check) = multi_tree(index).cost; % Add cost to global variable
        update_solution(multi_tree, index, child_check); % Add this to the solution set for the node
    end
end

function update_solution(multi_tree, index, child_check)
    global current_soln;
    max = multi_tree(1).child_number + 1;
    iteration = 0;
    while( iteration < max)
        current_soln(child_check, max - iteration) = multi_tree(index).index;
        index = multi_tree(index).parent;
        iteration = iteration + 1;
    end
end