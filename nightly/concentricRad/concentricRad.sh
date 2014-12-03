#!/bin/bash
CWD=$(pwd)
tolerance=0.0000000000000001
didSimulationDiffAnywhere=0
if [ -f $CWD/PASS ]; then
    didSimulationDiffAnywhere=0
else
    mpiexec --np 4 ../../naluX -i concentricRad.i -o concentricRad.log

    grep "Mean System Norm:" concentricRad.log  | awk '{print $4 " " $5 " " $6 }' > concentricRad.norm

# check for files...

# read in gold norm values
    goldCount=1
    goldFileContent=( `cat "concentricRad.norm.gold"`)
    for gfc in "${goldFileContent[@]}"
    do
	goldNorm[goldCount]=$gfc
	((goldCount++))
    done

# read in local norm values
    localCount=1
    localFileContent=( `cat "concentricRad.norm"`)
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
		didSimulationDiffAnywhere=1
	    fi
	done

    else
# length was not the same; fail
	didSimulationDiffAnywhere=1
    fi

fi

# write the file based on final status
if [ "$didSimulationDiffAnywhere" -gt 0 ]; then
    PASS_STATUS=0
else
    PASS_STATUS=1
    echo $diff > PASS
fi

exit $PASS_STATUS
