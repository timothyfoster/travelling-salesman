classdef node
    properties
        index
        xcoord
        ycoord
        parent
        child_array
        child_number
        cost
    end
    methods
        function generic_node = node(node_index, node_x, node_y, nparent, ncost)
            generic_node.index = node_index;
            generic_node.xcoord = node_x;
            generic_node.ycoord = node_y;
            generic_node.parent = nparent;
            generic_node.cost = ncost;
        end
    end
end