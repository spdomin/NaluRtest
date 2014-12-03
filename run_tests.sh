#!/bin/bash

green='\e[0;32m'
red='\e[0;31m'
NC='\e[0m'

NaluRtestCWD=$(pwd)
echo $NaluRtestCWD

cd ..
baseGitHubCWD=$(pwd)
echo $baseGitHubCWD

# create the directory in which the tests will be run (if it does not exist)
if [ ! -d "$baseGitHubCWD/runNaluRtest" ]; then
    mkdir $baseGitHubCWD/runNaluRtest
    mkdir $baseGitHubCWD/runNaluRtest/nightly
    mkdir $baseGitHubCWD/runNaluRtest/performance
    echo "runNaluRtest directory did not exists"
fi

# copy executable for all tests to use
cp $baseGitHubCWD/Nalu/build/naluX $baseGitHubCWD/runNaluRtest

#=============================================================================
# concentricRad test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/concentricRad" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/concentricRad
    echo "concentricRad directory did not exists"
fi

cd $baseGitHubCWD/runNaluRtest/nightly/concentricRad
cp $NaluRtestCWD/nightly/concentricRad/concentricRad.i $baseGitHubCWD/runNaluRtest/nightly/concentricRad
cp $NaluRtestCWD/nightly/concentricRad/*.g.* $baseGitHubCWD/runNaluRtest/nightly/concentricRad
cp $NaluRtestCWD/nightly/concentricRad/concentricRad.sh $baseGitHubCWD/runNaluRtest/nightly/concentricRad
cp $NaluRtestCWD/nightly/concentricRad/concentricRad.norm.gold $baseGitHubCWD/runNaluRtest/nightly/concentricRad
# run it...  
./concentricRad.sh
# report it
passStatusConcentricRad="$?"
if [ $passStatusConcentricRad -ne 1 ]; then
    echo -e "${red}concentricRad test FAILED${NC}"
else
    echo -e "${green}concentricRad test PASSED${NC}"
fi

#=============================================================================
# edgePipeCHT test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/edgePipeCHT" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/edgePipeCHT
    echo "edgePipeCHT directory did not exists"
fi

cd $baseGitHubCWD/runNaluRtest/nightly/edgePipeCHT
cp $NaluRtestCWD/nightly/edgePipeCHT/edgePipeCHT.i $baseGitHubCWD/runNaluRtest/nightly/edgePipeCHT
cp $NaluRtestCWD/nightly/edgePipeCHT/*.g.* $baseGitHubCWD/runNaluRtest/nightly/edgePipeCHT
cp $NaluRtestCWD/nightly/edgePipeCHT/edgePipeCHT.sh $baseGitHubCWD/runNaluRtest/nightly/edgePipeCHT
cp $NaluRtestCWD/nightly/edgePipeCHT/edgePipeCHT.norm.gold $baseGitHubCWD/runNaluRtest/nightly/edgePipeCHT
# run it...  
./edgePipeCHT.sh
# report it
passStatusEdgePipeCHT="$?"
if [ $passStatusEdgePipeCHT -ne 1 ]; then
    echo -e "${red}edgePipeCHT test FAILED${NC}"
else
    echo -e "${green}edgePipeCHT test PASSED${NC}"
fi

echo "Rtest complete"