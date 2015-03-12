#!/bin/bash

# possible flag passed in
typeOfTesting=$1

globalPerformanceTime=-1

echo "Performance Rtest Begin: " $typeOfTesting

NaluRtestCWD=$(pwd)

cd ..
baseGitHubCWD=$(pwd)

# create the directory in which the tests will be run (if it does not exist)
if [ ! -d "$baseGitHubCWD/runNaluRtest" ]; then
    mkdir $baseGitHubCWD/runNaluRtest
    mkdir $baseGitHubCWD/runNaluRtest/performance
fi

# look for file that defines the path to naluX
if [ ! -f $NaluRtestCWD/NaluProjectPath.txt ]; then
    if [ "$typeOfTesting" == "DEBUG" ]; then
        cp $baseGitHubCWD/Nalu/build/naluXd $baseGitHubCWD/runNaluRtest/naluX
    else
        cp $baseGitHubCWD/Nalu/build/naluX $baseGitHubCWD/runNaluRtest/naluX
    fi
else
    NaluProjectPathFile="$NaluRtestCWD/NaluProjectPath.txt"
    projectPathName=$(cat $NaluProjectPathFile)
    if [ "$typeOfTesting" == "DEBUG" ]; then
        cp $projectPathName/build/naluXd $baseGitHubCWD/runNaluRtest/naluX
    else
        cp $projectPathName/build/naluX $baseGitHubCWD/runNaluRtest/naluX
    fi
fi

# copy pass_fail script
cp $NaluRtestCWD/pass_fail.sh $baseGitHubCWD/runNaluRtest

#=============================================================================
# waleElemXflowMixFrac3.5m test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/performance/waleElemXflowMixFrac3.5m" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/performance/waleElemXflowMixFrac3.5m
fi

cd $baseGitHubCWD/runNaluRtest/performance/waleElemXflowMixFrac3.5m
cp $NaluRtestCWD/performance/waleElemXflowMixFrac3.5m/waleElemXflowMixFrac3.5m.i $baseGitHubCWD/runNaluRtest/performance/waleElemXflowMixFrac3.5m
cp $NaluRtestCWD/performance/waleElemXflowMixFrac3.5m/*.xml $baseGitHubCWD/runNaluRtest/performance/waleElemXflowMixFrac3.5m
cp $NaluRtestCWD/performance/waleElemXflowMixFrac3.5m/*.g.* $baseGitHubCWD/runNaluRtest/performance/waleElemXflowMixFrac3.5m
cp $NaluRtestCWD/performance/waleElemXflowMixFrac3.5m/waleElemXflowMixFrac3.5m.sh $baseGitHubCWD/runNaluRtest/performance/waleElemXflowMixFrac3.5m
cp $NaluRtestCWD/performance/waleElemXflowMixFrac3.5m/waleElemXflowMixFrac3.5m.norm.gold* $baseGitHubCWD/runNaluRtest/performance/waleElemXflowMixFrac3.5m
# run it...  
./waleElemXflowMixFrac3.5m.sh
# report it; 30 spaces
passStatusWaleElemXflow="$?"
GlobalPerformanceTime=`grep "STKPERF: Total Time" $baseGitHubCWD/runNaluRtest/performance/waleElemXflowMixFrac3.5m/waleElemXflowMixFrac3.5m.log  | awk '{print $4}'`
if [ $passStatusWaleElemXflow -ne 1 ]; then
    echo -e "..waleElemXflowMixFrac3.5m.... FAILED":" " $GlobalPerformanceTime " s"
else
    echo -e "..waleElemXflowMixFrac3.5m.... PASSED":" " $GlobalPerformanceTime " s"
fi

#=============================================================================
# uqSlidingMesh test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/performance/uqSlidingMesh" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/performance/uqSlidingMesh
fi

cd $baseGitHubCWD/runNaluRtest/performance/uqSlidingMesh
cp $NaluRtestCWD/performance/uqSlidingMesh/uqSlidingMesh.i $baseGitHubCWD/runNaluRtest/performance/uqSlidingMesh
cp $NaluRtestCWD/performance/uqSlidingMesh/*.xml $baseGitHubCWD/runNaluRtest/performance/uqSlidingMesh
cp $NaluRtestCWD/mesh/uqvawt_corrected.exo.* $baseGitHubCWD/runNaluRtest/performance/uqSlidingMesh
cp $NaluRtestCWD/performance/uqSlidingMesh/uqSlidingMesh.sh $baseGitHubCWD/runNaluRtest/performance/uqSlidingMesh
cp $NaluRtestCWD/performance/uqSlidingMesh/uqSlidingMesh.norm.gold* $baseGitHubCWD/runNaluRtest/performance/uqSlidingMesh
# run it...  
./uqSlidingMesh.sh
# report it; 30 spaces
passStatusUqSliding="$?"
GlobalPerformanceTime=`grep "STKPERF: Total Time" $baseGitHubCWD/runNaluRtest/performance/uqSlidingMesh/uqSlidingMesh.log  | awk '{print $4}'`
if [ $passStatusUqSliding -ne 1 ]; then
    echo -e "..uqSlidingMesh............... FAILED":" " $GlobalPerformanceTime " s"
else
    echo -e "..uqSlidingMesh............... PASSED":" " $GlobalPerformanceTime " s"
fi

echo "Performance Rtest End"
