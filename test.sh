#!/bin/sh

for file in "$1"/*.pl
do
	echo "====================>$file<===================="	
	filename=`echo $file | sed 's/.pl//g'`
	echo "Running ./perl2python.pl $filename.pl"
	./perl2python.pl $file > $filename.py

	answer=$filename\_expected
	perl "$filename.py"
	python "$answer.py"
	perl "$filename.py" > $filename\_output
	python "$answer.py" > $answer\_output
	echo "Running diff on the output of both programs"
	if (diff $filename\_output $answer\_output)
	then
		echo "Test succeeded"
	else
		echo "Test failed"
	fi
	echo "==============================================="
done
exit 0
