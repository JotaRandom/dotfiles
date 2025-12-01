## latexmk configuration for LaTeX projects
latexmk -pdf -interaction=nonstopmode -synctex=1

## Objetivo por defecto
$pdflatex = 'pdflatex %O %S';
$bibtex = 'bibtex %O %B';

# Asegúrate de que la opción -output-directory sea soportada
push @generated_exts, 'synctex.gz';
