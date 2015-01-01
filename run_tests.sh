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
# movingCylinder test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/movingCylinder" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/movingCylinder
fi

cd $baseGitHubCWD/runNaluRtest/nightly/movingCylinder
cp $NaluRtestCWD/nightly/movingCylinder/movingCylinder.i $baseGitHubCWD/runNaluRtest/nightly/movingCylinder
cp $NaluRtestCWD/nightly/movingCylinder/*.g.* $baseGitHubCWD/runNaluRtest/nightly/movingCylinder
cp $NaluRtestCWD/nightly/movingCylinder/movingCylinder.sh $baseGitHubCWD/runNaluRtest/nightly/movingCylinder
cp $NaluRtestCWD/nightly/movingCylinder/movingCylinder.norm.gold $baseGitHubCWD/runNaluRtest/nightly/movingCylinder
# run it...  
./movingCylinder.sh
# report it; 30 spaces
passStatusMovingCylinder="$?"
if [ $passStatusMovingCylinder -ne 1 ]; then
    echo -e "${red}..movingCylinder.............. FAILED${NC}"
else
    echo -e "${grn}..movingCylinder.............. PASSED${NC}"
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
passStatusElemBackStep="$?"
if [ $passStatusElemBackStep -ne 1 ]; then
    echo -e "${red}..elemBackStepLRSST........... FAILED${NC}"
else
    echo -e "${grn}..elemBackStepLRSST........... PASSED${NC}"
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
passStatusHeliumPlume="$?"
if [ $passStatusHeliumPlume -ne 1 ]; then
    echo -e "${red}..heliumPlumeEdge............. FAILED${NC}"
else
    echo -e "${grn}..heliumPlumeEdge............. PASSED${NC}"
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
passStatusEdgeContact="$?"
if [ $passStatusEdgeContact -ne 1 ]; then
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
passStatusFluidsPmrCht="$?"
if [ $passStatusFluidsPmrCht -ne 1 ]; then
    echo -e "${red}..fluidsPmrChtPeriodic........ FAILED${NC}"
else
    echo -e "${grn}..fluidsPmrChtPeriodic........ PASSED${NC}"
fi

#=============================================================================
# waleElemXflowMixFrac3.5m test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/waleElemXflowMixFrac3.5m" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/waleElemXflowMixFrac3.5m
fi

cd $baseGitHubCWD/runNaluRtest/nightly/waleElemXflowMixFrac3.5m
cp $NaluRtestCWD/nightly/waleElemXflowMixFrac3.5m/waleElemXflowMixFrac3.5m.i $baseGitHubCWD/runNaluRtest/nightly/waleElemXflowMixFrac3.5m
cp $NaluRtestCWD/nightly/waleElemXflowMixFrac3.5m/*.g.* $baseGitHubCWD/runNaluRtest/nightly/waleElemXflowMixFrac3.5m
cp $NaluRtestCWD/nightly/waleElemXflowMixFrac3.5m/waleElemXflowMixFrac3.5m.sh $baseGitHubCWD/runNaluRtest/nightly/waleElemXflowMixFrac3.5m
cp $NaluRtestCWD/nightly/waleElemXflowMixFrac3.5m/waleElemXflowMixFrac3.5m.norm.gold $baseGitHubCWD/runNaluRtest/nightly/waleElemXflowMixFrac3.5m
# run it...  
./waleElemXflowMixFrac3.5m.sh
# report it; 30 spaces
passStatusWaleElemXflow="$?"
if [ $passStatusWaleElemXflow -ne 1 ]; then
    echo -e "${red}..waleElemXflowMixFrac3.5m.... FAILED${NC}"
else
    echo -e "${grn}..waleElemXflowMixFrac3.5m.... PASSED${NC}"
fi

echo "Rtest End"
