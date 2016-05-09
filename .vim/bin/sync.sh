#!/bin/sh
#ctags -R --fields=+lS --languages=+Asm
#cscope -bR
/cygdrive/d/cygwin64/bin/echo -e "!_TAG_FILE_SORTED\t2\t/2=foldcase/">filenametags
/cygdrive/d/cygwin64/bin/find . -not -regex '.*\.\(png\|gif\|o\|d\|obj\)'  ! -path "*git*" -type f -printf "%f\t%p\t1\n" | /cygdrive/d/cygwin64/bin/sort -f>>filenametags