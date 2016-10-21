#!/bin/sh

#setup author, email and sign params for local repo.
#call this script from repo directory.

script_dir="$( cd "$( dirname "$0" )" && pwd )"

. "$script_dir/author.conf.in"

#setup local repo params
git config --local user.name "$author"
git config --local user.email "$mail"
git config --local user.signingkey $key
git config --local gpg.program "$script_dir/gpg-wrap.sh"
git config --local commit.gpgSign true

#signed push is not supported by github
#git config --local push.gpgSign true

#set selected sign-key as trusted.
gpg2 --trusted-key $key --list-keys $key

