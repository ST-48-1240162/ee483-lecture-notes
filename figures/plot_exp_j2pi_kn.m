% Unit-circle view of e^{-j2pi kn} = 1 for integer kn.
% Usage (from repo root): octave figures/plot_exp_j2pi_kn.m

function plot_exp_j2pi_kn()
  out_dir = fileparts(mfilename('fullpath'));
  out_pdf = fullfile(out_dir, 'exp_j2pi_kn.pdf');

  plot_font = 'TeX Gyre Pagella';
  accent_color = [40, 90, 145] / 255;  % ee483link
  point_color = [0.82, 0.12, 0.12];
  circle_color = [0.78, 0.78, 0.78];

  fig_w = 5.8;
  fig_h = 2.15;
  figure('visible', 'off', 'color', 'w', 'units', 'inches', 'position', [0, 0, fig_w, fig_h]);
  set(0, 'defaulttextinterpreter', 'none');
  set(0, 'defaultaxesfontname', plot_font);
  set(0, 'defaulttextfontname', plot_font);

  draw_panel(1, 1, accent_color, circle_color, point_color);
  draw_panel(2, 2, accent_color, circle_color, point_color);

  set(gcf, 'PaperUnits', 'inches', 'PaperSize', [fig_w, fig_h], ...
    'PaperPosition', [0, 0, fig_w, fig_h]);

  print(out_pdf, '-dpdf', '-painters');
  fprintf('Wrote %s\n', out_pdf);
end

function draw_panel(panel_idx, num_turns, accent_color, circle_color, point_color)
  subplot(1, 2, panel_idx);
  hold on;
  axis equal;
  box on;
  grid on;
  set(gca, 'GridAlpha', 0.16, 'FontSize', 9, 'LineWidth', 0.6, ...
    'XTick', [-1, 0, 1], 'YTick', [-1, 0, 1]);

  th = linspace(0, 2 * pi, 400);
  plot(cos(th), sin(th), 'Color', circle_color, 'LineWidth', 0.8);

  radii = linspace(0.90, 1.00, num_turns);
  for turn = 1:num_turns
    t0 = 2 * pi * (turn - 1);
    t1 = 2 * pi * turn;
    t = linspace(t0, t1, 420);
    r = radii(turn);

    if turn < num_turns
      line_color = accent_color * 0.55 + [1, 1, 1] * 0.45;
      line_style = '--';
      line_width = 1.05;
    else
      line_color = accent_color;
      line_style = '-';
      line_width = 1.45;
    end

    plot(r * cos(t), -r * sin(t), 'Color', line_color, ...
      'LineStyle', line_style, 'LineWidth', line_width);
  end

  plot(1, 0, 'o', 'MarkerSize', 6, ...
    'MarkerFaceColor', point_color, 'MarkerEdgeColor', point_color);
  text(1.08, 0.05, '1', 'FontSize', 9.5, 'HorizontalAlignment', 'left', ...
    'VerticalAlignment', 'middle');

  arrow_turn = num_turns;
  arrow_r = radii(arrow_turn);
  arrow_t = 2 * pi * (arrow_turn - 0.5);
  draw_tangent_arrow(arrow_r, arrow_t, accent_color);

  if num_turns == 1
    title('kn = 1  (one clockwise turn)');
    formula = 'e^{-j2π} = 1';
  else
    title('kn = 2  (two clockwise turns)');
    formula = 'e^{-j4π} = 1';
  end

  text(0.02, 0.98, formula, 'Units', 'normalized', ...
    'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', ...
    'FontSize', 8.5, 'Color', accent_color);

  xlim([-1.22, 1.32]);
  ylim([-1.12, 1.12]);
  xlabel('Re');
  ylabel('Im');

  loose = get(gca, 'LooseInset');
  set(gca, 'LooseInset', [loose(1), max(loose(2), 0.12), loose(3), loose(4)]);
end

function draw_tangent_arrow(r, t, color)
  x = r * cos(t);
  y = -r * sin(t);
  dx = -r * sin(t);
  dy = -r * cos(t);
  scale = 0.22 / hypot(dx, dy);
  quiver(x, y, dx * scale, dy * scale, 0, ...
    'Color', color, 'LineWidth', 1.05, 'MaxHeadSize', 1.1);
end

plot_exp_j2pi_kn();
