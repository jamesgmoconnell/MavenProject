#!/bin/bash
grep return $1 | sed 's/^[\t]*return "//g' | sed 's:\\n";::g' | sed 's/\\n/\
/g'> $2


