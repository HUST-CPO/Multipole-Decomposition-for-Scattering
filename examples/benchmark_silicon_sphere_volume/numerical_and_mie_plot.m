%% plot the results from multipole algorithm and Mie theory

close all
clear
clc

%% load the data obtained by numerical projection and Mie theory
load("sca_data_numerical.mat");
load("sca_data_mie.mat");
k = 2 * pi ./ lam_para;
loaddata11;
sigma_geom = (radius ^ 2);

%% plotting
fig_sca_silicon_sphere_numerical_mie_vol = figure;
line_weight = 1.5;
line_weight_marker = 1;
legend_fontsize = 13;
tick_fontsize = 13;
label_fontsize = 13;
marker_size = 7;

% mie theory results
lda = lambda * 1e9;
plot(lda, sigma_total, 'k', 'linewidth', line_weight);
hold on
plot(lda, sigma_a(1, :), 'color', '#D95319', 'linewidth', line_weight);
plot(lda, sigma_b(1, :), 'color', '#0072BD', 'linewidth', line_weight);
plot(lda, sigma_a(2, :), 'color', '#7E2F8E', 'linewidth', line_weight);
plot(lda, sigma_b(2, :), 'color', '#EDB120', 'linewidth', line_weight);

% numerical results
p = (abs1a + abs1b + abs2a + abs2b + abs3a + abs3b) ./ sigma_geom;
hall = plot(lam_para * 1e9, p, '*k', 'MarkerSize', marker_size, 'linewidth', line_weight_marker);
p = (abs1a) ./ sigma_geom;
ha1 = plot(lam_para * 1e9, p, '*', 'MarkerSize', marker_size, 'color', '#D95319', 'linewidth', line_weight_marker);
p = (abs1b) ./ sigma_geom;
hb1 = plot(lam_para * 1e9, p, '*', 'MarkerSize', marker_size, 'color', '#0072BD', 'linewidth', line_weight_marker);
p = (abs2a) ./ sigma_geom;
ha2 = plot(lam_para * 1e9, p, '*', 'MarkerSize', marker_size, 'color', '#7E2F8E', 'linewidth', line_weight_marker);
p = (abs2b) ./ sigma_geom;
hb2 = plot(lam_para * 1e9, p, '*', 'MarkerSize', marker_size, 'color', '#EDB120', 'linewidth', line_weight_marker);

hold off

% labels and legends
yticks([0, 10, 20, 30]);
ylim([0, 32]);
set(gca, 'FontSize', tick_fontsize);
xlim([min(lda) - 0.1, max(lda)]);
xticks([900, 1100, 1300, 1500, 1700, 1900]);
hlegend = legend('Total', 'ED', 'MD', 'EQ', 'MQ', 'volume');
set(hlegend, 'fontsize', legend_fontsize);
set(get(gca, 'XLabel'), 'String', 'wavelength/nm', 'fontsize', label_fontsize);
set(get(gca, 'YLabel'), 'String', '\sigma_{sca}', 'fontsize', label_fontsize);
set(gcf, 'position', [500, 250, 650, 500]);

%% save the image
res = 600;
filename = strcat(['fig_sca_silicon_sphere_numerical_mie_vol']);
filename = [strrep(filename, '.png', '') '.png'];
print(fig_sca_silicon_sphere_numerical_mie_vol, '-dpng', ['-r' num2str(res)], filename);
