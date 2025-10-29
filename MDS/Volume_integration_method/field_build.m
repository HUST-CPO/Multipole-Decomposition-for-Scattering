function [SC] = field_build(model, tetra)

    % Read the induced current density computed by comsol and store the field data in >SC< in Cartesian coordinate
    %
    % INPUTS
    % >model<: the comsol model
    % >tetra<: the Gaussian quadrature points and weights
    %
    % OUTPUTS
    % >SC<: the induced current density at each quadrature point specified by >tetra.pt<

    SC.Ex = mphinterp(model, {'ewfd.iomega*ewfd.Px'}, 'coord', tetra.pt, 'complexout', 'on');
    SC.Ey = mphinterp(model, {'ewfd.iomega*ewfd.Py'}, 'coord', tetra.pt, 'complexout', 'on');
    SC.Ez = mphinterp(model, {'ewfd.iomega*ewfd.Pz'}, 'coord', tetra.pt, 'complexout', 'on');
end
