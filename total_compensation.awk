{ total += $2 * $3 }
END { print format_as_currency(total) }

function format_as_currency(x,    num, len) {
	num = sprintf("%.2f", x)
	len = length(num) - 3
	for (i = len - 3; i > 0; i -= 3)
		num = substr(num, 1, i) "," substr(num, i+1)
	return "$" num
}
