#!/bin/sh

#-----------------------Parser Makefile---------------------------------
OBJ=Makefile
if [ ! -f $OBJ ]; then
    echo "No target Makefile for parser"
    exit;
fi

TARGET_CPU=$(grep 'export SoC' $OBJ | awk -F= '{print $2}')
TARGET_DIR=apps

OBJ=tools/platform/Makefile.${TARGET_CPU}
TARGET_BOARD=$(grep 'export BOARD' $OBJ | awk -F= '{print $2}')

DIR=.
#-----------------------Create Clang Completer Database---------------------------------
echo reloading Dir :[$TARGET_DIR] / SoC :[$TARGET_CPU] / Board :[${TARGET_BOARD}] project ...

echo "Syncing ... apps";
bear make -j dry_run > /dev/null 2>&1;

/opt/utils/remove_db_target compile_commands.json compile_commands.json

#-----------------------Project Dir switch---------------------------------
find ${DIR} -path "${DIR}/${TARGET_DIR}/board/*" ! -path "${DIR}/${TARGET_DIR}/board/${TARGET_CPU}*" -prune -o \
    -path "${DIR}/${TARGET_DIR}/include/*" ! -path "${DIR}/${TARGET_DIR}/include/${TARGET_CPU}*" -prune -o \
    -path "${DIR}/${TARGET_DIR}/post_build/*" ! -path "${DIR}/${TARGET_DIR}/post_build/${TARGET_CPU}*" -prune -o \
    -path "${DIR}/include_lib/freertos/portable/*" ! -path "${DIR}/include_lib/freertos/portable/${TARGET_CPU}*" -prune -o \
    -path "${DIR}/include_lib/periphery/*" ! -path "${DIR}/include_lib/periphery/${TARGET_CPU}*" -prune -o \
    -path "${DIR}/include_lib/core/*" ! -path "${DIR}/include_lib/core/${TARGET_CPU}*" -prune -o \
    -path "${DIR}/libs/periphery/*" ! -path "${DIR}/libs/periphery/${TARGET_CPU}*" -prune -o \
    -path "${DIR}/libs/core/*" ! -path "${DIR}/libs/core/${TARGET_CPU}*" -prune -o \
    -path "${DIR}/libs/memory/port/*" ! -path "${DIR}/libs/memory/port/${TARGET_CPU}*" -prune -o \
    -path "${DIR}/libs/btstack/Baseband/BLE/*" ! -path "${DIR}/libs/btstack/Baseband/BLE/${TARGET_CPU}*" -prune -o \
    -path "${DIR}/libs/btstack/Baseband/Classic/*" ! -path "${DIR}/libs/btstack/Baseband/Classic/${TARGET_CPU}*" -prune -o \
    -path "${DIR}/libs/btstack/Baseband/common/*" ! -path "${DIR}/libs/btstack/Baseband/common/${TARGET_CPU}*" -prune -o \
    -path "${DIR}/libs/btstack/Baseband/include/ble/*" ! -path "${DIR}/libs/btstack/Baseband/include/ble/${TARGET_CPU}*" -prune -o \
    -path "${DIR}/libs/btstack/Baseband/include/classic/*" ! -path "${DIR}/libs/btstack/Baseband/include/classic/${TARGET_CPU}*" -prune -o \
    -path "${DIR}/libs/btstack/Baseband/include/common/*" ! -path "${DIR}/libs/btstack/Baseband/include/common/${TARGET_CPU}*" -prune -o \
    -path "${DIR}/libs/btstack/Controller/include/common/*" ! -path "${DIR}/libs/btstack/Controller/include/common/${TARGET_CPU}*" -prune -o \
    -path "${DIR}/libs/usbstack/code/common/*" ! -path "${DIR}/libs/usbstack/code/common/${TARGET_CPU}*" -prune -o \
    -path "${DIR}/tools*" -prune -o \
    -path "${DIR}/undodir*" -prune -o \
    -name "*.[Sch]" -print > cscope.files


