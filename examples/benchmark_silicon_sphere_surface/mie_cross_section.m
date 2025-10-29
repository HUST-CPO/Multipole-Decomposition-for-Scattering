function [sigma_a, sigma_b, sigma_total] = mie_cross_section(an, bn, lambda, order, radius)

    % Compute the normalized scattering cross-section based on multipole coefficients
    % 
    % INPUTS
    % >an< and >bn<: electric and magnetic multipole coefficients, respectively
    % >lambda<: the incident wavelength
    % >order<: the max order of multipole to be computed
    % >radius<: the radius of the sphere
    % 
    % OUTPUTS 
    % >sigma_a<: the scattering cross-section of electric multipoles
    % >sigma_b<: the scattering cross-section of magnetic multipoles
    % >sigma_total<: the total scattering cross-section

    sigma_a = zeros(size(an));
    sigma_b = zeros(size(bn));

    for ii = 1:order
        sigma_a(ii, :) = (2 * ii + 1) * ((abs(an(ii, :))) .^ 2) .* (lambda .^ 2);
        sigma_b(ii, :) = (2 * ii + 1) * ((abs(bn(ii, :))) .^ 2) .* (lambda .^ 2);
    end

    sigma_a = sigma_a / ((2 * pi) * (radius ^ 2));
    sigma_b = sigma_b / ((2 * pi) * (radius ^ 2));
    sigma_total = sum(sigma_a, 1) + sum(sigma_b, 1);

end
