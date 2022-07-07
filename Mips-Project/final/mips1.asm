.data
	String: .asciiz  "*22222*               ****************             *33333*        \n"
.text
	la $s2, String
	sb $0 21($s2)
	sb $s0, 21($s2)