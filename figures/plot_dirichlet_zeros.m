% Plot |sin(N*omega/2) / sin(omega/2)| and mark zeros at omega = 2*pi*k/N.
% Usage (from repo root): octave figures/plot_dirichlet_zeros.m

function plot_dirichlet_zeros()
  out_dir = fileparts(mfilename('fullpath'));
  out_pdf = fullfile(out_dir, 'dirichlet_zeros.pdf');

  Ns = [8, 16];
  colors = [0.15, 0.15, 0.15; 0.45, 0.45, 0.45];

  figure('visible', 'off', 'color', 'w', 'units', 'inches', 'position', [0, 0, 5.8, 1.85]);
  % Must be the full Fontconfig name; 'Latin Modern Roman' falls back to Noto Sans.
  plot_font = 'TeX Gyre Pagella';
  set(0, 'defaulttextinterpreter', 'none');
  set(0, 'defaultaxesfontname', plot_font);
  set(0, 'defaulttextfontname', plot_font);

  for idx = 1:numel(Ns)
    N = Ns(idx);
    subplot(1, 2, idx);
    hold on;
    box on;

    w = linspace(0, 2 * pi, 4000);
    y = dirichlet_mag(w, N);

    plot(w, y, 'Color', colors(idx, :), 'LineWidth', 1.35);

    zero_ks = 1:(N - 1);
    zero_w = 2 * pi * zero_ks / N;
    plot(zero_w, zeros(size(zero_w)), 'o', ...
      'MarkerSize', 4.5, 'MarkerFaceColor', [0.82, 0.12, 0.12], ...
      'MarkerEdgeColor', [0.82, 0.12, 0.12]);

    for k = [1, 2]
      xline(zero_w(k), '--', 'Color', [0.75, 0.75, 0.75], 'LineWidth', 0.8);
    end

    ylim([0, N * 1.05]);
    xlim([0, 2 * pi]);
    set(gca, 'ytick', 0:N/2:N);
    tick_w = 2 * pi * (0:N) / N;
    tick_labels = cell(1, N + 1);
    tick_labels{1} = '0';
    tick_labels{2} = '2π/N';
    tick_labels{end} = '2π';
    for k = 3:N
      tick_labels{k} = '';
    end
    xticks(tick_w);
    xticklabels(tick_labels);
    xlabel('ω');
    ylabel('|D(ω)|');
    title(sprintf('N = %d', N));
    grid on;
    set(gca, 'GridAlpha', 0.18, 'FontSize', 9, 'LineWidth', 0.6);

    text(2 * pi, N * 1.05, 'Δω = 2π/N', ...
      'HorizontalAlignment', 'right', 'VerticalAlignment', 'top', ...
      'FontSize', 9, 'Color', 'k', 'BackgroundColor', 'w', ...
      'EdgeColor', 'none', 'Margin', 2, 'Clipping', 'off');
  end

  set(gcf, 'PaperUnits', 'inches', 'PaperSize', [5.8, 1.85], ...
    'PaperPosition', [0, 0, 5.8, 1.85]);

  print(out_pdf, '-dpdf', '-painters');
  fprintf('Wrote %s\n', out_pdf);
end

function y = dirichlet_mag(w, N)
  y = zeros(size(w));
  for i = 1:numel(w)
    if abs(w(i)) < 1e-12
      y(i) = N;
    else
      y(i) = abs(sin(N * w(i) / 2) / sin(w(i) / 2));
    end
  end
end

plot_dirichlet_zeros();
