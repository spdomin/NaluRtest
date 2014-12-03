#!/bin/bash

determine_pass_fail() {

    diffAnywhere=0
    tolerance=$1
    logFileName=$2
    localNormFileName=$3
    goldNormFileName=$4

    # check for required files: log file and gold
    if [ ! -f "$logFileName" ]; then
	diffAnywhere=1
    fi

    # check for gold norm file
    if [ ! -f "$goldNormFileName" ]; then
	diffAnywhere=1
    fi

    grep "Mean System Norm:" "$logFileName"  | awk '{print $4 " " $5 " " $6 }' > "$localNormFileName"

    # make sure the grep  worked
    if [ ! -f "$localNormFileName" ]; then
	diffAnywhere=1
    fi
    
# read in gold norm values
    goldCount=1
    goldFileContent=( `cat "$goldNormFileName"`)
    for gfc in "${goldFileContent[@]}"
    do
	goldNorm[goldCount]=$gfc
	((goldCount++))
    done

# read in local norm values
    localCount=1
    localFileContent=( `cat "$localNormFileName"`)
    for lfc in "${localFileContent[@]}"
    do
	localNorm[localCount]=$lfc
	((localCount++))
    done

    if [ $(echo " $goldCount - $localCount" | bc) -eq 0 ]; then

# the lengths the same... proceed

	for ((i=0;i<$goldCount;++i)); do
	    modLocalNorm=$(printf "%1.32f" ${localNorm[i]})
	    modGoldNorm=$(printf "%1.32f" ${goldNorm[i]})
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

# test the difference
	    if [ $(echo " $absDiff > $tolerance" | bc) -eq 1 ]; then
		echo "yep, I am here"
		diffAnywhere=1
	    fi
	done

    else
# length was not the same; fail
	diffAnywhere=1
    fi

    return $diffAnywhere
}

CWD=$(pwd)
didSimulationDiffAnywhere=0
testTol=0.0000000000000001
if [ -f $CWD/PASS ]; then
    # already ran this test
    didSimulationDiffAnywhere=0
else
    mpiexec --np 4 ../../naluX -i concentricRad.i -o concentricRad.log
    determine_pass_fail $testTol "concentricRad.log" "concentricRad.norm" "concentricRad.norm.gold"
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
