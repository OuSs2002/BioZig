import ctype 

path : str = "/home/mykali/Desktop/BC/sequence.fasta"

ziglib = ctype.CDLL("./libexcution.so")

try :
	print ("Tesk for trasciption :")
	ziglib.transcription(path.encode("utf-8"))
	print ("Tesk 3 pass")
except :
	print ("Error in test 3")
