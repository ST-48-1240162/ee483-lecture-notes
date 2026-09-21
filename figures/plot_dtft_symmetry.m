% DTFT symmetry for a real rectangular window: |X| even, angle X odd (Mitra Table 3.1).
% Usage (from repo root): octave figures/plot_dtft_symmetry.m

function plot_dtft_symmetry()
  out_dir = fileparts(mfilename('fullpath'));
  out_pdf = fullfile(out_dir, 'dtft_symmetry.pdf');

  N = 8;
  fig_w = 5.8;
  fig_h = 2.45;
  figure('visible', 'off', 'color', 'w', 'units', 'inches', 'position', [0, 0, fig_w, fig_h]);

  w = linspace(-pi + 0.06, pi - 0.06, 3200);
  mag = dirichlet_mag(w, N);
  phase = -w * (N - 1) / 2;

  w0 = pi / 4;
  idx_pos = find(abs(w - w0) < 0.02, 1, 'first');
  idx_neg = find(abs(w + w0) < 0.02, 1, 'first');

  ax_mag = axes('Position', [0.08, 0.28, 0.40, 0.62]);
  draw_mag_panel(ax_mag, w, mag, w0, idx_pos, idx_neg, N);

  ax_phase = axes('Position', [0.54, 0.28, 0.40, 0.62]);
  draw_phase_panel(ax_phase, w, phase, w0, idx_pos, idx_neg, N);

  add_caption(ax_mag, ...
    {sprintf('Real window, N = %d  (even)', N); '|X(+ω_0)| = |X(-ω_0)|'});
  add_caption(ax_phase, ...
    {'linear phase  (odd)'; '∠X(+ω_0) = -∠X(-ω_0)'});

  set(gcf, 'PaperUnits', 'inches', 'PaperSize', [fig_w, fig_h], ...
    'PaperPosition', [0, 0, fig_w, fig_h]);

  print(out_pdf, '-dpdf', '-painters');
  fprintf('Wrote %s\n', out_pdf);
end

function draw_mag_panel(ax, w, mag, w0, idx_pos, idx_neg, N)
  axes(ax);
  hold on;
  grid on;
  plot(w, mag);
  xline(0, '--');
  xline(w0, '--');
  xline(-w0, '--');
  plot(w0, mag(idx_pos), 'o');
  plot(-w0, mag(idx_neg), 'o');
  ylim([0, N * 1.12]);
  xlim([-pi, pi]);
  xticks([-pi, -pi / 2, 0, pi / 2, pi]);
  xticklabels({'-π', '-π/2', '0', 'π/2', 'π'});
  xlabel('ω');
  ylabel('|X(e^{j\omega})|');
end

function draw_phase_panel(ax, w, phase, w0, idx_pos, idx_neg, N)
  axes(ax);
  hold on;
  grid on;
  plot(w, phase);
  xline(0, '--');
  xline(w0, '--');
  xline(-w0, '--');
  plot(w0, phase(idx_pos), 'o');
  plot(-w0, phase(idx_neg), 'o');
  phase_lim = pi * (N - 1) / 2 * 1.08;
  ylim([-phase_lim, phase_lim]);
  xlim([-pi, pi]);
  xticks([-pi, -pi / 2, 0, pi / 2, pi]);
  xticklabels({'-π', '-π/2', '0', 'π/2', 'π'});
  xlabel('ω');
  ylabel('∠X(e^{j\omega})');
end

function add_caption(ax, lines)
  pos = get(ax, 'Position');
  xmid = pos(1) + pos(3) / 2;
  y1 = pos(2) - 0.045;
  y2 = pos(2) - 0.115;
  annotation('textbox', [xmid - pos(3) / 2, y1, pos(3), 0.05], ...
    'String', lines{1}, 'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'top');
  annotation('textbox', [xmid - pos(3) / 2, y2, pos(3), 0.05], ...
    'String', lines{2}, 'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'top');
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

plot_dtft_symmetry();
