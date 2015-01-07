#!/bin/bash

echo "Performance Rtest Begin"

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
    # copy executable for all tests to use
    cp $baseGitHubCWD/Nalu/build/naluX $baseGitHubCWD/runNaluRtest
else
    NaluProjectPathFile="$NaluRtestCWD/NaluProjectPath.txt"
    projectPathName=$(cat $NaluProjectPathFile)
    cp $projectPathName/build/naluX $baseGitHubCWD/runNaluRtest
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
cp $NaluRtestCWD/performance/waleElemXflowMixFrac3.5m/*.g.* $baseGitHubCWD/runNaluRtest/performance/waleElemXflowMixFrac3.5m
cp $NaluRtestCWD/performance/waleElemXflowMixFrac3.5m/waleElemXflowMixFrac3.5m.sh $baseGitHubCWD/runNaluRtest/performance/waleElemXflowMixFrac3.5m
cp $NaluRtestCWD/performance/waleElemXflowMixFrac3.5m/waleElemXflowMixFrac3.5m.norm.gold $baseGitHubCWD/runNaluRtest/performance/waleElemXflowMixFrac3.5m
# run it...  
./waleElemXflowMixFrac3.5m.sh
# report it; 30 spaces
passStatusWaleElemXflow="$?"
if [ $passStatusWaleElemXflow -ne 1 ]; then
    echo -e "..waleElemXflowMixFrac3.5m.... FAILED"
else
    echo -e "..waleElemXflowMixFrac3.5m.... PASSED"
fi

echo "Performance Rtest End"
