sh preprocess.sh
sh ngrams.sh

python3 chooseLemma.py 'palavra1Unigramas.txt' 'palavra1Bigramas.txt' 'vimosParametrizacao.txt' 'palavra1Frases.txt'

python3 chooseLemma.py 'palavra2Unigramas.txt' 'palavra2Bigramas.txt' 'foraParametrizacao.txt' 'palavra2Frases.txt'
