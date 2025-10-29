function triaQuad = quadratureTetra(node_xy2, rule)

    % Get the quadrature points and weights for a single tetrahedron >node_xy2<
    % 
    % INPUTS
    % >node_xy2<: the physical coordinates of a tetrahedron (the size of >node_xy2< is (3, 4))
    % >rule<: the index of the quadrature rule
    % 
    % OUTPUT
    % >triaQuad< contains the quadrature points in the tetrahedron, weights and volume of the tetrahedron
    
    order_num = keast_order_num(rule);
    [xyz, w] = keast_rule(rule, order_num);
    quadpt = tetrahedron_reference_to_physical(node_xy2, order_num, xyz);
    area = repmat(tetrahedron_volume(node_xy2), size(w));
    triaQuad = struct('area', area, 'pt', quadpt, 'w', w);

end
