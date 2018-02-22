.PHONY: all clean

all : clean thesis.pdf

thesis.pdf : thesis.tex
	@echo -n "Generating PDF"
	@pdflatex thesis  > /dev/null
	@echo -n ".........."
	@biber thesis  > /dev/null
	@echo -n ".........."
	@pdflatex thesis  > /dev/null
	@echo -n ".........."	
	@pdflatex thesis  > /dev/null
	@echo ".......... DONE !"



clean :
	@echo -n "Cleaning ............................................."
	@rm -rf  *.pdf *.aux *.log *.out *.toc *.bbl *.blg *.lof *.lot *.ind *~ *.mt* *.idx *.maf thesis-blx.bib *.bcf thesis.run.xml body/*.pdf body/*.aux body/*.log body/*.out body/*.toc body/*.bbl body/*.blg body/*.lof body/*~
	@echo " DONE !"

