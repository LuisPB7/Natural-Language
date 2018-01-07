import sys
import unicodedata 
import math
import string
import re

unigramas = sys.argv[1]
bigramas = sys.argv[2]
param = sys.argv[3]
frases = sys.argv[4]

# Initialize two dictionaries from the unigram and bigram text files #
def createDictFromNGrams(uniFile, biFile):
	unigrams = {}
	bigrams = {}
	for line in uniFile:
		unigrams[line.split()[0]] = int(line.split()[1])
	for line in biFile:
		bigrams[(line.split()[0],line.split()[1])] = int(line.split()[2])
	return unigrams, bigrams

# Introduces the beggining of line and end of line symbols, 
# and replaces the verb with a given lemma for posterior calculations 
def transformSentence(sentence, verb, lemma):
	newSentence = ''
	words = sentence.split()
	for i in range(len(words)):
		if words[i] == verb:
			newSentence += lemma+' '
			continue
		newSentence += words[i]+' '
	newSentence = re.sub('['+string.punctuation+']', ' ', newSentence).replace('  ', ' ') # Remove punctuation
	newSentence = ''.join(c for c in unicodedata.normalize('NFD', newSentence) if unicodedata.category(c) != 'Mn') # Remove accents
	newSentence = '^ ' + newSentence + ' $'
	return newSentence

# Creates a list of bigrams from a list of words
def createBigrams(sentence, lemma, bigramsDict):
	bigrams = []
	for i in range(0, len(sentence)):
		try:
			if sentence[i] == lemma or sentence[i+1] == lemma:
				bigrams += [(sentence[i], sentence[i+1])]
		except:
			continue
	return bigrams

# Calculates the probability of a given sentence, using Add-One Smoothing # 
def calculateProbability(sentence, unigramsDict, bigramsDict, lemma):
	slidingWindow = createBigrams(sentence.split(), lemma, bigramsDict) 
	probability = 1
	V = len(unigramsDict.keys())
	for pair in slidingWindow:
		try: numerator = bigramsDict[pair]
		except: numerator = 1 # (UNKNOWN, lemma) or (lemma, UNKNOWN)
		try: denominator = unigramsDict[pair[0]] + V
		except: denominator = 1 + V # when the unigram is not in V
		probability = probability * numerator/denominator
	return probability
	
# Processes a sentence from the test file #
def processSentence(sentence, paramFile, unigrams, bigrams):
	param = open(paramFile, 'r')
	lemmas = []
	lemmaProbabilities = {}
	for i, line in enumerate(param):
		l = line.strip()
		if i==0:
			verb = l #First line
		if i==1: # middle line
			lemmas += l.split()[:len(l.split())-1]
	param.close()
	for lemma in lemmas:
		transformedSentence = transformSentence(sentence, verb, lemma)
		sentenceProbability = calculateProbability(transformedSentence, unigrams, bigrams, lemma)
		lemmaProbabilities[lemma] = sentenceProbability
	return lemmaProbabilities
		
# Reads each sentence in the test file, and in the end writes results to file #		
def desambiguate(testFile, paramFile, unigrams, bigrams, word):
	f = open(word + "Resultado.txt", 'w')
	for sentence in testFile:
		probs = processSentence(sentence.strip().lower(), paramFile, unigrams, bigrams)
		f.write("SENTENCE: %s\n" %(sentence.strip()))
		for lemma in probs:
			f.write("Lema %s with probability %s\n" %(lemma, str(probs[lemma])))
		f.write("Most likely lemma: %s\n" %(max(probs, key=probs.get)))
		f.write("\n")
	f.close()
		
# Main processing function #
def chooseLemma(unigramFile, bigramFile, paramFile, testFile):
	uni = open(unigramFile, 'r')
	bi = open(bigramFile, 'r')
	test = open(testFile, 'r')
	unigrams, bigrams = createDictFromNGrams(uni, bi)
	desambiguate(test, paramFile, unigrams, bigrams, testFile[:len(testFile) - 10])
	uni.close()
	bi.close()
	test.close()
		
### Main ###
chooseLemma(unigramas, bigramas, param, frases)
