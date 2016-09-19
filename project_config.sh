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
export EXCEPT=br16
# echo ${DIR}
# echo ${TARGET}

echo reloading ${TARGET} project ...

find ${DIR} -path "${DIR}/apps/cpu/*" ! -path "${DIR}/apps/cpu/${TARGET}*" -prune -o \
    -path "${DIR}/apps/include/cpu/*" ! -path "${DIR}/apps/include/cpu/${TARGET}*" -prune -o \
    -path "${DIR}/include_lib/cpu/*" ! -path "${DIR}/include_lib/cpu/${TARGET}*" -prune -o \
    -path "${DIR}/libs/cpu/*" ! -path "${DIR}/libs/cpu/${TARGET}*" -prune -o \
    -path "${DIR}/libs/ac461x_uboot_lib" -prune -o \
    -path "${DIR}/target" -prune -o \
    -name "*.[Sch]" -print > cscope.files


# find ${DIR} ! -path "*br17*" ! -path "${DIR}/target" ! -path "${DIR}/libs/ac461x_uboot_lib" \
    # -name "*.[Sch]" -print > cscope.filess

# find ${PROJECT} -name "*.[Sch]" -print > cscope.files

# export PROJECT=$(find -path "${DIR}/apps/cpu/br17*" -prune -a -type d -print)
# export PROJECT=$(find -path "${DIR}/target" -prune -o -type d -print)

# echo ${PROJECT} > project_path.txt
# find ${PROJECT} -name "*.[Sch]" -print >> project_path.txt

# ----------- lookup file

bash sync.sh
