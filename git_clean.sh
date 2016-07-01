#!/bin/sh

find -name "*.orig" -exec rm {} \;
find -name "*_BASE_*" -exec rm {} \;
find -name "*_BACKUP_*" -exec rm {} \;
find -name "*_LOCAL_*" -exec rm {} \;
find -name "*_REMOTE_*" -exec rm {} \;

