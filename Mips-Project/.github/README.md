# Đề bài

Write a program to: Assume that you already have 1 variable (number students) and 2 arrays (student name, mark) in memory

1. Read in the number of students in the class.

2. Read information about each student, including: Name, Math mark.

3. List the names of all students who have not passed the Math exam.

# Cách thực hiện

+ Đầu vào của chương trình gồm số lượng sinh viên, 2 mảng lưu tên, điểm của sinh viên và điểm tối thiểu của sinh viên để đánh giá có vượt qua bài kiểm tra hay không. Các dữ liệu được khởi tạo sẵn trong vùng data.

+ Đầu ra của chương trình là danh sách các sinh viên không vượt qua bài kiểm tra.

+ Sử dụng 1 vòng for để duyệt qua từng sinh viên, kiểm tra điểm của sinh viên với điểm tối thiểu, in ra console thông tin sinh viên thoả mãn điều kiện.

# Ý nghĩa một số thanh ghi chính sử dụng

+ `$s0`: lưu giá trị số lượng sinh viên.

+ `$s1`: lưu giá trị địa chỉ của phần tử đầu trong mảng điểm sinh viên.

+ `$s2`: lưu giá trị địa chỉ của phần tử đầu trong mảng tên sinh viên.

+ `$f0`: lưu giá trị điểm tối thiểu để đánh giá trượt hoặc đỗ.

+ `$t0`: lưu giá trị kích thước của phần tử mảng điểm sinh viên.

+ `$t1`: lưu giá trị kích thước của phần tử mảng tên sinh viên.

# Ý nghĩa chương trình con sử dụng

## Compare

+ So sánh giá trị của 2 biến kiểu float

+ Đầu vào gồm 2 biến kiểu float `$f0` và `$f1`.

+ Đầu ra gồm 1 biến kiểu int `$v0`. `$v0 = 1` nếu `$f0 < $f1` và 0 trong các trường hợp còn lại. 

Để so sánh 2 số hạng kiểu float, sử dụng câu lệnh `c.lt.s`. Để lấy trạng thái của phép so sánh nêu trên, sử dụng câu lệnh `movt`. Sau đó gán cho `$v0`.

```
.ent compare
compare:
	c.lt.s $f0, $f1			# flag = ($f0 < $f1) ? 1 : 0
	li $t8, 0
	li $t9, 1
	movt $t8, $t9			# if flag == 1, $t8 = $t9 
	add $v0, $t8, $zero
	jr $ra	
.end compare
```

### Print

+ In thông tin của sinh viên gồm điểm và tên ra màn hình console
+ Đầu vào gồm địa chỉ điểm của sinh viên và địa chỉ tên của sinh viên đó.

Sử dụng các functions của `syscall`.

```
.ent print
print:
	# in điểm sinh viên ra console
	li $v0, 2
	l.s $f12, 0($a0)
	syscall

	# in ký tự \t <tab>
	li $v0, 4
	la $a0, tab
	syscall
	
	# in tên sinh viên
	li $v0, 4
	move $a0, $a1
	syscall

	# in ký tự  \n <newline>
	li $v0, 4
	la $a0, nextline
	syscall
	jr $ra
.end print
```