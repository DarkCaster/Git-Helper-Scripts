#!/bin/sh

script_dir="$( cd "$( dirname "$0" )" && pwd )"
. "$script_dir/author.conf.in"
olddir=`pwd`

cd "$script_dir"
cp "$script_dir/keycreate.gpg.batch.template" "$script_dir/keycreate.gpg.batch"

date=`date +%Y-%m-%d`

sed -i 's|__author__|'"$author"'|g' "$script_dir/keycreate.gpg.batch"
sed -i 's|__mail__|'"$mail"'|g' "$script_dir/keycreate.gpg.batch"
sed -i 's|__date__|'"$date"'|g' "$script_dir/keycreate.gpg.batch"

gpg --gen-key --batch "$script_dir/keycreate.gpg.batch"

rm "$script_dir/keycreate.gpg.batch"
cd "$olddir"

