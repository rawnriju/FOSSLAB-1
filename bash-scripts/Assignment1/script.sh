#!/bin/bash

#converting pdf to text file usig pdftotext
pdftotext -layout RESULT.pdf

#getting csb details
#wget http://14.139.184.212/ask/c4b/c4b.txt

#collecting details of only CS students
cat RESULT.txt | grep MDL16CS > RESULT_CS.txt

#filtering CSB students list
cut -d$'\t' -f4 c4b.txt > temp.txt
join -2 1 temp.txt RESULT_CS.txt 1>RESULT_CSB.txt 2>/dev/null
rm temp.txt

#reorder the file by removing unnecesary spaces
cat RESULT_CSB.txt | tr -d '' > temp.txt
rm RESULT_CSB.txt
mv temp.txt RESULT_CSB.txt

#getting the grades of each student
cat RESULT_CSB.txt | cut -d' ' -f1 > head.txt

for i in {2..9}
do
  cat RESULT_CSB.txt | cut -d'(' -f$i | cut -d')' -f1 > temp_col_$i.txt
done

paste head.txt temp_col_*.txt > RESULT_FINAL.txt
rm temp_col_*.txt
rm head.txt

#function to find sgpa
find_sgpa () {
  cat $1
}

cp RESULT_FINAL.txt temp.txt
#finding the sgpa
while read -r line
do
  find_sgpa $line
done <temp.txt

