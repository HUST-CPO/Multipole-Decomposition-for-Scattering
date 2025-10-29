function [SC, pt00Line] = field_build(model, sca, sampling_sph_r)

    % Read the scattered field at each quadrature point computed by Comsol
    % and store the field data in >SC< in Cartesian coordinates
    %
    % INPUTS
    % >model<: the Comsol file
    % >sca<: the structure containing the information of quadrature points
    % >sampling_sph_r<: the physical radius of the quadrature sphere
    %
    % OUTPUT
    % >SC< contains the field data at each quadrature point
    % >pt00Line<: the physical quadrature points
    %

    pt00Line = sca.out_pt * sampling_sph_r;
    SC.Ex = mphinterp(model, {'real(ewfd.relEx)'}, 'coord', pt00Line) + mphinterp(model, {'imag(ewfd.relEx)'}, 'coord', pt00Line) * 1j;
    SC.Ey = mphinterp(model, {'real(ewfd.relEy)'}, 'coord', pt00Line) + mphinterp(model, {'imag(ewfd.relEy)'}, 'coord', pt00Line) * 1j;
    SC.Ez = mphinterp(model, {'real(ewfd.relEz)'}, 'coord', pt00Line) + mphinterp(model, {'imag(ewfd.relEz)'}, 'coord', pt00Line) * 1j;
    SC.Hx = mphinterp(model, {'real(ewfd.relHx)'}, 'coord', pt00Line) + mphinterp(model, {'imag(ewfd.relHx)'}, 'coord', pt00Line) * 1j;
    SC.Hy = mphinterp(model, {'real(ewfd.relHy)'}, 'coord', pt00Line) + mphinterp(model, {'imag(ewfd.relHy)'}, 'coord', pt00Line) * 1j;
    SC.Hz = mphinterp(model, {'real(ewfd.relHz)'}, 'coord', pt00Line) + mphinterp(model, {'imag(ewfd.relHz)'}, 'coord', pt00Line) * 1j;

end
