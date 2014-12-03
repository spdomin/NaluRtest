#!/bin/bash
. ../../../NaluRtest/pass_fail.sh

CWD=$(pwd)
didSimulationDiffAnywhere=0
testTol=0.0000000000000001
if [ -f $CWD/PASS ]; then
    # already ran this test
    didSimulationDiffAnywhere=0
else
    mpiexec --np 8 ../../naluX -i heliumPlumeEdge.i -o heliumPlumeEdge.log
    determine_pass_fail $testTol "heliumPlumeEdge.log" "heliumPlumeEdge.norm" "heliumPlumeEdge.norm.gold"
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