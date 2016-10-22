#!/bin/sh

#bootstrap or setup local repo params for storage and operation of big files or huge file count or repo size
#run this script from repo directory

git status >/dev/null 2>&1
if [ "z$?" = "z128" ]; then
 echo "$@" | xargs git init
fi

apply_param () {
 local pname=$1
 local pvalue=$2
 git config --local --get $pname > /dev/null
 if [ "z$?" = "z1" ]; then
  echo "adding local config parameter: $pname $pvalue"
  git config --local --add $pname $pvalue
 else
  echo "skipping config parameter: $pname $pvalue"
 fi
}

#core

apply_param core.compression 3
apply_param core.packedGitWindowSize 8m
apply_param core.packedGitLimit 32m
apply_param core.bigFileThreshold 32m
apply_param core.filemode false
apply_param core.ignoreCase true
apply_param core.symlinks false

#pack

apply_param pack.windowMemory 32m
apply_param pack.deltaCacheSize 32m
apply_param pack.threads 4
apply_param pack.packSizeLimit 64m

#receive

apply_param receive.denyNonFastforwards true

#auto clrf

#apply_param core.autocrlf false

#auto gc

#apply_param gc.auto false
#apply_param gc.autopacklimit 0

