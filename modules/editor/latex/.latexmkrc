## latexmk configuration for LaTeX projects
latexmk -pdf -interaction=nonstopmode -synctex=1

## Default target
$pdflatex = 'pdflatex %O %S';
$bibtex = 'bibtex %O %B';

# Ensure the -output-directory option is supported
push @generated_exts, 'synctex.gz';
