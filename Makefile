.PHONY: all clean

all : clean thesis.pdf

thesis.pdf : thesis.tex
	@echo -n "Generating PDF"
	@pdflatex thesis  > /dev/null
	@echo -n ".........."
# @bibtex DSL  > /dev/null
# @echo -n ".........."
	@pdflatex thesis  > /dev/null
	@echo -n ".........."	
	@pdflatex thesis  > /dev/null
	@echo ".......... DONE !"



clean :
	@echo -n "Cleaning ............................................."
	@rm -rf  *.pdf *.aux *.log *.out *.toc *.bbl *.blg *.lof *~ *.mt* *.idx *.maf body/*.pdf body/*.aux body/*.log body/*.out body/*.toc body/*.bbl body/*.blg body/*.lof body/*~
	@echo " DONE !"

