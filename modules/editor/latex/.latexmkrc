# Configuración de latexmk para proyectos LaTeX
# Comandos predeterminados para compilación PDF
# latexmk -pdf -interaction=nonstopmode -synctex=1
$pdflatex = 'pdflatex %O %S';
$bibtex = 'bibtex %O %B';

# Generar también archivos synctex comprimidos
push @generated_exts, 'synctex.gz';
