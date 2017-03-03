#!/bin/sh

# ----------- ctags
# export exclude_dir

# if [ $1 = "br17" ]
# then 
    # exclude_dir=$(find -name br16)
# fi

# if [ $1 = "br16" ]
# then 
    # exclude_dir=$(find -name br17)
# fi

# echo ${exclude_dir}


# ctags -R --fields=+lS --languages=+Asm --exclude ${exclude_dir}
# ctags -R --fields=+lS --languages=+Asm 

# ----------- cscope
DIR=.
export TARGET=br17
export TARGET_APPS=apps

# echo ${DIR}
# echo ${TARGET}

echo reloading ${TARGET} - ${TARGET_APPS} project ...

find ${DIR} -path "${DIR}/${TARGET_APPS}/cpu/*" ! -path "${DIR}/${TARGET_APPS}/cpu/${TARGET}*" -prune -o \
    -path "${DIR}/${TARGET_APPS}/include/cpu/*" ! -path "${DIR}/${TARGET_APPS}/include/cpu/${TARGET}*" -prune -o \
    -path "${DIR}/include_lib/cpu/*" ! -path "${DIR}/include_lib/cpu/${TARGET}*" -prune -o \
    -path "${DIR}/libs/cpu/*" ! -path "${DIR}/libs/cpu/${TARGET}*" -prune -o \
    -path "${DIR}/libs/btstack/Baseband/BLE/*" ! -path "${DIR}/libs/btstack/Baseband/BLE/${TARGET}*" -prune -o \
    -path "${DIR}/libs/btstack/Baseband/common/*" ! -path "${DIR}/libs/btstack/Baseband/common/${TARGET}*" -prune -o \
    -path "${DIR}/tools*" -prune -o \
    -name "*.[Sch]" -print > cscope.files


# find ${DIR} ! -path "*br17*" ! -path "${DIR}/target" ! -path "${DIR}/libs/ac461x_uboot_lib" \
    # -name "*.[Sch]" -print > cscope.filess

# find ${PROJECT} -name "*.[Sch]" -print > cscope.files

# export PROJECT=$(find -path "${DIR}/apps/cpu/br17*" -prune -a -type d -print)
# export PROJECT=$(find -path "${DIR}/target" -prune -o -type d -print)

# echo ${PROJECT} > project_path.txt
# find ${PROJECT} -name "*.[Sch]" -print >> project_path.txt

# ----------- lookup file
export EXCEPT=br16
export FIND_EXCEPT="find . ! -path "*git*" ! -path "*bt16*" ! -path "*br16*""

# ctags -R --fields=+lS --languages=+Asm --exclude ${exclude_dir}
ctags -R --fields=+lS --languages=+Asm 

# ----------- cscope

cscope -bR


# ----------- lookup file
echo -e "!_TAG_FILE_SORTED\t2\t/2=foldcase/">filenametags

${FIND_EXCEPT} -not -regex '.*\.\(png\|gif\|o\|d\|obj\)' -type f -printf "%f\t%p\t1\n" | sort -f>>filenametags
