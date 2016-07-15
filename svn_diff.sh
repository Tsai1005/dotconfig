#!/bin/bash

# shift 5

# meld "$@"

DIFF="vimdiff"
LEFT=${6}
RIGHT=${7}
$DIFF $LEFT $RIGHT

# python /home/bingquan/.subversion/svn_diff.py
# python ~/.subversion/svn_diff.py $@

