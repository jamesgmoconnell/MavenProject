#!/bin/bash
echo ""
echo "*****************************"
echo " Running Automated Tests ... "
echo "*****************************"

echo ""
echo "--------------------------------------------------------"
echo "Cleaning up temporary files from previous test execution"
echo "--------------------------------------------------------"
echo ""

fileToParse="../java/com/example/core/HelloController.java"
fileToLaunchInJVM="../../../target/demo-0.0.1-SNAPSHOT.jar"
performanceTestScript="./NewPerfTestJMeter.jmx"
numberOfThreads=1000

file1="./junk.txt"
file2="./test_arguments.txt"
file3="./testresults.txt"
file4="./expected_results.txt"
file5="./PerformanceTestResultLog.jtl"

filelist="$file1 $file2 $file3 $file4 $file5"
echo "File list To Search: " $filelist
for file in $filelist; do
    if [ -f "$file" ]
    then
        echo "File $file found and deleted!"
        rm $file
    fi
done

echo ""
echo "----------------------------------------"
echo "Generating the needed test URL paths...."
echo "----------------------------------------"
./test_input_generator.sh $fileToParse $file2

echo "The following test URL paths are used:"
cat $file2

echo ""
echo "-----------------------------------------------"
echo "Launching the Java JVM as a background task...."
echo "-----------------------------------------------"
java -jar $fileToLaunchInJVM  > $file1 &

echo ":"
echo "Waiting for Spring Framework & Apache Webserver to start ..."
echo ":"
# Next line waits until Springboot Framework has launched the DemoApplication... Cleaner than sleep x   seconds
tail -f $file1 | grep -m 1 "Started DemoApplication" | xargs echo "" >> $file1 \;

echo "-----------------------------------------------------"
echo "SpringBoot Framework & Apache Webserver now running !" 
echo "-----------------------------------------------------"
echo ""
echo "-------------------------------------------------------------"
echo "Test All Test URLs and store result to file "$file3
echo "-------------------------------------------------------------"
#Next line loops through all required test urls and substitutes them to a CURL call
<$file2 xargs -I % curl -ks http://localhost:8080% >> $file3

echo ""
echo "-------------------------------"
echo "Result strings from tests are: "
echo "-------------------------------"
cat $file3

echo ""
echo "-------------------------------------------------------------------------"
echo "Generate expected results and store result to file "$file4
echo "-------------------------------------------------------------------------"
./autotestresult_generator.sh $fileToParse $file4

echo ""
echo "----------------------------------------------"
echo "Expected result strings from tests should be: "
echo "----------------------------------------------"
cat $file4

echo ""
echo "-------------------------------------------------------"
echo "Testing the actual results against the expected results"
echo "-------------------------------------------------------"
./compare_actual_and_expected_results.sh $file3 $file4
comp_value=$?
if [ $comp_value -eq 1 ] ; then
    echo ":"
    echo "Test Failed !!! Actual Results & Test Results differ...."
    echo ":"
elif [ $comp_value -eq 0 ] ; then
    echo ":"
    echo "Test Successful - All input URLs returned expected result!"
    echo ":"
else
    echo "********************************"
    echo "Internal Error Encountered!!!"
    echo "********************************"
fi

./execute_jmeter_performance_test_on_apache_container.sh $performanceTestScript $file5 $numberOfThreads $file2

echo ""
echo "--------------------------------"
echo "Killing Background Java JVM ...."
echo "--------------------------------"
kill %1

echo ""
echo "*********************************"
echo " Automated Test Run Completed... "
echo "*********************************"
echo ""
