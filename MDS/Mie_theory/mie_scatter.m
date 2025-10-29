function [an, bn] = mie_scatter(radius, n0, n1, lambda, order)

    % Compute the multipole coefficients using Mie theory for spherical scatterer
    %
    % INPUTS
    % >radius<: the radius of the sphere
    % >n0< and >n1<: the refractive index of background material and the scatterer, respectively
    % >lambda<: the incident wavelength
    % >order<: the max order of multipole to be computed
    %
    % OUTPUTS
    % >an<: the electric multipole coefficients
    % >bn<: the magnetic multipole coefficients

    x = (2 * pi * n0 * radius) ./ lambda;
    m = n1 / n0;
    mx = m * x;

    sqmx = sqrt(pi ./ (2 * mx));
    sqx = sqrt(pi ./ (2 * x));

    an = zeros(order, length(lambda));
    bn = zeros(order, length(lambda));

    for n = 1:order
        nu = n + 0.5;
        bmx = besselj(nu, mx) .* sqmx;
        bx = besselj(nu, x) .* sqx;
        by = bessely(nu, x) .* sqx;
        h1x = bx + 1j * by;

        bmx_1 = besselj(nu - 1, mx) .* sqmx;
        bx_1 = besselj(nu - 1, x) .* sqx;
        by_1 = bessely(nu - 1, x) .* sqx;
        h1x_1 = bx_1 + 1j * by_1;

        dbmx = mx .* bmx_1 - n .* bmx;
        dbx = x .* bx_1 - n .* bx;
        dh1x = x .* h1x_1 - n .* h1x;

        an(n, :) = ((m ^ 2) .* bmx .* dbx - bx .* dbmx) ./ ((m ^ 2) .* bmx .* dh1x - h1x .* dbmx);
        bn(n, :) = (bmx .* dbx - bx .* dbmx) ./ (bmx .* dh1x - h1x .* dbmx);
    end

end
