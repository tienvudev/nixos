/^\s*\{$/ {
	prev = prev " {"
	next
}

/^\s*return;$/ {
	if (prev ~ /\)$/) {
		prev = prev " return;"
		next
	}
}

{
	if (NR > 1) {
		print prev
	}
	prev = $0
}

END {
	print prev
}
