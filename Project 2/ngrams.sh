###############################
#							  #
# 		Preprocessamento	  #
#							  #
###############################

# Pôr início e fim
sed 's/\-\-//' vimosVerVir.final > vimosVerVir.aux
sed 's/ \- / /' vimosVerVir.aux > vimosVerVir2.aux
sed 's/^/\^ /' vimosVerVir2.aux > auxInicio1.aux
sed 's/$/ \$/' auxInicio1.aux > auxFim1.aux

# Trocar maiusculas por minusculas
tr 'A-Z' 'a-z' < auxFim1.aux | tr -sc '[:alpha:]\-\^\$' '\n' > palavraPorPalavra01.aux
grep -v "[^[:alpha:]\^\$]" palavraPorPalavra01.aux > palavraPorPalavra1.aux

# Pôr início e fim
sed 's/\-\-/ /' foraIrSer-1.final > foraIrSer-1.aux
sed 's/ \- //' foraIrSer-1.aux > foraIrSer-12.aux
sed 's/^/\^ /' foraIrSer-12.aux > auxInicio2.aux
sed 's/$/ \$/' auxInicio2.aux > auxFim2.aux

# Trocar maiusculas por minusculas
tr 'A-Z' 'a-z' < auxFim2.aux | tr -sc '[:alpha:]\-\^\$' '\n' > palavraPorPalavra02.aux
grep -v "[^[:alpha:]\^\$]" palavraPorPalavra02.aux > palavraPorPalavra2.aux


###############################
#							  #
# 		Unigramas			  #
#							  #
###############################

# Calcular a frequência de cada unigrama
sort < palavraPorPalavra1.aux | uniq -c | sort -n -r  > countUni.aux

# Remover o caso especial dos hifens
grep -v '[^-]*--.*' countUni.aux > countUni21.aux

# Converter para o formato pedido
awk '{print $2,$1}' countUni21.aux > Unigramas1.txt
#awk -v vocabulary="$vocab" '{print $2,$1+vocabulary}' countUni2.aux > Unigramas.txt

cp Unigramas1.txt palavra1Unigramas.txt

#############################################################################################

# Calcular a frequência de cada unigrama
sort < palavraPorPalavra2.aux | uniq -c | sort -n -r  > countUni.aux

# Remover o caso especial dos hifens
grep -v '[^-]*--.*' countUni.aux > countUni22.aux

# Converter para o formato pedido
awk '{print $2,$1}' countUni22.aux > Unigramas2.txt
#awk -v vocabulary="$vocab" '{print $2,$1+vocabulary}' countUni2.aux > Unigramas.txt

cp Unigramas2.txt palavra2Unigramas.txt

###############################
#							  #
# 		Bigramas			  #
#							  #
###############################

# Calcular a frequência de cada bigrama
awk -- 'prev!="" { print prev,$0; } { prev=$0; }' < palavraPorPalavra1.aux | sort | uniq -c > countBi.aux 

# Remover o caso especial dos hifens
grep -v '[^-]*--.*' countBi.aux > countBi2.aux

# Converter para o formato pedido
awk '{print $2,$3,$1}' countBi2.aux > countBi3.aux

# Remover o caso especial de bigramas entre linhas
grep -v '$ ^' countBi3.aux > countBi4.aux

cp countBi4.aux  Bigramas1.txt

cp Bigramas1.txt palavra1BigramasNaoAlisados.txt

# Adicionar alisamento add-one
awk '{print $1,$2,$3+1}' Bigramas1.txt > Bigramas11.txt
echo 'ver UNKNOWN 1' >> Bigramas11.txt
echo 'UNKNOWN ver 1' >> Bigramas11.txt
echo 'vir UNKNOWN 1' >> Bigramas11.txt
echo 'UNKNOWN vir 1' >> Bigramas11.txt

cp Bigramas11.txt palavra1Bigramas.txt

#############################################################################################

# Calcular a frequência de cada bigrama
awk -- 'prev!="" { print prev,$0; } { prev=$0; }' < palavraPorPalavra2.aux | sort | uniq -c > countBi.aux 

# Remover o caso especial dos hifens
grep -v '[^-]*--.*' countBi.aux > countBi2.aux

# Converter para o formato pedido
awk '{print $2,$3,$1}' countBi2.aux > countBi3.aux

# Remover o caso especial de bigramas entre linhas
grep -v '$ ^' countBi3.aux > countBi4.aux

cp countBi4.aux  Bigramas2.txt

cp Bigramas2.txt palavra2BigramasNaoAlisados.txt

# Adicionar alisamento add-one
awk '{print $1,$2,$3+1}' Bigramas2.txt > Bigramas21.txt
echo 'ir UNKNOWN 1' >> Bigramas21.txt
echo 'UNKNOWN ir 1' >> Bigramas21.txt
echo 'ser UNKNOWN 1' >> Bigramas21.txt
echo 'UNKNOWN ser 1' >> Bigramas21.txt

cp Bigramas21.txt palavra2Bigramas.txt

###############################
#							  #
# 		Limpar Auxiliares	  #
#							  #
###############################

rm *.aux
rm *.final
rm Bigramas1.txt
rm Bigramas2.txt
rm Unigramas1.txt
rm Unigramas2.txt

rm Bigramas11.txt
rm Bigramas21.txt
rm palavra1BigramasNaoAlisados.txt
rm palavra2BigramasNaoAlisados.txt
