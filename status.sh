#!/bin/dash
#  
# 

# Fecha
 DATE="`date '+%a %d %b %Y'`"
# Hora 
 HOUR="`date '+%H:%M:%S'`"
# Procesador
 CPU0=$(eval $(awk '/^cpu0 /{print "previdle=" $5 "; prevtotal=" $2+$3+$4+$5 }' /proc/stat);
          sleep 0.4;
          eval $(awk '/^cpu0 /{print "idle=" $5 "; total=" $2+$3+$4+$5 }' /proc/stat);
          intervaltotal=$((total-${prevtotal:-0}));
          echo "$((100*( (intervaltotal) - ($idle-${previdle:-0}) ) / (intervaltotal) ))")
# Mem.
 MEM="`free -m | grep "buffers/" | awk {'print $3'}`"
# Vol. 
 VOL=`amixer | grep "PCM" -A 5 | grep -o "\[.*%" | sed "s/\[//" | sed 's/%//'` 
#

#Finish
 wmfs -s "\\#cccccc\\CPU ¤ \\#ffffff\\$CPU0 %  · \\#cccccc\MEM ¤ \\#ffffff\\$MEM MB · \\#cccccc\\VOL ¤ \\#ffffff\\$VOL%\\#ffffff\\ · \\#cccccc\\$DATE\\#ffffff\\ · \\#cccccc\\$HOUR" 
 
 
