function package_sph = generate_sphere_pt(sampleN)

    % Generate Lebedev quadrature weights and points that are given in both
    % Cartesian and spherical coordinates, and the corresponding spherical
    % basis vectors in Cartesian coordinates.
    %
    % INPUT
    % sampleN: the number of quadrature points which only allows several specified values:
    %   6, 14, 26, 38, 50, 74, 86, 110, 146, 170, 194, 230, 266, 302,...
    %   350, 434, 590, 770, 974, 1202, 1454, 1730, 2030, 2354, 2702, 3074,...
    %   3470, 3890, 4334, 4802, 5294, 5810.
    %
    % OUTPUT
    % package_sph: a struct which contains quadrature points, weights and spherical basis vectors
    %

    % Generate a list of sampling points by Lebedev method
    leb_struct = getLebedevSphere(sampleN);
    quad_weight = leb_struct.w;
    cc_x = leb_struct.x; % cc means Cartesian coordinate
    cc_y = leb_struct.y;
    cc_z = leb_struct.z;

    sc_theta_sph = acos(leb_struct.z); % sc means spherical coordinate
    sc_phi_sph = atan2(leb_struct.y, leb_struct.x);
    sc_phi_sph = sc_phi_sph + 2 * pi * (sc_phi_sph < 0);

    % The 5th and 6th points are the northern and southern pole.
    % The phi coordinate is, undoubtedly, zero.
    sc_phi_sph(5) = 0;
    sc_phi_sph(6) = 0;

    xy_radius_reci = diag(1 ./ sqrt(leb_struct.x .^ 2 + leb_struct.y .^ 2));
    basis_r_sph = [leb_struct.x, leb_struct.y, leb_struct.z].';
    basis_theta_sph = [leb_struct.x .* leb_struct.z, leb_struct.y .* leb_struct.z, ...
                           - (leb_struct.x .^ 2 + leb_struct.y .^ 2)].' * xy_radius_reci;
    basis_phi_sph = [- leb_struct.y, leb_struct.x, ...
                         zeros(size(leb_struct.x))].' * xy_radius_reci;

    % define the basis vectors for the north and south poles
    basis_theta_sph(:, 5) = [1; 0; 0];
    basis_theta_sph(:, 6) = [-1; 0; 0];
    basis_phi_sph(:, 5) = [0; 1; 0];
    basis_phi_sph(:, 6) = [0; 1; 0];

    package_sph.x = cc_x;
    package_sph.y = cc_y;
    package_sph.z = cc_z;
    package_sph.quadWeight = quad_weight;
    package_sph.theta = sc_theta_sph;
    package_sph.phi = sc_phi_sph;
    package_sph.basisR = basis_r_sph;
    package_sph.basisTheta = basis_theta_sph;
    package_sph.basisPhi = basis_phi_sph;

end
