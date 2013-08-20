SHELL=bash
TARGET=RegT2.pdf
LL=latexmk -pdf -pdflatex="pdflatex --shell-escape %O %S"
CLEAN=latexmk -C
export PATH := pygments:${PATH}


all: revisionMake $(TARGET) revisionRevert

revisionMake:
	echo "% Autogenerated, do not edit" > revision.tex
	echo "\\newcommand{\\revisiondate}{`git log -1 --format=\"%ad\" --date=short`}" >> revision.tex
	echo "\\newcommand{\\revision}{`git log -1 --format=\"%h\"`}" >> revision.tex

$(TARGET): $(TARGET:%.pdf=%.tex) $(SRC)
	$(LL) $<

revisionRevert:
	echo "% Autogenerated, do not edit" > revision.tex
	echo "\\newcommand{\\revisiondate}{`git log -1 --format=\"%ad\" --date=short`}" >> revision.tex
	echo "\\newcommand{\\revision}{`git log -1 --format=\"%h\"`}" >> revision.tex

clean:
	$(CLEAN)
	rm -f revision.tex

mupdf:
	mupdf $(TARGET) &

zathura:
	zathura $(TARGET) &


# vim: set tabstop=4 shiftwidth=4 noexpandtab:
