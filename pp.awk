#!/usr/bin/env -S awk -f
# Simple preprocessor
# Put shell code between #!\n tokens.

function swch() {
	script = (script + 1) % 2
	gsub(/\n+$/, "", verbatim)
	gsub(/[']/, "'\"'\"'", verbatim)
	if (length(verbatim) != 0) { print "echo '" verbatim "'" }
	verbatim = ""
}

/^#!$/ {
	swch()
	next
}

!script {
	verbatim = verbatim $0 "\n"
}

script {
	print $0
}

END { swch() }