# ----------- lookup file
export FIND_EXCEPT="find . -path "*${DIR}/${TARGET_DIR}/board/*" ! -path "*${DIR}/${TARGET_DIR}/board/${TARGET_CPU}*" -prune -o \
    -path "*${DIR}/${TARGET_DIR}/include/*" ! -path "*${DIR}/${TARGET_DIR}/include/${TARGET_CPU}*" -prune -o \
    -path "*${DIR}/${TARGET_DIR}/post_build/*" ! -path "*${DIR}/${TARGET_DIR}/post_build/${TARGET_CPU}*" -prune -o \
    -path "*${DIR}/include_lib/freertos/portable/*" ! -path "*${DIR}/include_lib/freertos/portable/${TARGET_CPU}*" -prune -o \
    -path "*${DIR}/include_lib/periphery/*" ! -path "*${DIR}/include_lib/periphery/${TARGET_CPU}*" -prune -o \
    -path "*${DIR}/include_lib/core/*" ! -path "*${DIR}/include_lib/core/${TARGET_CPU}*" -prune -o \
    -path "*${DIR}/libs/periphery/*" ! -path "*${DIR}/libs/periphery/${TARGET_CPU}*" -prune -o \
    -path "*${DIR}/libs/core/*" ! -path "*${DIR}/libs/core/${TARGET_CPU}*" -prune -o \
    -path "*${DIR}/libs/memory/port/*" ! -path "*${DIR}/libs/memory/port/${TARGET_CPU}*" -prune -o \
    -path "*${DIR}/libs/btstack/Baseband/BLE/*" ! -path "*${DIR}/libs/btstack/Baseband/BLE/${TARGET_CPU}*" -prune -o \
    -path "*${DIR}/libs/btstack/Baseband/Classic/*" ! -path "*${DIR}/libs/btstack/Baseband/Classic/${TARGET_CPU}*" -prune -o \
    -path "*${DIR}/libs/btstack/Baseband/common/*" ! -path "*${DIR}/libs/btstack/Baseband/common/${TARGET_CPU}*" -prune -o \
    -path "*${DIR}/libs/btstack/Baseband/include/ble/*" ! -path "*${DIR}/libs/btstack/Baseband/include/ble/${TARGET_CPU}*" -prune -o \
    -path "*${DIR}/libs/btstack/Baseband/include/classic/*" ! -path "*${DIR}/libs/btstack/Baseband/include/classic/${TARGET_CPU}*" -prune -o \
    -path "*${DIR}/libs/btstack/Baseband/include/common/*" ! -path "*${DIR}/libs/btstack/Baseband/include/common/${TARGET_CPU}*" -prune -o \
    -path "*${DIR}/libs/btstack/Controller/include/common/*" ! -path "*${DIR}/libs/btstack/Controller/include/common/${TARGET_CPU}*" -prune -o \
    -path "*${DIR}/libs/usbstack/code/common/*" ! -path "*${DIR}/libs/usbstack/code/common/${TARGET_CPU}*" -prune -o \
    -path "*${DIR}/${TARGET_DIR}/post_build/*" ! -path "*${DIR}/${TARGET_DIR}/post_build/${TARGET_CPU}*" -prune -o \
    -path "*${DIR}/tools*" -prune -o \
    -path "*${DIR}/undodir*" -prune -o"

    # -path "*${DIR}/libs/cpu/*" ! -path "*${DIR}/libs/cpu/${TARGET_CPU}*" -prune -o \
export FORMAT='.*\.\(c\|h\|s\|S\|ld\|s51\|lst\|map\|txt\)'

ctags -R --fields=+lS --languages=+Asm 

# ----------- cscope
cscope -bR

# ----------- lookup file
echo -e "!_TAG_FILE_SORTED\t2\t/2=foldcase/">filenametags
# echo ${FIND_EXCEPT}
${FIND_EXCEPT} -regex ${FORMAT} -type f -printf "%f\t%p\t1\n" | sort -f>>filenametags

