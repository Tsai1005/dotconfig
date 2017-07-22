#!/bin/sh

#-----------------------Parser Makefile---------------------------------
OBJ=Makefile
if [ ! -f $OBJ ]; then
    echo "No target Makefile for parser"
    exit;
fi

TARGET_CPU=$(grep 'PLATFORM' $OBJ | awk -F= '{print $2}')
TARGET_DIR=apps

DIR=.
#-----------------------Create Clang Completer Database---------------------------------
echo reloading Dir : $TARGET_DIR / CPU : $TARGET_CPU project ...

echo "Syncing ... apps";
bear make -j dry_run > /dev/null 2>&1;

# /opt/utils/remove_db_target compile_commands.json compile_commands.json
# echo ${DIR}
# echo ${TARGET_CPU}


find ${DIR} -path "${DIR}/${TARGET_DIR}/cpu/*" ! -path "${DIR}/${TARGET_DIR}/cpu/${TARGET_CPU}*" -prune -o \
    -path "${DIR}/${TARGET_DIR}/include/cpu/*" ! -path "${DIR}/${TARGET_DIR}/include/cpu/${TARGET_CPU}*" -prune -o \
    -path "${DIR}/include_lib/cpu/*" ! -path "${DIR}/include_lib/cpu/${TARGET_CPU}*" -prune -o \
    -path "${DIR}/libs/cpu/*" ! -path "${DIR}/libs/cpu/${TARGET_CPU}*" -prune -o \
    -path "${DIR}/libs/btstack/Baseband/BLE/*" ! -path "${DIR}/libs/btstack/Baseband/BLE/${TARGET_CPU}*" -prune -o \
    -path "${DIR}/libs/btstack/Baseband/common/*" ! -path "${DIR}/libs/btstack/Baseband/common/${TARGET_CPU}*" -prune -o \
    -path "${DIR}/libs/btstack/Baseband/include/ble/*" ! -path "${DIR}/libs/btstack/Baseband/include/ble/${TARGET_CPU}*" -prune -o \
    -path "${DIR}/libs/btstack/Baseband/include/common/*" ! -path "${DIR}/libs/btstack/Baseband/include/common/${TARGET_CPU}*" -prune -o \
    -path "${DIR}/tools*" -prune -o \
    -name "*.[Sch]" -print > cscope.files


# ----------- lookup file
export FIND_EXCEPT="find . ! -path "*git*" ! -path "*bt16*" ! -path "*br16*" ! -path "*bt16*" ! -path "*br17*" ! -path "*br18*""

# ctags -R --fields=+lS --languages=+Asm --exclude ${exclude_dir}
ctags -R --fields=+lS --languages=+Asm 

# ----------- cscope
cscope -bR

# ----------- lookup file
echo -e "!_TAG_FILE_SORTED\t2\t/2=foldcase/">filenametags

${FIND_EXCEPT} -not -regex '.*\.\(png\|gif\|o\|d\|obj\)' -type f -printf "%f\t%p\t1\n" | sort -f>>filenametags
