#!/bin/bash
CWD=$(pwd)
tolerance=0.0000000000000001
if [ -f $CWD/PASS ]; then
    echo "edgePipeCHT has already passed"
    PASS_STATUS=1
else
    mpiexec --np 4 ../../naluX -i edgePipeCHT.i -o edgePipeCHT.log
    grep "Mean System Norm:" edgePipeCHT.log  | awk '{print $4}' > edgePipeCHT.norm

    read localNorm < "edgePipeCHT.norm"
    read goldNorm < "edgePipeCHT.norm.gold"

    echo "This is the local norm - $localNorm"
    echo "This is the gold norm - $goldNorm"

    modLocalNorm=$(printf "%1.32f" $localNorm)
    modGoldNorm=$(printf "%1.32f" $goldNorm)

    echo "This is the modified local norm - $modLocalNorm"
    echo "This is the modified gold norm - $modGoldNorm"

# compute the difference
    diff=$(echo $modLocalNorm - $modGoldNorm | bc)
 
# make sure diff is positive.. abs anyone?
    zero=0.0
    minusOne=-1.0
    if [ $(echo " $diff < $zero" | bc) -eq 1 ]; then
	absDiff=$(echo $diff*$minusOne | bc)
    else
	absDiff=$diff
    fi

    echo "the CHT diff is $diff"

# test the difference
    if [ $(echo " $absDiff < $tolerance" | bc) -eq 1 ]; then
    	echo "edgePipeCHT has passed: $absDiff"
	PASS_STATUS=1
	echo $diff > PASS
    else
	echo "edgePipeCHT has NOT passed $absDiff"
	PASS_STATUS=0
    fi
fi
exit $PASS_STATUS
