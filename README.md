# EE 483 Lecture Notes

Typeset notes for [EE 483: Introduction to Digital Signal Processing](https://catalogue.usc.edu/preview_course_nopop.php?catoid=21&coid=330713) at USC (Fall 2026).

| | |
|---|---|
| Instructor | Prof. Justin Haldar |
| Textbooks | Mitra, *Digital Signal Processing*, 4th ed.; Hayes, *Schaum's Outline of DSP*, 2nd ed. |

Unofficial student notes. Not endorsed by USC or the instructor.

## Lectures

PDFs in [`pdf/`](pdf/) are clean builds (notes only, no textbook pages or handwritten lecture note scans). ✅ = notes ready; 🚧 = still typesetting.

| # | Date | Topic | Refs | Status |
|---|------|-------|------|--------|
| [1](pdf/lecture01_signals_analog_discrete_digital.pdf) | Aug 25 | Signals: Analog, Discrete-Time, and Digital | Mitra 1; 2.1, 2.2, 2.4; Hayes 1.1 to 1.3 | ✅ |
| [2](pdf/lecture02_systems_continuous_to_discrete.pdf) | Aug 27 | Systems: From Continuous-Time to Discrete-Time | Mitra 4.1 to 4.4; Hayes 1.4 | ✅ |
| [3](pdf/lecture03_properties_discrete_time_systems.pdf) | Sep 1 | Properties of Discrete-Time Systems | Mitra 4.5 to 4.7; Hayes 1.5, 2.4 | ✅ |
| [4](pdf/lecture04_convolution_system_properties_difference_equations.pdf) | Sep 3 | Convolution, System Properties, and Difference Equations | Mitra 3.2, 3.3; Hayes 2.5, 2.6 | ✅ |
| [5](pdf/lecture05_discrete_time_fourier_transform.pdf) | Sep 8 | Discrete-Time Fourier Transform (DTFT) | Mitra 3.1, 3.2, 3.4, 4.8; Hayes 2.7 | ✅ |
| — | — | [Collected edition (lectures 1–5)](pdf/ee483_lectures_clean.pdf) | — | ✅ |
| 6 | Sep 10 | DTFT and Fourier Series | Mitra 3.6, 3.7, 4.6.4, 4.8, 4.9; Hayes 2.7, 5.3 | 🚧 |
| 7 | Sep 15 | Linear Phase Filters | Mitra 5.2; Hayes 6 | 🚧 |
| 8 | Sep 17 | Discrete Fourier Transform (DFT) | Mitra 5.4, 5.5, 5.7, 11.3 to 11.5; Hayes 6 to 7 | 🚧 |

## Repository layout

| Path | Contents |
|------|----------|
| `lecture*_*.tex` | Lecture sources (`lecturenote.sty` shared style) |
| `pdf/` | Clean PDFs linked from the table above |
| `figures/` | Plot scripts (Octave) and generated PDFs/images |
| `appendix/` | Shared LaTeX snippets (e.g. Mitra tables) |
| `scans/` | Handwritten lecture scans (local only; used in full builds) |

Full builds also pull textbook excerpts from `../../textbooks/` and scans from `scans/`.

## Build

Requires XeLaTeX (`fontspec`, `unicode-math`, `subfiles`, `tcolorbox`, …), TeX Gyre Pagella, and Latin Modern Math. The compilation cover subtitle uses USC Viterbi’s Adobe Caslon Pro when installed; otherwise Libre Baskerville or Baskervville.

```bash
make clean
make notes              # clean PDFs only (same as CI)
make notes-compilation  # one PDF: cover + lectures 1–5 → pdf/ee483_lectures_clean.pdf
make all                # full + clean PDFs for every lecture
make lecture5           # single lecture
```

Regenerate figures (Octave; outputs land in `figures/`):

```bash
octave figures/plot_dirichlet_zeros.m
octave figures/plot_dirichlet_periodic.m
octave figures/plot_dtft_symmetry.m
octave figures/plot_exp_j2pi_kn.m
```
