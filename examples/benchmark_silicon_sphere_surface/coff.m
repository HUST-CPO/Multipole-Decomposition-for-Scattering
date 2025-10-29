function a_22 = coff(xx, E_22, quad_weight, Er, Etheta, Ephi)

    % Summation for quadrature
    % 
    % INPUTS
    % >xx<: the basis function
    % >E_22<: the constant coefficient in the integral
    % >quad_weight<: the weight at each quadrature point
    % >Er<, >Etheta<, >Ephi<: the scattered field at each quadrature point in spherical coordinate
    % 
    % OUTPUT
    % >a_22<: the multipole coefficient of a particular order
    % 
    
    fn_22.r = xx(:, 1);
    fn_22.theta = xx(:, 2);
    fn_22.phi = xx(:, 3);
    fn_22.r(isnan(fn_22.r)) = 0;
    fn_22.phi(isnan(fn_22.phi)) = 0;
    fn_22.theta(isnan(fn_22.theta)) = 0;

    sqmodN_22 = (fn_22.r .* conj(fn_22.r) + fn_22.theta .* conj(fn_22.theta) + fn_22.phi .* conj(fn_22.phi)) .* quad_weight;
    sqmodN_22 = sum((sqmodN_22)) * (E_22);
    a_22 = (Er .* conj(fn_22.r) + Etheta .* conj(fn_22.theta) + Ephi .* conj(fn_22.phi)) .* quad_weight;
    a_22 = sum(a_22) / sqmodN_22;
end
