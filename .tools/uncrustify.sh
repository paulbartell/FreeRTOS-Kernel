#!/bin/bash
uncrustify -c .tools/uncrustify.cfg --replace --no-backup "$@"
