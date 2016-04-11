#!/bin/bash
if [[ $# -lt 2 ]] ; then
    echo '*** ERROR *** Too few arguments - supply expected results file and actual results file...'
    exit 2
	#Return exit value 2 if too few arguments submitted...  Spam the Console & exit
fi
diff --brief <(sort $1) <(sort $2) >/dev/null
exit
#Return exit value 0 if files are same and 1 if files are different

