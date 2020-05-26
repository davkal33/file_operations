#!/bin/bash

# $1 - katalog do przeszukania $2 - plik wynikowy ze sciezkami plikow

fun1()
{
	if [[ $# -ne 2 ]]; then
		echo "Nieodpowiednia liczba argumentow wejsciowych"
		echo "Koncze dzialanie skryptu"
		exit -1
	fi
	if [[ ! -d "$1" ]]; then
		echo "Pierwszy argument nie jest katalogiem"
		echo "Koncze dzialanie skryptu"
		exit -1
	fi
	if [[ ! -r "$1" ]]; then
		echo "Nie masz prawa do odczytu zawartosci katalogu"
		echo "Koncze dzialanie skryptu"
		exit -1
	fi
	if [[ -e "$2" ]]; then
		if [[ ! -w $2 ]]; then
			echo "Plik wynikowy istnieje, ale nie masz prawa do zapisu"
			echo "Koncze dzialanie skryptu"
			exit -1
		fi
	else
		echo "Plik wynikowy nie istnieje. Tworze nowy plik o nazwie plik.txt"
		touch plik.txt
		$2="plik.txt"
	fi


	echo "Rozmiar plikow jest podany w bajtach" >> $2

	find $1 -type f | xargs ls -l | sort -rn -k 5,5 | head -n 3 | cut -d " " -f 5,9 >> $2
}
fun1 $1 $2




# 	$1 - drzewo katalogow $2 - szukane rozszerzenie $3 - katalog z kopiami
fun2()
{
	if [[ $# -ne 3 ]]; then
		echo "Nieodpowiednia liczba argumentow wejsciowych"
		echo "Koncze dzialanie skryptu"
		exit -1
	fi

	if [[ ! -d "$1" ]]; then
		echo "Pierwszy argument nie jest katalogiem"
		echo "Koncze dzialanie skryptu"
		exit -1
	fi

	if [[ ! -r "$1" ]]; then
		echo "Nie masz prawa do odczytu zawartosci katalogu"
		echo "Koncze dzialanie skryptu"
		exit -1
	fi

	find $1 -type f -name "*.$2" | 
	while read line
	do
		cp $line $3
	done 

	cd $3

	for file in *.$2
	do
		mv $file `basename $file $2`COPY
	done
}
fun2 $1 $2 $3

#!/bin/bash

# $1 - katalog do przeszukania $2 - plik wyjsciowy
fun3()
{
	if [[ $# -ne 2 ]]; then
		echo "Nieodpowiednia liczba argumentow wejsciowych"
		echo "Koncze dzialanie skryptu"
		exit -1
	fi

	if [[ ! -d "$1" ]]; then
		echo "Pierwszy argument nie jest katalogiem lub katalog nie istnieje"
		echo "Koncze dzialanie skryptu"
		exit -1
	fi

	if [[ ! -f "$2" ]]; then
		echo "Drugi argument nie jest plikiem lub plik nie istnieje"
		echo "Koncze dzialanie skryptu"
		exit -1
	fi

	find $1 -type f -exec ls -i {} \; | cut -d " " -f 1 >> "$2"

	x=0
	while read line
	do
		tab[$x]=$line
		x=$[$x+1]

	done <"$2"

	for x in ${tab[@]}
	do
		d=$x
		c=0
		for y in ${tab[@]}
		do
			if [[ $d -eq $y ]];then
				c=$[$c+1]
			else
				continue
			fi	
		done
		c=$[$c-1]
		if [[ $c != 0 ]];then
			echo "Dowiazanie twarde ma inode $d" >> "$2"
		else
			continue
		fi

	done
}
fun3 $1 $2 








		




