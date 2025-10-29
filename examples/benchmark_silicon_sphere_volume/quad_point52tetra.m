function [tri] = quad_point52tetra(fem, rule)

    % Get the Gaussian quadrature points and corresponding weights inside the scatterer
    %
    % INPUTS
    % >fem<: the comsol model
    % >rule<: the index of the quadrature rule, which takes integers in the range [1, 10].
    % see more at 'keast_rule_num.m'
    %
    % OUTPUTS
    % >tri< contains the volume of each tetrahedron, quadrature points in Cartesian/spherical coordinates, and weights
    % tri.area: the volume of each tetrahedron which meshes the scatterer
    % tri.pt: the quadrature points in Cartesian coordinates
    % tri.w: the weights at each quadrature point
    % tri.sph: the quadrature points in spherical coordinates

    % get the nodes inside the scatterer
    [stats, data] = mphmeshstats(fem);
    ll_meshtype = strcmp('tet', stats.types);
    ll_tet = find(ll_meshtype);
    nodes2coord = data.vertex;
    elems2nodes = 1 + data.elem{ll_tet};
    domain = data.elementity{ll_tet};
    domain = domain.';
    index2 = find(domain == 6);
    elems2nodes = elems2nodes(:, index2);

    tri = struct('area', [], 'pt', [], 'w', [], 'sph', []);

    for k = 1:length(elems2nodes(1, :))
        k
        ct = nodes2coord(:, elems2nodes(:, k));
        triaQuad = quadratureTetra(ct, rule);
        tri.area = [tri.area, triaQuad.area];
        tri.pt = [tri.pt, triaQuad.pt];
        tri.w = [tri.w, triaQuad.w];
    end

    % Cartesian to spherical coordinates
    [azimuth, elevation, r] = cart2sph(tri.pt(1, :), tri.pt(2, :), tri.pt(3, :));
    tri.sph.r = r;
    tri.sph.theta = pi / 2 - elevation;
    tri.sph.phi = azimuth;
end
