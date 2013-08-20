SHELL=bash
TARGET=RegT2.pdf
SRC=
LL=latexmk -pdf -pdflatex="pdflatex --shell-escape %O %S"
CLEAN=latexmk -C


all: revisionMake $(TARGET) revisionRevert

revisionMake:
	echo "% Autogenerated, do not edit" > revision.tex
	echo "\\newcommand{\\revisiondate}{`git log -1 --format=\"%ad\" --date=short`}" >> revision.tex
	echo "\\newcommand{\\revision}{`git log -1 --format=\"%h\"`}" >> revision.tex

$(TARGET): $(TARGET:%.pdf=%.tex) $(SRC)
	$(LL) $<

revisionRevert: revision.tex
	rm -f revision.tex
	git clean -e $(TARGET) -x -f -d

clean:
	$(CLEAN)
	rm -f revision.tex
	git clean -X -f -d