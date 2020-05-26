#!/bin/bash

#Z1

echo "sciezka test $1"
echo "sciezka test $2"
echo "sciezka test $3"


var1=$(wc -l $1 | cut -d " " -f 1) #ilosc linijek w pliku zdrodlowym


if [ -r $1 ]; then     #sprawdzanie prawa do odczytu
	echo "Masz prawo do odczytu pliku zrodlowego"
else
	echo "Nie masz prawa do odczytu pliku zdrodlowego"
	exit -1
fi

if [ -e $2 ]; then
	echo "plik docelowy nr1 istnieje"
	if [ -e $3 ]; then
		echo "plik docelowy nr2 istnieje"
		if [ -w $2 ] && [ -w $3 ]; then					#oba pliki istnieja, wiec zgodnie z poleceniem sprawdzam czy sa -writable
			echo "Masz prawo do zapisu danych w plikach docelowych"
		else
			echo "Nie masz prawa do zapisu danych w plikach docelowych"
		
		fi
		> $2             				                #czyszczenie zawartoc
		> $3					
	else
		echo "plik docelowy nr2 nie istnieje, tworze nowy plik o nazwie file2.txt"
		touch file2.txt
	fi
else
	echo "plik docelowy nr1 nie istnieje. Tworze nowy plik o nazwie file1.txt"
	touch file1.txt
	if [ -e $3 ]; then
		echo "Plik docelowy nr2 istnieje"
	else
		echo "Plik docelowy nr2 nie istnieje, tworze nowy plik o nazwie file2.txt"
		touch file2.txt
	fi

fi
# petla rozdzielajaca linie textu w odpowiednie pliki docelowe + numer linii
for (( i=1; i<=var1; i++)) 
do
	n=$(($i%2))
	if [ $n -eq 0 ]; then
		echo -n "$i " >> $2
		head -n $i $1 | tail -n -1 >> $2
	else
		echo -n "$i " >> $3
		head -n $i $1 | tail -n -1 >> $3
	fi 
done







#Zadanie2

#!/bin/bash

#pierszy argument = sciezka do katalogu w ktorym bedziemy tworzyc inne katalogi
:
if [[ -d $1 ]]; then   
	echo "Sciezka wskazuje na katalog"
else
	echo "Sciezka nie wskazuja na katalog. Blad."
	exit -1
fi

if [[ -w $1 ]]; then
	echo "Masz prawa do zapisu w podanym katalogu"
else
	echo "Nie masz prawa zapisu w podanym katalogu"
	exit -1
fi
 

while read line
do
	echo "test0"
	echo "$line 1"
	x=$(cut -d : -f 2)
	echo "$line 2"
	echo "$x taigi"
	if [[ ${line:0:1} == "D" ]]; then
		mkdir $x
	elif [[ ${line:0:1} == "F" ]]; then

		touch $x
	else
		echo "test3"
		continue
	fi
done <"$2" #czytany plik

'





















