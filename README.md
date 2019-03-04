# code-for-DMUsoftware-result
#for single trait/multiple traits with permanent environment effect in one matrix
#calculate heritability
#calculate SE for heritability
#model example：
DMU dir file for
#--------------single trait with permanent environment 
$MODEL
1 1 0 0 0
0
3 0 7 2 5 6 7 8 1 1 
2 1 2
1 6
0
#--------------without permanent environment
$MODEL
1 1 0 0 0
0
3 0 6 2 5 6 7 8 1
1 1
1 6
0
#--------------multiple trait with permanent environment 
$MODEL
3 3 0 0 0
0
0
0
1 0 6 3 5 6 7 8 1
2 0 6 4 5 6 7 8 1
3 0 6 2 5 6 7 8 1
1 1
1 1
1 1
1 6
1 6
1 6
0 
#--------------multiple trait with permanent environment 
$MODEL
3 3 0 0 0
0
0
0
1 0 7 3 5 6 7 8 1 1
2 0 7 4 5 6 7 8 1 1
3 0 7 2 5 6 7 8 1 1
2 1 2
2 1 2
2 1 2
1 6
1 6
1 6
0 
#----------------------------------------------------------------
DMU_h2_DRP-function.txt：is the function for calculate
DMU_h2_DRP.R：is the running code in R
