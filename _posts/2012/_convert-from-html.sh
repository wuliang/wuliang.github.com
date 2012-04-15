#! /bin/sh
#FILENAME="2012-04-15-Function Apply() and Function call()"
FILENAME=$1
pandoc -f html -t markdown "${FILENAME}.html" -o "${FILENAME}.md"
#rm -f "${FILENAME}.html" (take care!)


