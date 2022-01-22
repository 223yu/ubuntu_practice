
#!/bin/bash

# This is the Tic-tac-toe.
# Have fun playing this game!

# Rule
# 1. This is two-player battle game.
# 2. The two players act alternately.
# 3. Player1 puts "o" and player2 puts "x".
# 4. The Victory of the player who arranged three in one row.

# |---|---|---|
# | o |   |   |
# |---|---|---|
# |   | o |   |
# |---|---|---|
# | x | x | o |
# |---|---|---|

# ---------------------------------------------------------------------- #
# Function definition

# Start game
start_game () {
	active_player=1
	coordinates=0
	winner=0
	row1[0]=0
	row1[1]=0
	row1[2]=0
	row2[0]=0
	row2[1]=0
	row2[2]=0
	row3[0]=0
	row3[1]=0
	row3[2]=0
	
	while true
	do
		echo_results
		echo_player turn.
		echo "Enter the coordinates ex)a1"
		read coordinates
		change_result $coordinates
		change_player
		confirm_winner
		if [ $winner -eq 1 ]; then
			change_player
			echo_results
			echo_player Win!
			break
		elif [ $winner -eq 2 ]; then
			change_player
			echo_results
			echo_player Win!
			break
		fi
	done
	
}

# Show the result.
# $1,$2,$3 ... rowN[M]
echo_result () {
	col[0]=" "
	col[1]=" "
	col[2]=" "
	
	if [ $1 -eq 1 ]; then
		col[0]="o"
	elif [ $1 -eq 2 ]; then
		col[0]="x"
	fi

	if [ $2 -eq 1 ]; then
		col[1]="o"
	elif [ $2 -eq 2 ]; then
		col[1]="x"
	fi
	if [ $3 -eq 1 ]; then
		col[2]="o"
	elif [ $3 -eq 2 ]; then
		col[2]="x"
	fi

	echo "$4 | ${col[0]} | ${col[1]} | ${col[2]} |" 
}

# Show the results.
echo_results () {
	echo "    a   b   c  "
	echo "  |---|---|---|"
	echo_result ${row1[0]} ${row1[1]} ${row1[2]} 1
	echo "  |---|---|---|"
	echo_result ${row2[0]} ${row2[1]} ${row2[2]} 2
	echo "  |---|---|---|"
	echo_result ${row3[0]} ${row3[1]} ${row3[2]} 3
	echo "  |---|---|---|"
}

# Change the result.
# $1 ... coordinate
change_result () {
	case "$1" in
		"a1")
			if [ $active_player -eq 1 ]; then
				row1[0]=1
			else
				row1[0]=2
			fi
		;; 
		"b1")
			if [ $active_player -eq 1 ]; then
				row1[1]=1
			else
				row1[1]=2
			fi
		;; 
		"c1")
			if [ $active_player -eq 1 ]; then
				row1[2]=1
			else
				row1[2]=2
			fi
		;; 
		"a2")
			if [ $active_player -eq 1 ]; then
				row2[0]=1
			else
				row2[0]=2
			fi
		;; 
		"b2")
			if [ $active_player -eq 1 ]; then
				row2[1]=1
			else
				row2[1]=2
			fi
		;; 
		"c2")
			if [ $active_player -eq 1 ]; then
				row2[2]=1
			else
				row2[2]=2
			fi
		;; 
		"a3")
			if [ $active_player -eq 1 ]; then
				row3[0]=1
			else
				row3[0]=2
			fi
		;; 
		"b3")
			if [ $active_player -eq 1 ]; then
				row3[1]=1
			else
				row3[1]=2
			fi
		;; 
		"c3")
			if [ $active_player -eq 1 ]; then
				row3[2]=1
			else
				row3[2]=2
			fi
		;; 
	esac
}

# Show [Player1(red) or Player2(blue) $1 $2].
# $1, $2 ... arbitrary string.
echo_player () {

	if [ $active_player -eq 1 ]; then
		echo -e "\e[31mPlayer$active_player\e[m $1 $2"
	else
		echo -e "\e[34mPlayer$active_player\e[m $1 $2"
	fi
}

# Change the player.
change_player () {
	if [ $active_player -eq 1 ]; then
		active_player=2
	else
		active_player=1
	fi
}

# Confirm the winner
confirm_winner () {
	if [ ${row2[1]} -eq 1 ]; then
		if [ ${row1[0]} -eq 1 ] && [ ${row3[2]} -eq 1 ]; then
			winner=1
		elif [ ${row1[1]} -eq 1 ] && [ ${row3[1]} -eq 1 ]; then
			winner=1
		elif [ ${row1[2]} -eq 1 ] && [ ${row3[0]} -eq 1 ]; then
			winner=1
		elif [ ${row2[0]} -eq 1 ] && [ ${row2[2]} -eq 1 ]; then
			winner=1
		fi
	elif [ ${row1[0]} -eq 1 ]; then
		if [ ${row1[1]} -eq 1 ] && [ ${row1[2]} -eq 1 ]; then
			winner=1
		elif [ ${row2[0]} -eq 1 ] && [ ${row3[0]} -eq 1 ]; then
			winner=1
		fi
	elif [ ${row3[2]} -eq 1 ]; then
		if [ ${row1[2]} -eq 1 ] && [ ${row2[2]} -eq 1 ]; then
			winner=1
		elif [ ${row3[0]} -eq 1 ] && [ ${row3[1]} -eq 1 ]; then
			winner=1
		fi
	fi

	if [ ${row2[1]} -eq 2 ]; then
		if [ ${row1[0]} -eq 2 ] && [ ${row3[2]} -eq 2 ]; then
			winner=2
		elif [ ${row1[1]} -eq 2 ] && [ ${row3[1]} -eq 2 ]; then
			winner=2
		elif [ ${row1[2]} -eq 2 ] && [ ${row3[0]} -eq 2 ]; then
			winner=2
		elif [ ${row2[0]} -eq 2 ] && [ ${row2[2]} -eq 2 ]; then
			winner=2
		fi
	elif [ ${row1[0]} -eq 2 ]; then
		if [ ${row1[1]} -eq 2 ] && [ ${row1[2]} -eq 2 ]; then
			winner=2
		elif [ ${row2[0]} -eq 2 ] && [ ${row3[0]} -eq 2 ]; then
			winner=2
		fi
	elif [ ${row3[2]} -eq 2 ]; then
		if [ ${row1[2]} -eq 2 ] && [ ${row2[2]} -eq 2 ]; then
			winner=2
		elif [ ${row3[0]} -eq 2 ] && [ ${row3[1]} -eq 2 ]; then
			winner=2
		fi
	fi
}
# ---------------------------------------------------------------------- #

echo "Start the Tic-tac-toe!!"

select n in "See the rules." "Play the game."
do
	if [ "$n" = "See the rules." ]; then
		echo "1. This is two-player battle game."
		echo "2. The two players act alternately."
		echo "3. Player1 puts 'o' and player2 puts 'x'."
		echo "4. The Victory of the player who arranged three in one row."

		echo "|---|---|---|"
		echo "| o |   |   |"
		echo "|---|---|---|"
		echo "|   | o |   |"
		echo "|---|---|---|"
		echo "| x | x | o |"
		echo "|---|---|---|"
	else
		start_game
		break
	fi
done
