#Laboratory Exercise 2, Assignment 5 

.text 
    #  Assign X, Y 
    addi  $t1, $zero, 4    
    addi  $t2, $zero, 5    
    #  Expression Z = 3*X*Y 
    mul   $s0, $t1, $t2    
    mul   $s0, $s0, 3      
    mflo  $s1 
