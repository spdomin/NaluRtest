#!/bin/bash
. ../../pass_fail.sh

CWD=$(pwd)
didSimulationDiffAnywhere=0
didSimulationDiffAnywhereFirst=0
didSimulationDiffAnywhereSecond=0
localDiffOne=0.0;
localDiffTwo=0.0;

# determine tolerance
testTol=0.000000000001
theGoldNormEdge=heatedWaterChannelEdge.norm.gold.remote
theGoldNormElem=heatedWaterChannelElem.norm.gold.remote
platform=`uname`
if [ "$platform" == 'Linux' ]; then
    testTol=0.0000000000000001
    theGoldNormEdge=heatedWaterChannelEdge.norm.gold
    theGoldNormElem=heatedWaterChannelElem.norm.gold
fi

# set the global diff
GlobalMaxSolutionDiff=-1000000000.0

if [ -f $CWD/PASS ]; then
    # already ran this test
    didSimulationDiffAnywhere=0
else
    # run the first
    mpiexec --np 4 ../../naluX -i heatedWaterChannelEdge.i -o heatedWaterChannelEdge.log
    determine_pass_fail $testTol "heatedWaterChannelEdge.log" "heatedWaterChannelEdge.norm" "$theGoldNormEdge"
    didSimulationDiffAnywhereFirst="$?"
    localDiffOne=$GlobalMaxSolutionDiff
    if [ "$didSimulationDiffAnywhereFirst" -gt 0 ]; then
        didSimulationDiffAnywhere=1
    fi

    # run the second
    mpiexec --np 4 ../../naluX -i heatedWaterChannelElem.i -o heatedWaterChannelElem.log
    determine_pass_fail $testTol "heatedWaterChannelElem.log" "heatedWaterChannelElem.norm" "$theGoldNormElem"
    didSimulationDiffAnywhereSecond="$?"
    localDiffTwo=$GlobalMaxSolutionDiff
    if [ "$didSimulationDiffAnywhereSecond" -gt 0 ]; then
        didSimulationDiffAnywhere=1
    fi

    # check who is greater
    if [ $(echo " $localDiffOne > $localDiffTwo " | bc) -eq 1 ]; then
        GlobalMaxSolutionDiff=$localDiffOne
    else
        GlobalMaxSolutionDiff=$localDiffTwo
    fi

fi

# write the file based on final status
if [ "$didSimulationDiffAnywhere" -gt 0 ]; then
    PASS_STATUS=0
else
    PASS_STATUS=1
    echo $PASS_STATUS > PASS
fi

# report it; 30 spaces
GlobalPerformanceTimeFirst=`grep "STKPERF: Total Time" heatedWaterChannelEdge.log  | awk '{print $4}'`
GlobalPerformanceTimeSecond=`grep "STKPERF: Total Time" heatedWaterChannelElem.log  | awk '{print $4}'`
totalPerfTime=`echo "$GlobalPerformanceTimeFirst + $GlobalPerformanceTimeSecond" | bc `
if [ $PASS_STATUS -ne 1 ]; then
    echo -e "..heatedWaterChannel.......... FAILED":" " $totalPerfTime " s" " max diff: " $GlobalMaxSolutionDiff
else
    echo -e "..heatedWaterChannel.......... PASSED":" " $totalPerfTime " s"
fi

exit
