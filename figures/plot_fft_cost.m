% Plot the operation counts N^2 (direct DFT), N*log2(N) (radix-2 FFT) and N,
% with the radix-2 sizes N = 2^M marked on each curve.
% Usage (from repo root): octave figures/plot_fft_cost.m

function plot_fft_cost()
  out_dir = fileparts(mfilename('fullpath'));
  out_pdf = fullfile(out_dir, 'fft_cost.pdf');

  ink_color = [0.15, 0.15, 0.15];
  accent_color = [40, 90, 145] / 255;  % ee483link (handout hyperlink accent)
  rule_color = [0.55, 0.55, 0.55];

  figure('visible', 'off', 'color', 'w', 'units', 'inches', 'position', [0, 0, 4.2, 2.6]);
  % Must be the full Fontconfig name; 'Latin Modern Roman' falls back to Noto Sans.
  plot_font = 'TeX Gyre Pagella';
  set(0, 'defaulttextinterpreter', 'none');
  set(0, 'defaultaxesfontname', plot_font);
  set(0, 'defaulttextfontname', plot_font);

  N = linspace(1, 16, 400);
  Nk = 2 .^ (1:4);  % radix-2 sizes N = 2^M

  hold on;
  box on;
  plot(N, N .^ 2, 'Color', ink_color, 'LineWidth', 1.35);
  plot(N, N .* log2(N), 'Color', accent_color, 'LineWidth', 1.35);
  plot(N, N, 'Color', rule_color, 'LineWidth', 1.1);

  plot(Nk, Nk .^ 2, 'o', 'MarkerSize', 4, 'MarkerFaceColor', ink_color, 'MarkerEdgeColor', ink_color);
  plot(Nk, Nk .* log2(Nk), 'o', 'MarkerSize', 4, 'MarkerFaceColor', accent_color, 'MarkerEdgeColor', accent_color);
  plot(Nk, Nk, 'o', 'MarkerSize', 4, 'MarkerFaceColor', rule_color, 'MarkerEdgeColor', rule_color);

  text(16.3, 256, 'N²', 'FontSize', 10, 'Color', ink_color, 'VerticalAlignment', 'middle');
  text(16.3, 64, 'N log₂ N', 'FontSize', 10, 'Color', accent_color, 'VerticalAlignment', 'middle');
  text(16.3, 16, 'N', 'FontSize', 10, 'Color', rule_color, 'VerticalAlignment', 'middle');

  xlim([0, 16]);
  ylim([0, 270]);
  xticks([1, 2, 4, 8, 16]);
  yticks(0:64:256);
  xlabel('N');
  ylabel('operations');
  grid on;
  set(gca, 'GridAlpha', 0.18, 'FontSize', 9, 'LineWidth', 0.6);

  loose = get(gca, 'LooseInset');
  set(gca, 'LooseInset', [loose(1), loose(2), max(loose(3), 0.16), loose(4)]);

  set(gcf, 'PaperUnits', 'inches', 'PaperSize', [4.2, 2.6], ...
    'PaperPosition', [0, 0, 4.2, 2.6]);

  print(out_pdf, '-dpdf', '-painters');
  fprintf('Wrote %s\n', out_pdf);
end

plot_fft_cost();
