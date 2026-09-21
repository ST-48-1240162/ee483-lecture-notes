TEXFILES  := $(wildcard lecture*.tex)
FULLPDFS  := $(TEXFILES:.tex=.pdf)
CLEANPDFS := $(sort $(TEXFILES:.tex=_clean.pdf))
PDFS      := $(FULLPDFS) $(CLEANPDFS)
COMPILATION_PDF := pdf/ee483_lectures_clean.pdf

.PHONY: all notes notes-compilation compilation clean lecture1 lecture2 lecture3 lecture4 lecture5

all: $(PDFS)

# Notes only (no textbook excerpts or scans). This is what CI builds.
notes: $(CLEANPDFS)

# All lectures in one PDF (clean builds) with title page and TOC.
notes-compilation compilation: $(COMPILATION_PDF)

$(COMPILATION_PDF): $(TEXFILES) ee483_lectures_clean.tex ee483_compilation_cover.tex handout_subfiles_root.tex lecturenote.sty | pdf
	-xelatex -interaction=nonstopmode -jobname=ee483_lectures_clean ee483_lectures_clean.tex
	-xelatex -interaction=nonstopmode -jobname=ee483_lectures_clean ee483_lectures_clean.tex
	-xelatex -interaction=nonstopmode -jobname=ee483_lectures_clean ee483_lectures_clean.tex
	test -f ee483_lectures_clean.pdf
	mv -f ee483_lectures_clean.pdf $@
	@echo "Updated $(COMPILATION_PDF)"

lecture1: lecture1_0825.pdf lecture1_0825_clean.pdf
lecture2: lecture2_0827.pdf lecture2_0827_clean.pdf
lecture3: lecture3_0901.pdf lecture3_0901_clean.pdf
lecture4: lecture4_0903.pdf lecture4_0903_clean.pdf
lecture5: lecture5_0908.pdf lecture5_0908_clean.pdf

# Full: lecture notes + textbook excerpt + handwritten lecture note scan
%.pdf: %.tex lecturenote.sty
	xelatex -interaction=nonstopmode $*
	xelatex -interaction=nonstopmode $*

# Clean: lecture notes only (no appendices)
%_clean.pdf: %.tex lecturenote.sty
	xelatex -interaction=nonstopmode -jobname=$*_clean "\def\HandoutCleanBuild{}\input{$*.tex}"
	xelatex -interaction=nonstopmode -jobname=$*_clean "\def\HandoutCleanBuild{}\input{$*.tex}"

pdf:
	mkdir -p pdf

clean:
	rm -f *.aux *.log *.out ee483_lectures_clean.aux ee483_lectures_clean.log ee483_lectures_clean.out ee483_lectures_clean.toc
