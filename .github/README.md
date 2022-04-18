# Hello world

```
.data 
	str: .asciiz "Hello world\n"
	
.text
	li $v0, 4
	la $a0, str
	
	syscall
```

Click on each lab to see my notes or comment.
