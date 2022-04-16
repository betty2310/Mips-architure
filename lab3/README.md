# Exercise 1

> Basic if-then-else statement

Chắc mình cần notes 1 tẹo liên quan đến syntax

+ 1 block code: Khởi đầu bằng 1 từ gì đó, theo sau là `:`

    ```
    start:
        slt 	$t0, $s2, $s1	#j<i
        beq 	$t0, $zero, else            
        addi	$t1, $t1, 1
        addi 	$t3, $zero, 1
        j		endif
    else:
        ....
    ```
    Có 2 block code là `start` và `else`.

+ Tận lệnh dạng `jump` để nhảy đến các block code này, đó cũng là mấu chốt của `if-then-else`. Như bên trên thấy ở câu lệnh `beq` là J types, có thể nhảy đến block code là `else`.

+ 1 điều nữa là `mips` luôn thực hiện các câu lệnh từ trên xuống dưới, và đếch bỏ qua 1 câu lệnh nào cả (kể cả trong các block code riêng biệt), ta muốn bỏ qua thì phải dùng lệnh `j` để nhảy nhay qua cái khác.

Việc so sánh trong thứ ngôn ngữ máy hiểu (chứ người khó hiểu) này cần 2 bước:

1. Biểu thức `(i < j) ? check = true : false`: đầu tiên sử dụng `slt` hoặc tương đương, để tìm xem tham số `check` là `1` hay `0` (qui ước `1` lớn hơn và `0` nhỏ hơn). 

2. Từ tham số `check`, sử dụng `beq` hoặc `bne` để nhảy đến các block code tiếp theo xử lý. 

3. Một lưu ý là nếu ko cần nhảy thì cứ việc viết tiếp các lệnh ngay dưới, sau đó cuối cùng, sử dụng 1 lệnh `j` để nhảy đến 1 block code rỗng (ví dụ trên là `endif`), nếu không thì nó lại tiếp tục các câu lệnh tiếp theo ngay dưới nó, đúng không?

# Exercise 2

> Loop statement. 

Thật ra thì mình chưa hiểu lắm mảng ở đây là sao, làm sao để tạo mảng và lưu giá trị cho nó, phải biết vậy mới làm được bài toán tính tổng các giá trị trong mảng chứ?

Nhưng về `loop` thì cơ bản như sau:

```
i = 0 
loop:  
    if (i >= n) goto endloop 
    # code here
    i = i + step
    goto loop 
endloop: 
```

# Exercise 3

> Switch-case statement

Dễ hiểu mà :v

```
.text:
    li $t0, 0 # case 0
	li $t1, 1 # case 1
	li $t2, 2 # case 2
	
	beq $s1, $t0, case_0
	beq $s1, $t1, case_1
	beq $s1, $t2, case_2
	j default
	
case_0: 
	addi $s2, $s2, 1
	j continue
case_1:
	sub $s2, $s2, $t1
	j continue
case_2:
	add $s3, $s3, $s3
	j continue
default:
continue:
```
