%% example: compute multipole coefficients of a silicon sphere using surface integration method

close all
clear
clc

%% parameters
c_const = 299792458;
nm = 1e-9;
radius = 210 * nm;
sampling_sph_r = 1.2 * radius;
lam_min = 900 * nm;
lam_max = 1900 * nm;
lam_step = 20 * nm;
lam_para = lam_min:lam_step:lam_max;
omega_para = 2 * pi * c_const ./ lam_para;

%% generate the quadrature points
sampleN = 5810;
int_points = generate_sphere_pt(sampleN);
sca.out_pt = [int_points.x.'; int_points.y.'; int_points.z.'];

for ii = 1:length(omega_para)
    lam_curr = lam_para(ii)
    omega = omega_para(ii);
    sca.freq00 = omega / (2 * pi);

    % read the Comsol file
    name1 = 'param_lambda_';
    name = [name1, num2str(lam_curr), '.mph'];
    name = strrep(name, 'e', 'E');
    name = strrep(name, 'E-06', 'E-6');
    name = strrep(name, 'E-07', 'E-7');
    model = mphload(['.\step\', name]);

    [sca_field, out_pt] = field_build(model, sca, sampling_sph_r);
    Esph = field_from_cart2sph(int_points, sca_field);
    pmm6(ii) = pm6_NeMo(sca.freq00, sampling_sph_r, int_points, Esph);

    % show the quadrature points
    if ~exist('fig_int_points')
        fig_int_points = figure;
        scatter3(out_pt(1, :), out_pt(2, :), out_pt(3, :), '.', 'blue');
        xlim([min(out_pt(1, :)), max(out_pt(1, :))]);
        ylim([min(out_pt(2, :)), max(out_pt(2, :))]);
        zlim([min(out_pt(3, :)), max(out_pt(3, :))]);
    end

end

clear('model');
clear('fig_int_points');
save(['sca_data_numerical.mat']);
