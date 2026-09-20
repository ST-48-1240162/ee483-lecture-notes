% Plot |sin(N*omega/2) / sin(omega/2)| and mark zeros at omega = 2*pi*k/N.
% Usage (from repo root): octave figures/plot_dirichlet_zeros.m

function plot_dirichlet_zeros()
  out_dir = fileparts(mfilename('fullpath'));
  out_pdf = fullfile(out_dir, 'dirichlet_zeros.pdf');

  Ns = [8, 16];
  colors = [0.15, 0.15, 0.15; 0.45, 0.45, 0.45];
  accent_color = [40, 90, 145] / 255;  % ee483link (handout hyperlink accent)

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
    tick_labels{end} = '2π';
    for k = 2:N
      tick_labels{k} = '';
    end
    xticks(tick_w);
    xticklabels(tick_labels);

    loose = get(gca, 'LooseInset');
    set(gca, 'LooseInset', [loose(1), max(loose(2), 0.15), loose(3), loose(4)]);

    draw_underbrace(zero_w(1), zero_w(2), 0, '2π/N', 0.032 * N, accent_color);

    xlabel('ω');
    ylabel('|D(ω)|');
    title(sprintf('N = %d', N));
    grid on;
    set(gca, 'GridAlpha', 0.18, 'FontSize', 9, 'LineWidth', 0.6);
  end

  set(gcf, 'PaperUnits', 'inches', 'PaperSize', [5.8, 1.85], ...
    'PaperPosition', [0, 0, 5.8, 1.85]);

  print(out_pdf, '-dpdf', '-painters');
  fprintf('Wrote %s\n', out_pdf);
end

function draw_underbrace(x1, x2, y, label, depth, color)
  xm = (x1 + x2) / 2;
  half_w = (x2 - x1) / 2;
  tip_y = y - depth;

  t = linspace(-1, 1, 48);
  bx = xm + half_w * t;
  by = y - depth * (1 - t.^2);

  h_curve = plot(bx, by, 'Color', color, 'LineWidth', 0.75);
  h_left = plot([x1, x1], [y, y - 0.12 * depth], 'Color', color, 'LineWidth', 0.75);
  h_right = plot([x2, x2], [y, y - 0.12 * depth], 'Color', color, 'LineWidth', 0.75);
  h_tip = plot([xm - 0.06 * half_w, xm, xm + 0.06 * half_w], ...
    [tip_y, y - 1.18 * depth, tip_y], 'Color', color, 'LineWidth', 0.75);
  set([h_curve, h_left, h_right, h_tip], 'Clipping', 'off');

  text(xm, y - 1.32 * depth, label, ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', ...
    'FontSize', 9, 'Color', color, 'Clipping', 'off');
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
