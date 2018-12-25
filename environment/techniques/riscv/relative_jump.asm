# Technique - Relative Jump
add x2, x1, 50
looper:
	sw x1, (x2)
	add x2, x2, 4
	j looper
