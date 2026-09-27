TEXFILES  := $(wildcard lecture*.tex)
FULLPDFS  := $(TEXFILES:.tex=.pdf)
CLEANPDFS := $(sort $(TEXFILES:.tex=_clean.pdf))
PDFS      := $(FULLPDFS) $(CLEANPDFS)
COMPILATION_PDF := pdf/ee483_lectures_clean.pdf

# README links in pdf/ (copied from generated *_clean.pdf; do not edit by hand).
PUBLISHED_NOTES := \
	pdf/lecture01_signals_analog_discrete_digital.pdf \
	pdf/lecture02_systems_continuous_to_discrete.pdf \
	pdf/lecture03_properties_discrete_time_systems.pdf \
	pdf/lecture04_convolution_system_properties_difference_equations.pdf \
	pdf/lecture05_discrete_time_fourier_transform.pdf \
	pdf/lecture06_dtft_fourier_series.pdf \
	pdf/lecture07_linear_phase_filters.pdf \
	pdf/lecture08_discrete_fourier_transform.pdf

.PHONY: all notes notes-compilation compilation publish-notes clean lecture1 lecture2 lecture3 lecture4 lecture5 lecture6 lecture7 lecture8

all: $(PDFS)

# Notes only (no textbook excerpts or scans). This is what CI builds.
notes: $(CLEANPDFS) publish-notes

# All lectures in one PDF (clean builds) with title page and TOC.
notes-compilation compilation: $(COMPILATION_PDF)

$(COMPILATION_PDF): $(TEXFILES) ee483_lectures_clean.tex ee483_compilation_cover.tex handout_subfiles_root.tex lecturenote.sty | pdf
	-xelatex -interaction=nonstopmode -jobname=ee483_lectures_clean ee483_lectures_clean.tex
	-xelatex -interaction=nonstopmode -jobname=ee483_lectures_clean ee483_lectures_clean.tex
	-xelatex -interaction=nonstopmode -jobname=ee483_lectures_clean ee483_lectures_clean.tex
	test -f ee483_lectures_clean.pdf
	mv -f ee483_lectures_clean.pdf $@
	@echo "Updated $(COMPILATION_PDF)"

lecture1: lecture1_0825.pdf lecture1_0825_clean.pdf pdf/lecture01_signals_analog_discrete_digital.pdf
lecture2: lecture2_0827.pdf lecture2_0827_clean.pdf pdf/lecture02_systems_continuous_to_discrete.pdf
lecture3: lecture3_0901.pdf lecture3_0901_clean.pdf pdf/lecture03_properties_discrete_time_systems.pdf
lecture4: lecture4_0903.pdf lecture4_0903_clean.pdf pdf/lecture04_convolution_system_properties_difference_equations.pdf
lecture5: lecture5_0908.pdf lecture5_0908_clean.pdf pdf/lecture05_discrete_time_fourier_transform.pdf
lecture6: lecture6_0910.pdf lecture6_0910_clean.pdf pdf/lecture06_dtft_fourier_series.pdf
lecture7: lecture7_0915.pdf lecture7_0915_clean.pdf pdf/lecture07_linear_phase_filters.pdf
lecture8: lecture8_0917.pdf lecture8_0917_clean.pdf pdf/lecture08_discrete_fourier_transform.pdf

publish-notes: $(PUBLISHED_NOTES)

pdf/lecture01_signals_analog_discrete_digital.pdf: lecture1_0825_clean.pdf | pdf
	cp -f $< $@
pdf/lecture02_systems_continuous_to_discrete.pdf: lecture2_0827_clean.pdf | pdf
	cp -f $< $@
pdf/lecture03_properties_discrete_time_systems.pdf: lecture3_0901_clean.pdf | pdf
	cp -f $< $@
pdf/lecture04_convolution_system_properties_difference_equations.pdf: lecture4_0903_clean.pdf | pdf
	cp -f $< $@
pdf/lecture05_discrete_time_fourier_transform.pdf: lecture5_0908_clean.pdf | pdf
	cp -f $< $@
pdf/lecture06_dtft_fourier_series.pdf: lecture6_0910_clean.pdf | pdf
	cp -f $< $@
pdf/lecture07_linear_phase_filters.pdf: lecture7_0915_clean.pdf | pdf
	cp -f $< $@
pdf/lecture08_discrete_fourier_transform.pdf: lecture8_0917_clean.pdf | pdf
	cp -f $< $@

# Full: lecture notes + textbook excerpt + handwritten lecture note scan
%.pdf: %.tex lecturenote.sty
	xelatex -interaction=nonstopmode $*
	xelatex -interaction=nonstopmode $*

# Clean: lecture notes only (no appendices)
%_clean.pdf: %.tex lecturenote.sty handout_subfiles_root.tex
	-xelatex -interaction=nonstopmode -jobname=$*_clean "\def\HandoutCleanBuild{}\input{$*.tex}"
	-xelatex -interaction=nonstopmode -jobname=$*_clean "\def\HandoutCleanBuild{}\input{$*.tex}"
	test -f $@

pdf:
	mkdir -p pdf

clean:
	rm -f *.aux *.log *.out ee483_lectures_clean.aux ee483_lectures_clean.log ee483_lectures_clean.out ee483_lectures_clean.toc
