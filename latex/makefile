# Makefile for latexmk
source_name = essay-name

# Makes sure latexmk always runs
.PHONY: $(source_name).pdf all clean
all: $(source_name).pdf

# MAIN LATEXMK RULE
$(source_name).pdf: $(source_name).tex
	latexmk -pdf -xelatex -use-make $<

clean:
	latexmk -c

delete:
	latexmk -C
