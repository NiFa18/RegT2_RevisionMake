SHELL=bash
TARGET=RegT2.pdf
LL=latexmk -pdf -pdflatex="pdflatex --shell-escape %O %S"
CLEAN=latexmk -C
export PATH := pygments:${PATH}


all: revisionMake $(TARGET)

revisionMake:
	echo "% Autogenerated, do not edit" > revision.tex
	echo "\\newcommand{\\revisiondate}{`git log -1 --format=\"%ad\" --date=short`}" >> revision.tex
	echo "\\newcommand{\\revision}{`git log -1 --format=\"%h\"`}" >> revision.tex

$(TARGET): $(TARGET:%.pdf=%.tex)
	$(LL) $<
	rm -f revision.tex

clean:
	$(CLEAN)
	rm -f revision.tex
