#!/bin/bash
echo "Run JMeter performance test"
# Delete old reults
#rm $WORKSPACE/src/main/resources/JMeterSpringTest_Results.jtl
#run jmeter
# -n tells jmeter o run in "nogui" mode
# -t points to te test plan
# -l outputs results to a log file
jmeter -n -t "JMeterSpringTest_Plan.jmx" -l "JMeterSpringTest_Results.jtl"
