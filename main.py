import sys
import os
import ctype

sys.path.append("files")

from file_system import trans 
from file_system import trad
from file_system import seqInfo

ziglib = ctype.CDLL("./cfile_system/libtrans.so")

if os.path.exists(".cache") != True :
	os.system("python FVP.py")

class Excution :
	def __init__(self,Args : list ) :
		
		DefaultArgs : list[str] = ["-h" ,"-s" ,"" ,"-f" ,"-short" ,""]

		for index in range(len(Args)) :
			DefaultArgs[index] = Args[index]

		self.job = DefaultArgs[0]  
		self.where = DefaultArgs[1]
		self.path = DefaultArgs[2]
		self.direction = DefaultArgs[3]
		self.outputType = DefaultArgs[4] 
		self.file = DefaultArgs[5]
	
	def takeSeq (self) -> [str,None] :
		seq : str = ""
		if self.where == "-s" :
			seq = self.path.upper()
		elif self.where == "-f" :
			with open(self.path,mode="r") as file :
				for line in file :
					if line[0] != ">" and len(line) != 0 :
						seq += line.strip().upper()
						
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
		assert self.job in ["-h" ,"-info" , "-Tn" , "-Td" ] , Excution.exitClass()
		assert self.where in ["-s" , "-f"] , Excution.exitClass()
		assert self.direction in ["-f" , "-b"] , Excution.exitClass() 
		assert self.outputType in ["-full", "-short", ""] , Excution.exitClass()
		
		if self.job == "-h" :
			Excution.exitClass()

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
					ziglib.display(seq.encode("utf-8"))
					#result : str = trans.transForward(seq)
				
				else :
					result : str = trans.transBackward(seq)
				#print ("[*] The result is : ",result)
		
		elif self.job == "-Td" :
				results : dict = trad.tradSeq(seq,info["Type"])
				if self.outputType == "-full" :
					print (results["fullname"])
				elif self.outputType == "-short" :
					print (results["shortname"])
				else :
					seqInfo.pdict(results)


commend = Excution(sys.argv[1:len(sys.argv)])
commend.run()
