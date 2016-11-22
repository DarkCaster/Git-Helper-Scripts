#!/bin/sh

#setup author, email and sign params for local repo.
#call this script from repo directory.

script_dir="$( cd "$( dirname "$0" )" && pwd )"

. "$script_dir/author.conf.in"

apply_param_force () {
 local pname="$1"
 local pvalue="$2"
 echo "setting local config parameter: $pname $pvalue"
 git config --local $pname $pvalue
}

remove_param () {
 local pname="$1"
 git config --local --get $pname > /dev/null
 if [ "z$?" = "z0" ]; then
  echo "removing local config parameter: $pname"
  git config --local --unset-all $pname
 fi
}

#setup local repo params
apply_param_force user.name "$author"
apply_param_force user.email "$mail"
apply_param_force user.signingkey $key
apply_param_force commit.gpgSign true

test "$use_gpgwrap" = "yes" && apply_param_force gpg.program "$script_dir/gpg-wrap.sh"
test "$use_gpgwrap" = "no" && remove_param gpg.program

#signed push is not supported by github
#git config --local push.gpgSign true

gpgbin=`which gpg2 2>/dev/null`
test -z "$gpgbin" && gpgbin=`which gpg 2>/dev/null`
test -z "$gpgbin" && echo "gpg binary not found" && exit 0

#set selected sign-key as trusted.
"$gpgbin" --trusted-key $key --list-keys $key
