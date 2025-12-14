#!/bin/sh
# .Xsession - Variante con mayúscula de .xsession
# Algunos display managers buscan este archivo en lugar de .xsession

# Simplemente ejecutar .xsession si existe
if [ -f ~/.xsession ]; then
    exec ~/.xsession 
else
    # Fallback: ejecutar twm
    exec twm
fi
