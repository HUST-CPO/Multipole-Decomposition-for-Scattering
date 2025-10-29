%% example: compute multipole coefficients of a silicon sphere using volume integration method

close all
clear
clc

%% parameters
addpath('.\TETRAHEDRON_KEAST_RULE  Quadrature Rules for a Tetrahedron_pack');
c_const = 299792458;
nm = 1e-9;
radius = 210 * nm;
lam_min = 900 * nm;
lam_max = 1900 * nm;
lam_step = 20 * nm;
lam_para = lam_min:lam_step:lam_max;
omega_para = 2 * pi * c_const ./ lam_para;
rule = 10;

%% compute multipole coefficients at each wavelength
for ii = 1:length(omega_para)
    lam_curr = lam_para(ii)
    omega = omega_para(ii);
    sca.freq00 = omega / (2 * pi);

    % read the comsol file
    name1 = 'param_lambda_';
    name = [name1, num2str(lam_curr), '.mph'];
    name = strrep(name, 'e', 'E');
    name = strrep(name, 'E-06', 'E-6');
    name = strrep(name, 'E-07', 'E-7');
    fem = mphload(['.\step\', name]);

    if ~exist('tetra')
        tetra = quad_point52tetra(fem, rule);
        % show the quadrature points
        fig_int_points = figure;
        scatter3(tetra.pt(1, :), tetra.pt(2, :), tetra.pt(3, :), '.', 'blue');
        xlim([min(tetra.pt(1, :)), max(tetra.pt(1, :))]);
        ylim([min(tetra.pt(2, :)), max(tetra.pt(2, :))]);
        zlim([min(tetra.pt(3, :)), max(tetra.pt(3, :))]);
    end

    Js = field_build(fem, tetra);
    Esph = field_from_cart2sph(tetra, Js);
    pmm6(ii) = pm6_NeMo(sca.freq00, tetra, Esph);
end

clear('fem');
clear('fig_int_points');
clear('Esph');
clear('Js');
clear('tetra');
save(['sca_data_numerical.mat']);
