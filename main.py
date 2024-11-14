import sys
import os
import ctype

sys.path.append("files")

from file_system import trans 
from file_system import trad
from file_system import seqInfo
from file_system import readFasta

if os.path.exists(".cache") != True :
	os.system("python FVP.py")

class Excution :
	def __init__(self,Args : list ) :
		
		DefaultArgs : list[str] = ["-h" , "-p", "-s","" ,"-f" ,"-short" ,""]

		for index in range(len(Args)) :
			DefaultArgs[index] = Args[index]

		self.job = DefaultArgs[0]
		self.lang = DefaultArgs[1]
		self.where = DefaultArgs[2]
		self.path = DefaultArgs[3]
		self.direction = DefaultArgs[4]
		self.outputType = DefaultArgs[5] 
		self.file = DefaultArgs[6]
	
	def takeSeq (self) -> [str,None] :
		if self.where == "-s" :
			seq = self.path.upper()
		if self.where == "-f" and self.lang == "-p" :
			seq = readFasta.readFasta(self.path).upper()
		
		return seq

	def checkSeq (seq : str) :
		ExistsNec : str = "AGCTU"
		if "T" in seq and "U" in seq :
			print ("[!] The sequnce must not have T and U in same time\n[!] Verfy your sequence")
			exit()
		for nec in seq :
			if nec not in ExistsNec :
				print (f"[!] The {nec} is not a neclutide !\n[!] Verfiy your sequence !")
				exit()

	def exitClass () -> None :
		print ("""
This is the finilly programme to me for DNA traitment
    python main.py -h to see the help options
    python main.py -Td -(s/f) data -(b/f) -(full/short) to do traduction
    python main.py -Tn -(s/f) data -(b/f) to do transcription 
    python main.py -info -(s/f) data (-b)

    The last -(b/f) is for backward or forward
    The -(s/f) sequence or fasta file
	"""
		)
		exit()
		
	def run (self) :
		assert self.job in ["-h" ,"-info" , "-Tn" , "-Td" ,"-NW"] , Excution.exitClass()
		assert self.where in ["-s" , "-f"] , Excution.exitClass()
		assert self.direction in ["-f" , "-b"] , Excution.exitClass() 
		assert self.outputType in ["-full", "-short", ""] , Excution.exitClass()
		assert self.lang in ["-p" , "-z"] ,Excution.exitClass()

		if self.job == "-h" :
			Excution.exitClass()
		
		if self.lang == "-p" :
			seq : str = Excution.takeSeq(self)
			Excution.checkSeq(seq)
			info : dict = seqInfo.seqinfo(seq)
		
			if self.job == "-info" :
				seqInfo.pdict(info)

			elif self.job == "-Tn" :
				if info["Type"] == "RNA" :
					print ("[!] You can't do a transcitpion to an RNA sequnce")
					exit()
				else :
					if self.direction == "-f" :
						result : str = trans.transForward(seq)
				
					else :
						result : str = trans.transBackward(seq)
					
					print ("[*] The result is : ",result)
		
			elif self.job == "-Td" :
				results : dict = trad.tradSeq(seq,info["Type"])
				if self.outputType == "-full" :
					print (results["fullname"])
				elif self.outputType == "-short" :
					print (results["shortname"])
				else :
					seqInfo.pdict(results)
		
		elif self.lang == "-z" :
			zigTools = ctype.CDLL("./zfile_system/libConPoint.so")	

			if self.job == "-info" :
				zigTools.seqCount(self.path.encode("utf-8"))

			elif self.job == "-Tn" :
				zigTools.rnaMaker(self.path.encode("utf-8"))

			elif self.job == "-Td" :
				zigTools.seqTrad(self.path.encode("utf-8"))

			elif self.job == "-NW" :
				m : int = int(input("[*] put the match : "))
				mm : int = int(input("[*] put the match : "))
				gap : int = int(input("[*] put the match : "))
				path_1 : str = input("[*] Put the path to the fasta file 1 : ")
				path_2 : str = input("[*] Put the path to the fasta file 1 : ")
				zigTools.globalAlignment(path_1.encode("utf-8"),path_2.encode("utf-8"),m,mm,gap) 

commend = Excution(sys.argv[1:len(sys.argv)])
commend.run()
