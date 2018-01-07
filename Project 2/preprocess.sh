#grep -v '^\?' foraIrSer-1.out > aux1.aux
grep -v '^\?' palavra2Anotado.out > aux1.aux
grep -v '^n-é-verbo' aux1.aux > aux2.aux
grep -v '^.*[Ff][Oo][Rr][Aa].*[Ff][Oo][Rr][Aa].*$' aux2.aux > aux3.aux

sed '/^ir/ s/\([^A-Za-z]\)\([Ff][Oo][Rr][Aa]\)\([^A-Za-z]\)/\1ir\3/' aux3.aux > aux4.aux
sed '/^ser/ s/\([^A-Za-z]\)\([Ff][Oo][Rr][Aa]\)\([^A-Za-z]\)/\1ser\3/' aux4.aux > aux5.aux

TAB=$'\t' 

sed 's/\(.*\)\('"${TAB}"'\)\(.*\)/\3/' aux5.aux > foraIrSer-1.final

rm *.aux

#grep -v '^\?' vimosVerVir.out > aux1.aux
grep -v '^\?' palavra1Anotado.out > aux1.aux
grep -v '^n-é-verbo' aux1.aux > aux2.aux
grep -v '^.*[Vv][Ii][Mm][Oo][Ss].*[Vv][Ii][Mm][Oo][Ss].*$' aux2.aux > aux3.aux

sed '/^vir/ s/\([^A-Za-z]\)\([Vv][Ii][Mm][Oo][Ss]\)\([^A-Za-z]\)/\1vir\3/' aux3.aux > aux4.aux
sed '/^ver/ s/\([^A-Za-z]\)\([Vv][Ii][Mm][Oo][Ss]\)\([^A-Za-z]\)/\1ver\3/' aux4.aux > aux5.aux

TAB=$'\t' 
sed 's/\(.*\)\('"${TAB}"'\)\(.*\)/\3/' aux5.aux > vimosVerVir.final

rm *.aux