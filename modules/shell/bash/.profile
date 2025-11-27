# ~/.profile
# Archivo para shells de login (ej. ssh).
# Normalmente se usa para cargar la configuración interactiva desde .bashrc

# Cargar .bashrc si existe, para mantener una sola fuente de verdad
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

## LOCAL – configuraciones de idioma
# Estos valores aseguran que los programas usen UTF-8 y soporten caracteres
# hispano-latinos (ñ, acentos, signos de puntuación invertidos).
export LANG=es_CL.UTF-8
export LC_ALL=es_CL.UTF-8
export LC_CTYPE=es_CL.UTF-8
