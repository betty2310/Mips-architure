# Learn in this lab

## Overflow

Tràn số - khi lượng bit ta có không đủ để biểu diễn lượng dữ liệu ta mong muốn. Trong `mips`, overflow có thể xảy ra khi thực hiện các phép toàn với số 32 bit. Vậy làm sao để kiểm tra phép toán thực hiện có gây ra tràn số hay không?

+ 2 toàn tử phải cùng dấu (sign) hiển nhiên

+ Nếu cùng là số dương, nếu tổng nhỏ 1 toán hạng bất kì

+ Nếu cùng là số âm, nếu tổng lại lớn hơn 1 toán hạng bất kì.

Từ đó xây dựng nên solution cho bài toàn xác định overflow. 

1. Kiểm tra 2 toán hạng có cùng dấu hay không?
   
   2 bit cao nhất (bit 31) ghi dấu của toán hạng này (0 - dương và 1 - âm). Tức là ta chỉ cần quan tâm 2 bit đó. Ta thấy khi chúng đều là 0 và 1 thì cùng dấu (tức là `true` ) và ngược lại. Điều đó giúp liên tưởng đến toán tử logic `xor`. 

2. Kiểm tra 2 toán hạng âm hay dương
   
   Sau bước trên ta biết nó cùng dấu rồi, giờ chỉ việc kiểm tra bất kì 1 số thôi. Âm hay dương sẽ dẫn đến điều kiện để ra kết quả.

3. So sánh với tổng 2 số dựa theo điều kiện âm hay dương.



1 mẹo code trong `mips` là mình nghĩ luôn code đáp án ra trước và ở cuối cùng, ngay sau là `END`. Luồng code từ trên xuống dưới nên sẽ luôn thực hiện điều này. Các trường hợp `if-else` nên sử dụng khéo léo đề jump xuống `END`, hoặc tiếp tục chạy để thực hiện đáp án mình muốn. 

## Extract infor from one register.

Các thanh ghi 32 bit, giờ muốn chỉ luốn lấy giá trị ví dụ 2 bit đầu, 2 bit cuối, hoặc bit thứ 10 của thanh ghi chẳng hạn, thì làm thế nào?

Thì dùng phép `and` thôi, cơ bản thì cũng dễ :v. Chỉ cần nhớ sử dụng `andi` hoặc `and`, nhưng trong trường hợp muốn lấy chính xác cụ thể như này thì nên dùng `andi` . 

Ví dụ:

```
li $s0, 0x0563 					
andi $t0, $s0, 0xff 			
andi $t1, $s0, 0x0400 			
```

+ `$s0` có giá trị ở dạng hexa là 0000 0563.

+ `andi` đầu tiên lấy 2 giá trị cuối cùng ở mã hexa của `$s0` , `ff` ở binary tức là `1111 1111`, `and` sẽ ra chính nó. 

+ Tương tự với phép `andi` thứ 2. để ý 2 bit cuối lúc này là `00`, tức là mình bỏ qua 2 số cuối của `$s0`. Sau đó đến số 4 (ở dạng nhị phân là `0100`), tức là mình lấy bit thứ 10 của `$s0` - hiện đang lưu trữ ở số 5 (`0101`), nên ta lấy được số `1`. 
  
  Ở dạng nhị phân `$t1` lúc này: `0000 0000 0000 0000 0000 0100 0000 0000` => Hexa `0x00000400`.

## Multiply but don't use `*`

Cái này thì trước đây mình từng dùng rồi. Toán tử logic dịch bit (trái hoặc phải), trong `C` là `>>` hoặc `<<`. 
Ứng dụng trong phép nhân, có thể sử dụng phép dịch trái `n` bit để nhân số hạng với $2^n$ 

# Assignments


