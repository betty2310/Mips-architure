# Service number `syscall`

> A number of system services, mainly for input and output, are available for use by your MIPS program

### How to use SYSCALL system services

1. Load the service number in register `$v0`.  

2. Load argument values, if any, in `$a0`, `$a1`, `$a2` as specified.  

3. Issue the `SYSCALL` instruction.  

4. Retrieve return values, if any, from result registers as specified.

### Sample file I\\O

```c
.data
  fout:   .asciiz "testout.txt"      # filename for output
  buffer: .asciiz "The quick brown fox jumps over the lazy dog."
.text
  ###############################################################
  # Open (for writing) a file that does not exist
  li   $v0, 13       # system call for open file
  la   $a0, fout     # output file name
  li   $a1, 1        # Open for writing (flags are 0: read, 1: write)
  li   $a2, 0        # mode is ignored
  syscall            # open a file (file descriptor returned in $v0)
  move $s6, $v0      # save the file descriptor 
  ###############################################################
  # Write to file just opened
  li   $v0, 15       # system call for write to file
  move $a0, $s6      # file descriptor 
  la   $a1, buffer   # address of buffer from which to write
  li   $a2, 44       # hardcoded buffer length
  syscall            # write to file
  ###############################################################
  # Close the file 
  li   $v0, 16       # system call for close file
  move $a0, $s6      # file descriptor to close
  syscall            # close file
  ###############################################################
```

### `strcpy` from `C`

Copy 1 đoạn string từ `src` đến `dest`, như hàm `strcpy`đó. 

Thuật giải:

+ Vòng lặp chạy từ đầu đến đít `src`

+ Gặp ký tự `!=` giá trị `0` thì thực hiện copy giá trị đó tới `dest`

+ Ngược lại, gặp bằng `0` thì dừng

Sở dĩ là `0` bởi vì cuối string  là kí tự kết thúc xâu`\0` có giá trị `0`

Mõm thì đơn giản thế, nhưng vào trong `mips` nó lại khác :v

Nhưng vẫn dễ, làm phát ăn ngay :v.

Cơ bản, phải hiểu rõ việc load address (`la`), load giá trị từ adress (ở đây từng kí tự lưu trong 1 byte nên sử dụng `lb`), sau đó store lại byte giá trị đó bằng `sb`. Còn việc loop hay biến `i` thì đã làm nhiều rồi.

### Count length of string

> Get input string from user and count length of this string.

Bài này mới được áp dụng cái syscall ở trên :v. Bỏ qua thuật toán đếm độ dài đi, bài toán này cho mình áp dụng cách sử dụng input message string từ dialog và output int từ dialog.

Cái đầu tiên là input:

```
# get input str from user
GETINPUT:
	li $v0, 54
	la $a0, message1
	la $a1, str
	li $a2, 100
	syscall 
	slt $t9, $a1, $zero 
	bne $t9, $zero, GETINPUT
```

Tại sao lại có thêm 2 dòng cuối sau `syscall`, mình muốn user nhập chính xác string thì thôi. Thanh ghi `a1` chứa giá trị chỉ trạng thái của input, nói chung `< 0` thì là input không tốt, nên cho lặp lại.

Output cũng không có gì khó. Nhưng có một cái quan trọng là;

**NOTE**: string mình nhập vào có `\n`ở cuối (do cái `enter` bấm mà, lưu tất vào buffer), nên khi đếm xong thì giá trị phải `-1`. 
