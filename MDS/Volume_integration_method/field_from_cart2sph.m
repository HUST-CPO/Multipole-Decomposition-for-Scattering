function Esph = field_from_cart2sph(tetra, Js)

    % Convert the field data in Cartesian coordinates to spherical coordinates
    %
    % INPUTS
    % >tetra<: the quadrature points
    % >Js<: the induced current density at each cartesian point specified by >tetra<
    %
    % OUTPUT
    % >Esph<: the induced current density in spherical coordinates

    r = tetra.sph.r;
    theta = tetra.sph.theta;
    phi = tetra.sph.phi;

    M(1, :) = sin(theta) .* cos(phi);
    M(2, :) = sin(theta) .* sin(phi);
    M(3, :) = cos(theta);
    M(4, :) = cos(theta) .* cos(phi);
    M(5, :) = cos(theta) .* sin(phi);
    M(6, :) = -sin(theta);
    M(7, :) = -sin(phi);
    M(8, :) = cos(phi);
    M(9, :) = zeros(size(theta));

    Erad_cst = M(1, :) .* Js.Ex + M(2, :) .* Js.Ey + M(3, :) .* Js.Ez;
    Etheta_cst = M(4, :) .* Js.Ex + M(5, :) .* Js.Ey + M(6, :) .* Js.Ez;
    Ephi_cst = M(7, :) .* Js.Ex + M(8, :) .* Js.Ey + M(9, :) .* Js.Ez;
    Erad_cst = Erad_cst.';
    Etheta_cst = Etheta_cst.';
    Ephi_cst = Ephi_cst.';

    Esph.Erad = Erad_cst;
    Esph.Etheta = Etheta_cst;
    Esph.Ephi = Ephi_cst;
end
