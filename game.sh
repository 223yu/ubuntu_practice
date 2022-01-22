
#!/bin/bash

echo "Which game do you play?"
select n in "Count up game" "Tic-tac-toe" "Exit"
do
	if [ "$n" = "Count up game" ]; then
		./cug.sh
	elif [ "$n" = "Tic-tac-toe" ]; then
		./ox.sh
	elif [ "$n" = "Exit" ]; then
		break
	fi
done
