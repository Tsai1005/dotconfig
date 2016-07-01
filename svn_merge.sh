#!/bin/bash

# shift 5

# meld "$@"

MERGE="vimdiff"
BASE=${1}   
THEIRS=${2}
MINE=${3}
MERGED=${4}

$MERGE $MINE $MERGED $THEIRS
