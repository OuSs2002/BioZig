# this projet is the finilly try for transcription project 

def transForward (seq : str) -> str :
	resultSeq : str = ""
	for i in seq :
		if i == "A" :
			resultSeq += "U"
		elif i == "T" :
			resultSeq += "A"
		elif i == "C" :
			resultSeq += "G"
		elif i == "G" :
			resultSeq += "C"

	return resultSeq 

def transBackward (seq : str) -> str :
	resultSeq : str = ""
	for i in seq :
		if i == "T" :
			resultSeq += "U"
		else :
			resultSeq += i

	return resultSeq
