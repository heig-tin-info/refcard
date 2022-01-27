SRC=refcard.tex 

all: $(SRC:.tex=.pdf) preview.png

%.pdf: %.tex | revision.tex
	latexmk $<

revision.tex:
	echo "% Autogenerated, do not edit" > $@
	echo "\\\\newcommand{\\\\revisiondate}{`git log -1 --format=\"%ad\" --date=short`}" >> $@
	echo "\\\\newcommand{\\\\revision}{`git describe`}" >> $@

underlay.pdf: underlay.tex
	latexmk $<

preview.pdf: $(SRC:.tex=.pdf) underlay.pdf
	qpdf $< --underlay underlay.pdf -- $@

%.png: %.pdf
	gs -dSAFER -r150 -sDEVICE=pngalpha -o $@ $<

clean:
	latexmk -C
	$(RM) *.log *.fls *.aux *.fdb_latexmk *.pdf *.xdv revision.tex $(SRC:.tex=.pdf)

.PHONY: clean
