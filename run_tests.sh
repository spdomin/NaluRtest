#!/bin/bash

# possible flag passed in
typeOfTesting=$1

echo "Rtest Begin: " $typeOfTesting

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
# dgNonConformal test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/dgNonConformal" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/dgNonConformal
fi

cd $baseGitHubCWD/runNaluRtest/nightly/dgNonConformal
cp $NaluRtestCWD/nightly/dgNonConformal/dgNonConformal.i $baseGitHubCWD/runNaluRtest/nightly/dgNonConformal
cp $NaluRtestCWD/nightly/dgNonConformal/*.g* $baseGitHubCWD/runNaluRtest/nightly/dgNonConformal
cp $NaluRtestCWD/nightly/dgNonConformal/dgNonConformal.sh $baseGitHubCWD/runNaluRtest/nightly/dgNonConformal
cp $NaluRtestCWD/nightly/dgNonConformal/dgNonConformal.norm.gold $baseGitHubCWD/runNaluRtest/nightly/dgNonConformal
# run it...  
./dgNonConformal.sh

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

#=============================================================================
# heliumPlumeEdge test (with restart)
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/heliumPlumeEdge" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/heliumPlumeEdge
fi

cd $baseGitHubCWD/runNaluRtest/nightly/heliumPlumeEdge
cp $NaluRtestCWD/nightly/heliumPlumeEdge/heliumPlumeEdge.i $baseGitHubCWD/runNaluRtest/nightly/heliumPlumeEdge
cp $NaluRtestCWD/nightly/heliumPlumeEdge/heliumPlumeEdge_rst.i $baseGitHubCWD/runNaluRtest/nightly/heliumPlumeEdge
cp $NaluRtestCWD/nightly/heliumPlumeEdge/*.g.* $baseGitHubCWD/runNaluRtest/nightly/heliumPlumeEdge
cp $NaluRtestCWD/nightly/heliumPlumeEdge/milestone.xml $baseGitHubCWD/runNaluRtest/nightly/heliumPlumeEdge
cp $NaluRtestCWD/nightly/heliumPlumeEdge/heliumPlumeEdge.sh $baseGitHubCWD/runNaluRtest/nightly/heliumPlumeEdge
cp $NaluRtestCWD/nightly/heliumPlumeEdge/heliumPlumeEdge.norm.gold $baseGitHubCWD/runNaluRtest/nightly/heliumPlumeEdge
cp $NaluRtestCWD/nightly/heliumPlumeEdge/heliumPlumeEdge_rst.norm.gold $baseGitHubCWD/runNaluRtest/nightly/heliumPlumeEdge

# run it...  
./heliumPlumeEdge.sh

#=============================================================================
# edgeContact3D test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/edgeContact3D" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/edgeContact3D
fi

cd $baseGitHubCWD/runNaluRtest/nightly/edgeContact3D
cp $NaluRtestCWD/nightly/edgeContact3D/edgeContact3D.i $baseGitHubCWD/runNaluRtest/nightly/edgeContact3D
cp $NaluRtestCWD/nightly/edgeContact3D/*.xml $baseGitHubCWD/runNaluRtest/nightly/edgeContact3D
cp $NaluRtestCWD/nightly/edgeContact3D/*.exo.* $baseGitHubCWD/runNaluRtest/nightly/edgeContact3D
cp $NaluRtestCWD/nightly/edgeContact3D/edgeContact3D.sh $baseGitHubCWD/runNaluRtest/nightly/edgeContact3D
cp $NaluRtestCWD/nightly/edgeContact3D/edgeContact3D.norm.gold $baseGitHubCWD/runNaluRtest/nightly/edgeContact3D
# run it...  
./edgeContact3D.sh

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

#=============================================================================
# nonIsoElemOpenJet test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/nonIsoElemOpenJet" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/nonIsoElemOpenJet
fi

cd $baseGitHubCWD/runNaluRtest/nightly/nonIsoElemOpenJet
cp $NaluRtestCWD/nightly/nonIsoElemOpenJet/nonIsoElemOpenJet.i $baseGitHubCWD/runNaluRtest/nightly/nonIsoElemOpenJet
cp $NaluRtestCWD/mesh/2cm_ped_35K_mks.g* $baseGitHubCWD/runNaluRtest/nightly/nonIsoElemOpenJet
cp $NaluRtestCWD/nightly/nonIsoElemOpenJet/nonIsoElemOpenJet.sh $baseGitHubCWD/runNaluRtest/nightly/nonIsoElemOpenJet
cp $NaluRtestCWD/nightly/nonIsoElemOpenJet/nonIsoElemOpenJet.norm.gold $baseGitHubCWD/runNaluRtest/nightly/nonIsoElemOpenJet
# run it...  
./nonIsoElemOpenJet.sh

#=============================================================================
# nonIsoEdgeOpenJet test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/nonIsoEdgeOpenJet" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/nonIsoEdgeOpenJet
fi

cd $baseGitHubCWD/runNaluRtest/nightly/nonIsoEdgeOpenJet
cp $NaluRtestCWD/nightly/nonIsoEdgeOpenJet/nonIsoEdgeOpenJet.i $baseGitHubCWD/runNaluRtest/nightly/nonIsoEdgeOpenJet
cp $NaluRtestCWD/mesh/2cm_ped_35K_mks.g* $baseGitHubCWD/runNaluRtest/nightly/nonIsoEdgeOpenJet
cp $NaluRtestCWD/nightly/nonIsoEdgeOpenJet/nonIsoEdgeOpenJet.sh $baseGitHubCWD/runNaluRtest/nightly/nonIsoEdgeOpenJet
cp $NaluRtestCWD/nightly/nonIsoEdgeOpenJet/nonIsoEdgeOpenJet.norm.gold $baseGitHubCWD/runNaluRtest/nightly/nonIsoEdgeOpenJet
# run it...  
./nonIsoEdgeOpenJet.sh

#=============================================================================
# elemHybridFluids test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/elemHybridFluids" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/elemHybridFluids
fi

cd $baseGitHubCWD/runNaluRtest/nightly/elemHybridFluids
cp $NaluRtestCWD/nightly/elemHybridFluids/elemHybridFluids.i $baseGitHubCWD/runNaluRtest/nightly/elemHybridFluids
cp $NaluRtestCWD/mesh/hybrid.g* $baseGitHubCWD/runNaluRtest/nightly/elemHybridFluids
cp $NaluRtestCWD/nightly/elemHybridFluids/elemHybridFluids.sh $baseGitHubCWD/runNaluRtest/nightly/elemHybridFluids
cp $NaluRtestCWD/nightly/elemHybridFluids/elemHybridFluids.norm.gold $baseGitHubCWD/runNaluRtest/nightly/elemHybridFluids
# run it...  
./elemHybridFluids.sh

#=============================================================================
# edgeHybridFluids test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/edgeHybridFluids" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/edgeHybridFluids
fi

cd $baseGitHubCWD/runNaluRtest/nightly/edgeHybridFluids
cp $NaluRtestCWD/nightly/edgeHybridFluids/edgeHybridFluids.i $baseGitHubCWD/runNaluRtest/nightly/edgeHybridFluids
cp $NaluRtestCWD/mesh/hybrid.g* $baseGitHubCWD/runNaluRtest/nightly/edgeHybridFluids
cp $NaluRtestCWD/nightly/edgeHybridFluids/edgeHybridFluids.sh $baseGitHubCWD/runNaluRtest/nightly/edgeHybridFluids
cp $NaluRtestCWD/nightly/edgeHybridFluids/edgeHybridFluids.norm.gold $baseGitHubCWD/runNaluRtest/nightly/edgeHybridFluids
# run it...  
./edgeHybridFluids.sh

#=============================================================================
# elemClosedDomain test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/elemClosedDomain" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/elemClosedDomain
fi

cd $baseGitHubCWD/runNaluRtest/nightly/elemClosedDomain
cp $NaluRtestCWD/nightly/elemClosedDomain/elemClosedDomain.i $baseGitHubCWD/runNaluRtest/nightly/elemClosedDomain
cp $NaluRtestCWD/nightly/elemClosedDomain/*.g.* $baseGitHubCWD/runNaluRtest/nightly/elemClosedDomain
cp $NaluRtestCWD/nightly/elemClosedDomain/elemClosedDomain.sh $baseGitHubCWD/runNaluRtest/nightly/elemClosedDomain
cp $NaluRtestCWD/nightly/elemClosedDomain/elemClosedDomain.norm.gold $baseGitHubCWD/runNaluRtest/nightly/elemClosedDomain
# run it...  
./elemClosedDomain.sh

#=============================================================================
# mixedTetPipe test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/mixedTetPipe" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/mixedTetPipe
fi

cd $baseGitHubCWD/runNaluRtest/nightly/mixedTetPipe
cp $NaluRtestCWD/nightly/mixedTetPipe/mixedTetPipe.i $baseGitHubCWD/runNaluRtest/nightly/mixedTetPipe
cp $NaluRtestCWD/mesh/pipeTet.g* $baseGitHubCWD/runNaluRtest/nightly/mixedTetPipe
cp $NaluRtestCWD/nightly/mixedTetPipe/mixedTetPipe.sh $baseGitHubCWD/runNaluRtest/nightly/mixedTetPipe
cp $NaluRtestCWD/nightly/mixedTetPipe/mixedTetPipe.norm.gold $baseGitHubCWD/runNaluRtest/nightly/mixedTetPipe
# run it...  
./mixedTetPipe.sh

#=============================================================================
# inputFireEdgeUpwind test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/inputFireEdgeUpwind" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/inputFireEdgeUpwind
fi

cd $baseGitHubCWD/runNaluRtest/nightly/inputFireEdgeUpwind
cp $NaluRtestCWD/nightly/inputFireEdgeUpwind/inputFireEdgeUpwind.i $baseGitHubCWD/runNaluRtest/nightly/inputFireEdgeUpwind
cp $NaluRtestCWD/nightly/inputFireEdgeUpwind/*.e.* $baseGitHubCWD/runNaluRtest/nightly/inputFireEdgeUpwind
cp $NaluRtestCWD/nightly/inputFireEdgeUpwind/inputFireEdgeUpwind.sh $baseGitHubCWD/runNaluRtest/nightly/inputFireEdgeUpwind
cp $NaluRtestCWD/nightly/inputFireEdgeUpwind/inputFireEdgeUpwind.norm.gold $baseGitHubCWD/runNaluRtest/nightly/inputFireEdgeUpwind
# run it...  
./inputFireEdgeUpwind.sh

#=============================================================================
# nonIsoNonUniformEdgeOpenJet test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/nonIsoNonUniformElemOpenJet" ]; then
mkdir $baseGitHubCWD/runNaluRtest/nightly/nonIsoNonUniformElemOpenJet
fi

cd $baseGitHubCWD/runNaluRtest/nightly/nonIsoNonUniformElemOpenJet
cp $NaluRtestCWD/nightly/nonIsoNonUniformElemOpenJet/nonIsoNonUniformElemOpenJet.i $baseGitHubCWD/runNaluRtest/nightly/nonIsoNonUniformElemOpenJet
cp $NaluRtestCWD/mesh/2cm_ped_35K_mks.g* $baseGitHubCWD/runNaluRtest/nightly/nonIsoNonUniformElemOpenJet
cp $NaluRtestCWD/nightly/nonIsoNonUniformElemOpenJet/nonIsoNonUniformElemOpenJet.sh $baseGitHubCWD/runNaluRtest/nightly/nonIsoNonUniformElemOpenJet
cp $NaluRtestCWD/nightly/nonIsoNonUniformElemOpenJet/nonIsoNonUniformElemOpenJet.norm.gold $baseGitHubCWD/runNaluRtest/nightly/nonIsoNonUniformElemOpenJet
# run it...
./nonIsoNonUniformElemOpenJet.sh

#=============================================================================
# nonIsoNonUniformEdgeOpenJet test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/nonIsoNonUniformEdgeOpenJet" ]; then
mkdir $baseGitHubCWD/runNaluRtest/nightly/nonIsoNonUniformEdgeOpenJet
fi

cd $baseGitHubCWD/runNaluRtest/nightly/nonIsoNonUniformEdgeOpenJet
cp $NaluRtestCWD/nightly/nonIsoNonUniformEdgeOpenJet/nonIsoNonUniformEdgeOpenJet.i $baseGitHubCWD/runNaluRtest/nightly/nonIsoNonUniformEdgeOpenJet
cp $NaluRtestCWD/mesh/2cm_ped_35K_mks.g* $baseGitHubCWD/runNaluRtest/nightly/nonIsoNonUniformEdgeOpenJet
cp $NaluRtestCWD/nightly/nonIsoNonUniformEdgeOpenJet/nonIsoNonUniformEdgeOpenJet.sh $baseGitHubCWD/runNaluRtest/nightly/nonIsoNonUniformEdgeOpenJet
cp $NaluRtestCWD/nightly/nonIsoNonUniformEdgeOpenJet/nonIsoNonUniformEdgeOpenJet.norm.gold $baseGitHubCWD/runNaluRtest/nightly/nonIsoNonUniformEdgeOpenJet
# run it...
./nonIsoNonUniformEdgeOpenJet.sh

#=============================================================================
# milestoneRun test
#=============================================================================
if [ ! -d "$baseGitHubCWD/runNaluRtest/nightly/milestoneRun" ]; then
    mkdir $baseGitHubCWD/runNaluRtest/nightly/milestoneRun
fi

cd $baseGitHubCWD/runNaluRtest/nightly/milestoneRun
cp $NaluRtestCWD/nightly/milestoneRun/milestoneRun.i $baseGitHubCWD/runNaluRtest/nightly/milestoneRun
cp $NaluRtestCWD/nightly/milestoneRun/*.xml $baseGitHubCWD/runNaluRtest/nightly/milestoneRun
cp $NaluRtestCWD/mesh/1cm_ped_35K.g $baseGitHubCWD/runNaluRtest/nightly/milestoneRun
cp $NaluRtestCWD/nightly/milestoneRun/milestoneRun.sh $baseGitHubCWD/runNaluRtest/nightly/milestoneRun
cp $NaluRtestCWD/nightly/milestoneRun/milestoneRun.norm.gold* $baseGitHubCWD/runNaluRtest/nightly/milestoneRun
# run it...  
./milestoneRun.sh

echo "Rtest End"
