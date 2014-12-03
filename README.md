NaluRtest
=========

Regression test suite for Nalu

## Directions

Thus far, both the Nalu and NaluRtest git repository should have been cloned. Moreover, the build process has been completed with a `naluX` executable created in the `Nalu/build` location.

Within the `NaluRtest` directory is a file by the name of run_tests.sh. Executing this bash script,

	./run_test.sh
	
will result in a temporary directory called runNaluRtest created in the ../ location.

Executing the script will provide the set of pass/diff. Code that results in a diff is not to be pushed unless the diffs are understood.

The pass/diff is based on a set of integrated norms, time step and time step count at the end of time step. Simulations will report
a diff if any single time step has a set of results that are off by the test tolerance.

Re-running the run_test.sh script will check if directories are already in existance. If a previous test voucher is a PASS, the test will not be run again. 

## Sample Output

	Rtest Begin
	..concentricRad............... PASSED
	..edgeContact3D............... PASSED
	..edgeFluidsPmrPeriodic....... PASSED
	..edgePipeCHT................. PASSED
	..elemBackStepLRSST........... FAILED
	..heliumPlumeEdge............. PASSED
	Rtest End


