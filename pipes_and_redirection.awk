{ print $2 | "sort -nr" } # Sort a file by descending numbers in the second column
{ print $1 > "/dev/stderr" } # Output the first column of a file to standard error
