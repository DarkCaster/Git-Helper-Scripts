#!/bin/sh

#gpg wrapper script. not for direct use.
#will be used by default, when performing repo setup with git-signconfig.sh script.
#you can add some cmdline options, logging, or other stuff here.

gpg2 --no-tty $@

