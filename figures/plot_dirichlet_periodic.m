% Plot |sin(N*omega/2)/sin(omega/2)| over several periods to show 2*pi periodicity.
% Usage (from repo root): octave figures/plot_dirichlet_periodic.m

function plot_dirichlet_periodic()
  out_dir = fileparts(mfilename('fullpath'));
  out_pdf = fullfile(out_dir, 'dirichlet_periodic.pdf');

  N = 8;
  plot_font = 'TeX Gyre Pagella';

  figure('visible', 'off', 'color', 'w', 'units', 'inches', 'position', [0, 0, 5.8, 1.75]);
  set(0, 'defaulttextinterpreter', 'none');
  set(0, 'defaultaxesfontname', plot_font);
  set(0, 'defaulttextfontname', plot_font);

  w = linspace(-2.2 * pi, 2.2 * pi, 6000);
  y = dirichlet_mag(w, N);

  plot(w, y, 'Color', [0.15, 0.15, 0.15], 'LineWidth', 1.35);
  hold on;
  plot(0, N, 'o', 'MarkerSize', 5, ...
    'MarkerFaceColor', [0.82, 0.12, 0.12], 'MarkerEdgeColor', [0.82, 0.12, 0.12]);
  text(0.18, N, 'N', 'HorizontalAlignment', 'left', ...
    'VerticalAlignment', 'middle', 'FontSize', 9, 'Color', 'k');
  box on;
  grid on;
  set(gca, 'GridAlpha', 0.18, 'FontSize', 9, 'LineWidth', 0.6);

  ylim([0, N * 1.08]);
  xlim([-2.2 * pi, 2.2 * pi]);

  period_edges = (-2:2) * 2 * pi;
  for k = period_edges
    xline(k, '--', 'Color', [0.78, 0.78, 0.78], 'LineWidth', 0.8);
  end

  xticks([-2 * pi, -pi, 0, pi, 2 * pi]);
  xticklabels({'-2π', '-π', '0', 'π', '2π'});
  xlabel('ω');
  ylabel('|D(ω)|');
  title(sprintf('N = %d', N));

  set(gcf, 'PaperUnits', 'inches', 'PaperSize', [5.8, 1.75], ...
    'PaperPosition', [0, 0, 5.8, 1.75]);

  print(out_pdf, '-dpdf', '-painters');
  fprintf('Wrote %s\n', out_pdf);
end

function y = dirichlet_mag(w, N)
  y = zeros(size(w));
  for i = 1:numel(w)
    if abs(sin(w(i) / 2)) < 1e-10
      y(i) = N;
    else
      y(i) = abs(sin(N * w(i) / 2) / sin(w(i) / 2));
    end
  end
end

plot_dirichlet_periodic();
