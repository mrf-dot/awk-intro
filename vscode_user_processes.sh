#!/bin/sh
ps aux | awk '
/[v]scode/ { processes[$1]++ }
END {
	for (user in processes)
		print processes[user], user | "sort -nr"
}'
