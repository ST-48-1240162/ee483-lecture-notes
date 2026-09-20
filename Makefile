TEXFILES  := $(wildcard lecture*.tex)
FULLPDFS  := $(TEXFILES:.tex=.pdf)
CLEANPDFS := $(TEXFILES:.tex=_clean.pdf)
PDFS      := $(FULLPDFS) $(CLEANPDFS)

.PHONY: all notes clean lecture1 lecture2 lecture3 lecture4

all: $(PDFS)

# Notes only (no textbook excerpts or scans). This is what CI builds.
notes: $(CLEANPDFS)

lecture1: lecture1_0825.pdf lecture1_0825_clean.pdf
lecture2: lecture2_0827.pdf lecture2_0827_clean.pdf
lecture3: lecture3_0901.pdf lecture3_0901_clean.pdf
lecture4: lecture4_0903.pdf lecture4_0903_clean.pdf

# Full: lecture notes + textbook excerpt + handwritten lecture note scan
%.pdf: %.tex lecturenote.sty
	xelatex -interaction=nonstopmode $*
	xelatex -interaction=nonstopmode $*

# Clean: lecture notes only (no appendices)
%_clean.pdf: %.tex lecturenote.sty
	xelatex -interaction=nonstopmode -jobname=$*_clean "\def\HandoutCleanBuild{}\input{$*.tex}"
	xelatex -interaction=nonstopmode -jobname=$*_clean "\def\HandoutCleanBuild{}\input{$*.tex}"

clean:
	rm -f *.aux *.log *.out
