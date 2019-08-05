all: refcard.tex
	latexmk -pdf -xelatex $<