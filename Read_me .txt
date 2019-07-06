1
# code-for-DMUsoftware-result
2
#for single trait/multiple traits with permanent environment effect in one matrix
3
#calculate heritability
4
#calculate SE for heritability
5
#model example：
6
DMU dir file for
7
#--------------single trait with permanent environment 
8
$MODEL
9
1 1 0 0 0
10
0
11
3 0 7 2 5 6 7 8 1 1 
12
2 1 2
13
1 6
14
0
15
#--------------without permanent environment
16
$MODEL
17
1 1 0 0 0
18
0
19
3 0 6 2 5 6 7 8 1
20
1 1
21
1 6
22
0
23
#--------------multiple trait with permanent environment 
24
$MODEL
25
3 3 0 0 0
26
0
27
0
28
0
29
1 0 6 3 5 6 7 8 1
30
2 0 6 4 5 6 7 8 1
31
3 0 6 2 5 6 7 8 1
32
1 1
33
1 1
34
1 1
35
1 6
36
1 6
37
1 6
38
0 
39
#--------------multiple trait with permanent environment 
40
$MODEL
41
3 3 0 0 0
42
0
43
0
44
0
45
1 0 7 3 5 6 7 8 1 1
46
2 0 7 4 5 6 7 8 1 1
47
3 0 7 2 5 6 7 8 1 1
48
2 1 2
49
2 1 2
50
2 1 2
51
1 6
52
1 6
53
1 6
54
0 
55
#----------------------------------------------------------------
56
DMU_h2_DRP-function.txt：is the function for calculate
57
DMU_h2_DRP.R：is the running code in R
58
​
@hanpengluo
Commit changes
Commit summary 
Update README.md
Optional extended description

