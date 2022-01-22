#!/bin/bash

# This is the Count Up Game.
# Have fun playing this game!

# Rule
# 1. This is two-player battle game.
# 2. The two players act alternately.
# 3. The player can increase up to 3 numbers each turn.
# 4. The player who declared 30 loses.

# ---------------------------------------------------------------------- #
# Function definition

# Start game.
start_game () {
	active_player=1
	count=0
	
	while [ $count -lt 30 ]
	do
		echo_player turn
	
		select1=`expr $count + 1`
		select2=`expr $count + 2`
		select3=`expr $count + 3`
	
		if [ $select3 -le 30 ]; then
			select_number $select1 $select2 $select3
		elif [ $select2 -le 30 ]; then
			select_number $select1 $select2
		else
			select_number $select1
		fi

		if [ $active_player -eq 1 ]; then
			active_player=2
		else
			active_player=1
		fi

	done

	echo_player Win!!
}

# Show choices.
select_number () {
	if [ $# -eq 3 ]; then
		select i in "$1" "$2" "$3"
		do
			echo_player selected $i
			count=$i
			break
		done
	elif [ $# -eq 2 ]; then
		select i in "$1" "$2"
		do
			echo_player selected $i
			count=$i
			break
		done
	else
		select i in "$1"
		do
			echo_player selected $i
			count=$i
			break
		done
	fi
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

# ---------------------------------------------------------------------- #

echo "Start the Count Up Game!!"

select n in "See the rules." "Play the game."
do
	if [ "$n" = "See the rules." ]; then
		echo "1. This is two-player battle game."
		echo "2. The two players act alternately."
		echo "3. The player can increase up to 3 numbers each turn."
		echo "4. The player who declared 30 loses."
	else
		start_game
		break
	fi
done
