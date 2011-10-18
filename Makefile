# Makefile 
# Creado para ahorrar un poco el trabajo. 
# Walter Vargas <walter@covetel.com.ve>

DIR=Documentos/${DOC}
DIR_LATEX=${DIR}/build/latex
all: chapters html latex clean-glosario glosario document clean

document: Documentos/${DOC}/build/pdf/${DOC}.pdf

Documentos/${DOC}/build/pdf/${DOC}.pdf: Documentos/${DOC}/build/latex/*.tex
	pdflatex -output-directory Documentos/${DOC}/build/latex ${DOC}.tex
	#cd Documentos/${DOC}/build/latex/; makeglossaries ${DOC}
	pdflatex -output-directory Documentos/${DOC}/build/latex ${DOC}.tex
	mv Documentos/${DOC}/build/latex/${DOC}.pdf Documentos/${DOC}/build/pdf/

Documentos/${DOC}/build/latex/glosario.tex: glosario

chapters: Documentos/${DOC}/src/*.pod 
	perl tools/build_chapters.pl ${DOC}

glosario: Documentos/${DOC}/build/latex/*.tex
	perl tools/gen_glosario.pl ${DOC}

clean-glosario:
	rm -f Documentos/${DOC}/build/latex/glosario.tex 

latex:
	perl tools/build_latex.pl ${DOC}

html: 
#	perl tools/build_html.pl ${DOC}

clean: 
	cd ${DIR_LATEX}; rm -f *.aux *.log *.out *.ps *.toc *.nav *.snm *.dvi;

clean-all:
	for doc in $(ls Documentos); do DOC=$doc make clean ; done

clean-all-html: 
	for doc in $(ls Documentos); do rm -f -v Documentos/$doc/build/html/*.html; done

help: ayuda

ayuda:
	perldoc LEEME
