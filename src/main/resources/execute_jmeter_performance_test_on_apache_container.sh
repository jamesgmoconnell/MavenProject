#!/bin/bash
if [[ $# -lt 4 ]] ; then
    echo '*** ERROR: Too few arguments supplied! ***'
    echo '*** Supply the following:              ***'
    echo '*** - Performance test script          ***'
    echo '*** - Test Results Log file            ***'
    echo '*** - Number of concurrent threads     ***'
    echo '*** - Test_Arguments file (TestURLS)   ***'
    exit 2
    #Return exit value 2 if too few arguments submitted...  Spam the Console & exit
fi
comp_value=$?
if [ $comp_value -eq 2 ] ; then
    echo "********************************"
    echo "Internal Error Encountered!!!"
    echo "********************************"
    #Exit stage right!
    exit
else
    echo ''
    echo '--------------------------------------------------------------------------------'
    echo 'Run JMeter Performance Tests and store results to '$2
    echo '--------------------------------------------------------------------------------'
    echo 'Performance Script File is: '$1
    echo 'Log file is: '$2
    echo 'Number of concurrent test threads is: '$3
    echo 'Test_Arguments file is: '$4
    NumberOfTestUrls=$(wc -l < $4) 
    echo 'Number of TestUrls to repeat for each thread is :'$NumberOfTestUrls
    jmeter -n -t $1 -l $2 -JNumberOfThreads=$3 -JTestURL_Count=$NumberOfTestUrls
fi
