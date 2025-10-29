function Esph = field_from_cart2sph(int_points, sca_field_cart)

    % Convert the field data in the Cartesian coordinate to spherical coordinate
    % 
    % INPUTS
    % >int_points<: the quadrature points
    % >sca_field_cart<: the field data in Cartesian coordinate
    % 
    % OUTPUT
    % >Esph<: the field data in spherical coordinate
    % 

    % Change the Cartesian coordinates of the quadrature points on the unit sphere to spherical coordinates
    [azimuth, elevation, r] = cart2sph(int_points.x.', int_points.y.', int_points.z.');
    pub.basisR = r;
    pub.basisTheta = pi / 2 - elevation;
    pub.basisPhi = azimuth;
    phi = pub.basisPhi;
    theta = pub.basisTheta;

    M(1, :) = sin(theta) .* cos(phi);
    M(2, :) = sin(theta) .* sin(phi);
    M(3, :) = cos(theta);
    M(4, :) = cos(theta) .* cos(phi);
    M(5, :) = cos(theta) .* sin(phi);
    M(6, :) = -sin(theta);
    M(7, :) = -sin(phi);
    M(8, :) = cos(phi);
    M(9, :) = zeros(size(theta));

    Erad_cst = M(1, :) .* sca_field_cart.Ex + M(2, :) .* sca_field_cart.Ey + M(3, :) .* sca_field_cart.Ez;
    Etheta_cst = M(4, :) .* sca_field_cart.Ex + M(5, :) .* sca_field_cart.Ey + M(6, :) .* sca_field_cart.Ez;
    Ephi_cst = M(7, :) .* sca_field_cart.Ex + M(8, :) .* sca_field_cart.Ey + M(9, :) .* sca_field_cart.Ez;
    Erad_cst = Erad_cst.';
    Etheta_cst = Etheta_cst.';
    Ephi_cst = Ephi_cst.';

    Esph.Erad = Erad_cst;
    Esph.Etheta = Etheta_cst;
    Esph.Ephi = Ephi_cst;
end
