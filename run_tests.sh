#!/bin/bash

grn='\033[0;32m'
red='\033[0;31m'
NC='\033[00m'

echo "Rtest Begin"

NaluRtestCWD=$(pwd)

cd ..
baseGitHubCWD=$(pwd)

# create the directory in which the tests will be run (if it does not exist)
if [ ! -d "$baseGitHubCWD/runNaluRtest" ]; then
    mkdir $baseGitHubCWD/runNaluRtest
    mkdir $baseGitHubCWD/runNaluRtest/nightly
    mkdir $baseGitHubCWD/runNaluRtest/performance
fi

# copy executable for all tests to use
cp $baseGitHubCWD/Nalu/build/naluX $baseGitHubCWD/runNaluRtest

#=============================================================================
# concentricRad test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/concentricRad" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/concentricRad
fi

cd $baseGitHubCWD/runNaluRtest/nightly/concentricRad
cp $NaluRtestCWD/nightly/concentricRad/concentricRad.i $baseGitHubCWD/runNaluRtest/nightly/concentricRad
cp $NaluRtestCWD/nightly/concentricRad/*.g.* $baseGitHubCWD/runNaluRtest/nightly/concentricRad
cp $NaluRtestCWD/nightly/concentricRad/concentricRad.sh $baseGitHubCWD/runNaluRtest/nightly/concentricRad
cp $NaluRtestCWD/nightly/concentricRad/concentricRad.norm.gold $baseGitHubCWD/runNaluRtest/nightly/concentricRad
# run it...  
./concentricRad.sh
# report it; 30 spaces
passStatusConcentricRad="$?"
if [ $passStatusConcentricRad -ne 1 ]; then
    echo -e "${red}..concentricRad............... FAILED${NC}"
else
    echo -e "${grn}..concentricRad............... PASSED${NC}"
fi

#=============================================================================
# edgeContact3D test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/edgeContact3D" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/edgeContact3D
fi

cd $baseGitHubCWD/runNaluRtest/nightly/edgeContact3D
cp $NaluRtestCWD/nightly/edgeContact3D/edgeContact3D.i $baseGitHubCWD/runNaluRtest/nightly/edgeContact3D
cp $NaluRtestCWD/nightly/edgeContact3D/*.exo.* $baseGitHubCWD/runNaluRtest/nightly/edgeContact3D
cp $NaluRtestCWD/nightly/edgeContact3D/edgeContact3D.sh $baseGitHubCWD/runNaluRtest/nightly/edgeContact3D
cp $NaluRtestCWD/nightly/edgeContact3D/edgeContact3D.norm.gold $baseGitHubCWD/runNaluRtest/nightly/edgeContact3D
# run it...  
./edgeContact3D.sh
# report it; 30 spaces
passStatusConcentricRad="$?"
if [ $passStatusConcentricRad -ne 1 ]; then
    echo -e "${red}..edgeContact3D............... FAILED${NC}"
else
    echo -e "${grn}..edgeContact3D............... PASSED${NC}"
fi

#=============================================================================
# fluidsPmrChtPeriodic test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/fluidsPmrChtPeriodic" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/fluidsPmrChtPeriodic
fi

cd $baseGitHubCWD/runNaluRtest/nightly/fluidsPmrChtPeriodic
cp $NaluRtestCWD/nightly/fluidsPmrChtPeriodic/fluidsPmrChtPeriodic.i $baseGitHubCWD/runNaluRtest/nightly/fluidsPmrChtPeriodic
cp $NaluRtestCWD/nightly/fluidsPmrChtPeriodic/*.g.* $baseGitHubCWD/runNaluRtest/nightly/fluidsPmrChtPeriodic
cp $NaluRtestCWD/nightly/fluidsPmrChtPeriodic/fluidsPmrChtPeriodic.sh $baseGitHubCWD/runNaluRtest/nightly/fluidsPmrChtPeriodic
cp $NaluRtestCWD/nightly/fluidsPmrChtPeriodic/fluidsPmrChtPeriodic.norm.gold $baseGitHubCWD/runNaluRtest/nightly/fluidsPmrChtPeriodic
# run it...  
./fluidsPmrChtPeriodic.sh
# report it; 30 spaces
passStatusConcentricRad="$?"
if [ $passStatusConcentricRad -ne 1 ]; then
    echo -e "${red}..fluidsPmrChtPeriodic........ FAILED${NC}"
else
    echo -e "${grn}..fluidsPmrChtPeriodic........ PASSED${NC}"
fi

#=============================================================================
# edgePipeCHT test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/edgePipeCHT" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/edgePipeCHT
fi

cd $baseGitHubCWD/runNaluRtest/nightly/edgePipeCHT
cp $NaluRtestCWD/nightly/edgePipeCHT/edgePipeCHT.i $baseGitHubCWD/runNaluRtest/nightly/edgePipeCHT
cp $NaluRtestCWD/nightly/edgePipeCHT/*.g.* $baseGitHubCWD/runNaluRtest/nightly/edgePipeCHT
cp $NaluRtestCWD/nightly/edgePipeCHT/edgePipeCHT.sh $baseGitHubCWD/runNaluRtest/nightly/edgePipeCHT
cp $NaluRtestCWD/nightly/edgePipeCHT/edgePipeCHT.norm.gold $baseGitHubCWD/runNaluRtest/nightly/edgePipeCHT
# run it...  
./edgePipeCHT.sh
# report it; 30 spaces
passStatusEdgePipeCHT="$?"
if [ $passStatusEdgePipeCHT -ne 1 ]; then
    echo -e "${red}..edgePipeCHT................. FAILED${NC}"
else
    echo -e "${grn}..edgePipeCHT................. PASSED${NC}"
fi

#=============================================================================
# elemBackStepLRSST test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/elemBackStepLRSST" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/elemBackStepLRSST
fi

cd $baseGitHubCWD/runNaluRtest/nightly/elemBackStepLRSST
cp $NaluRtestCWD/nightly/elemBackStepLRSST/elemBackStepLRSST.i $baseGitHubCWD/runNaluRtest/nightly/elemBackStepLRSST
cp $NaluRtestCWD/nightly/elemBackStepLRSST/*.g.* $baseGitHubCWD/runNaluRtest/nightly/elemBackStepLRSST
cp $NaluRtestCWD/nightly/elemBackStepLRSST/elemBackStepLRSST.sh $baseGitHubCWD/runNaluRtest/nightly/elemBackStepLRSST
cp $NaluRtestCWD/nightly/elemBackStepLRSST/elemBackStepLRSST.norm.gold $baseGitHubCWD/runNaluRtest/nightly/elemBackStepLRSST
# run it...  
./elemBackStepLRSST.sh
# report it; 30 spaces
passStatusEdgePipeCHT="$?"
if [ $passStatusEdgePipeCHT -ne 1 ]; then
    echo -e "${red}..elemBackStepLRSST........... FAILED${NC}"
else
    echo -e "${grn}..elemBackStepLRSST........... PASSED${NC}"
fi

#=============================================================================
# heliumPlumeEdge test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/heliumPlumeEdge" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/heliumPlumeEdge
fi

cd $baseGitHubCWD/runNaluRtest/nightly/heliumPlumeEdge
cp $NaluRtestCWD/nightly/heliumPlumeEdge/heliumPlumeEdge.i $baseGitHubCWD/runNaluRtest/nightly/heliumPlumeEdge
cp $NaluRtestCWD/nightly/heliumPlumeEdge/*.g.* $baseGitHubCWD/runNaluRtest/nightly/heliumPlumeEdge
cp $NaluRtestCWD/nightly/heliumPlumeEdge/heliumPlumeEdge.sh $baseGitHubCWD/runNaluRtest/nightly/heliumPlumeEdge
cp $NaluRtestCWD/nightly/heliumPlumeEdge/heliumPlumeEdge.norm.gold $baseGitHubCWD/runNaluRtest/nightly/heliumPlumeEdge
# run it...  
./heliumPlumeEdge.sh
# report it; 30 spaces
passStatusEdgePipeCHT="$?"
if [ $passStatusEdgePipeCHT -ne 1 ]; then
    echo -e "${red}..heliumPlumeEdge............. FAILED${NC}"
else
    echo -e "${grn}..heliumPlumeEdge............. PASSED${NC}"
fi

echo "Rtest End"
