#!/bin/bash
. ../../pass_fail.sh

CWD=$(pwd)
didSimulationDiffAnywhere=0

# determine tolerance
testTol=0.000000000001
platform=`uname`
if [ "$platform" == 'Linux' ]; then
    testTol=0.0000000000000001
fi

if [ -f $CWD/PASS ]; then
    # already ran this test
    didSimulationDiffAnywhere=0
else
    mpiexec --np 4 ../../naluX -i nonIsoEdgeOpenJet.i -o nonIsoEdgeOpenJet.log
    determine_pass_fail $testTol "nonIsoEdgeOpenJet.log" "nonIsoEdgeOpenJet.norm" "nonIsoEdgeOpenJet.norm.gold"
    didSimulationDiffAnywhere="$?"
fi

# write the file based on final status
if [ "$didSimulationDiffAnywhere" -gt 0 ]; then
    PASS_STATUS=0
else
    PASS_STATUS=1
    echo $PASS_STATUS > PASS
fi

exit $PASS_STATUS
