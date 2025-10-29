function abmn = coff(MN, Emn, quad_weight, Er, Etheta, Ephi)
    % Summation for quadrature
    %
    % INPUTS
    % >MN<: the basis function
    % >Emn<: the constant coefficient in front of the integral
    % >quad_weight<: the weights for quadrature
    % >Er<, >Etheta< and >Ephi<: the field at each quadrature point
    % 
    % OUTPUT
    % >abmn<: the multipole coefficient of a particular order

    MNr = MN(:, 1);
    MNtheta = MN(:, 2);
    MNphi = MN(:, 3);
    MNr(isnan(MNr)) = 0;
    MNphi(isnan(MNphi)) = 0;
    MNtheta(isnan(MNtheta)) = 0;

    abmn = (Er .* (MNr) + Etheta .* (MNtheta) + Ephi .* (MNphi)) .* quad_weight;
    abmn = Emn * sum(abmn);
end
