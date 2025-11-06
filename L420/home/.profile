# ~/.profile
# Carga .bashrc en shells login (ssh, etc.)

if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# Locale latino
export LANG=es_CL.UTF-8
export LC_ALL=es_CL.UTF-8
export LC_CTYPE=es_CL.UTF-8
