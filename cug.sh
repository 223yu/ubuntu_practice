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
		select1=`expr $count + 1`
		select2=`expr $count + 2`
		select3=`expr $count + 3`

		echo_player turn
		select_number $select1 $select2 $select3
		change_player

	done

	echo_player Win!!
}

# Start game with CPU.
start_cpu_game () {
	active_player=1
	count=0
	
	while [ $count -lt 30 ]
	do
		select1=`expr $count + 1`
		select2=`expr $count + 2`
		select3=`expr $count + 3`

		if [ $active_player -eq 1 ]; then
			echo_player turn			
			select_number $select1 $select2 $select3
			change_player	
		else
			echo_player CPU turn
			check_correct_route $select1 $select2 $select3
			change_player
		fi
	done
	
	echo_player Win!!
}

# Show choices.
select_number () {
	if [ $3 -le 30 ]; then
		select i in "$1" "$2" "$3"
		do
			echo_player selected $i
			count=$i
			break
		done
	elif [ $2 -le 30 ]; then
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

# Check if it is the correct route.
check_correct_route () {
	c=0
	n=$#
	unset array
	while [ $c -lt $n ]
	do
		if [ $1 -gt 30 ]; then
			shift
			c=$(expr $c + 1)
		elif [ $(expr $1 % 4) -eq 1 ]; then
			echo_player CPU_selected $1
			count=$1
			break
		else
			array[$c]=$1
			shift
			c=$(expr $c + 1)
		fi
	done
	
	# if all are false routes
	if [ $c -eq $n ]; then
		count=${array[$(expr $RANDOM % ${#array[*]})]}
		echo_player CPU_selected $count
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

select n in "See the rules." "Play the game." "Play the game with CPU."
do
	if [ "$n" = "See the rules." ]; then
		echo "1. This is two-player battle game."
		echo "2. The two players act alternately."
		echo "3. The player can increase up to 3 numbers each turn."
		echo "4. The player who declared 30 loses."
	elif [ "$n" = "Play the game." ]; then
		start_game
		break
	elif [ "$n" = "Play the game with CPU." ]; then
		start_cpu_game
		break
	fi
done
