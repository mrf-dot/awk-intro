# The AWK Language: A *Brief* Introduction

Mitch Feigenbaum - <https://mitchf.me>

## What is AWK?

- A programming language for manipulating and analyzing strings in text files
- Named for the three language creators: Aho, Weinberger, and Kernighan
- Originally created in 1977 at Bell Labs

## Challenge: Print the second column of a file if the first column contains "Mike"

### Python

```python
import re

with open('file.txt', 'r') as f:
	for line in f:
		cols = line.split()
		if re.search('Mike', cols[0]):
			print(cols[1])
```

### AWK

```awk
$1 ~ /Mike/ { print $2 }
```
---

## Quirks of AWK

- In C, everything is a number; in AWK, everything is a string
- AWK has the simplicity of Python combined with the *friendly* syntax of C
- AWK is programmed like a story, with a `BEGIN` block, pattern action blocks, and an `END` block
- Arrays in AWK start at 1 instead of 0
- AWK arrays (which are called "Associative Arrays") are really hash-maps
- There is no initialization or declaration in AWK
- AWK has no string concatenation operator: you just put strings together

```awk
BEGIN {
str1 = "Hi"; str2 = "Internet"; str3 = str1 " " str2
print str3 # Prints "Hi Internet"
}
```

---

## Why Use Awk?
- Native File I/O (No need to worry about opening and closing buffers)
- Columns in a file are automatically indexed into variables prefixed with `$` (ie `$0` for whole line, `$1` for first line)
- Significantly faster for some file operations than Python, especially for large data sets
	- This [data operation](https://livefreeordichotomize.com/posts/2019-06-04-using-awk-and-r-to-parse-25tb/) that took 8 minutes to do in Python takes 1/10 of a second with AWK
- Ability to use external Unix commands like `sort` directly in the program (works for pipes and file redirection)

```awk
{ print $2 | "sort -nr" } # Sort a file by descending numbers in the second column
{ print $1 > "/dev/stderr" } # Output the first column of a file to standard error
```

---

## AWK Case Study One

Recreate the Unix `nl` command (number the lines of a file)

```awk
{ print NR, $0 }
```

---

## AWK Case Study Two

Given employee name, hourly rate, and hours worked, find the total compensation.

```tsv
Mike	150.00	44
Greg	10.99	20
Paul	99.76	55
```

```awk
{ total += $2 * $3 }
END { print total }
```

---

## Bonus: Format the Number as Currency with Commas

```awk
{ total += $2 * $3 }
END { print format_as_currency(total) }

function format_as_currency(x,    num, len) {
	num = sprintf("%.2f", x)
	len = length(num) - 3
	for (i = len - 3; i > 0; i -= 3)
		num = substr(num, 1, i) "," substr(num, i+1)
	return "$" num
}
```

---

## AWK Case Study Three

Show which users have the most VS Code processes open on Stu.

```sh
ps aux | awk '
/[v]scode/ { processes[$1]++ }
END {
	for (user in processes)
		print processes[user], user | "sort -nr"
}'
```

---

## Want to Learn More?

- Stay tuned for the AWK talk later in the semester (Date TBD)
- Learn more about these AWK features:
	- `gsub`/`sub`/`match` for pattern matching and substitution
	- Using AWK on multi-gigabyte databases
	- Advanced pattern matching
	- Interactive AWK programs
	- Math in AWK
	- Using AWK in TSV and CSV files
	- Formatting AWK output with `sprintf` and `printf`
	- Sorting AWK output with the `sort` command
