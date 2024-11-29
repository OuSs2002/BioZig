import os 
import sys
from Libs import Bio_libs , takeSeqFromFile , pdict 

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
    if self.where == "-f" :
      seq = takeSeqFromFile(self.path)
		
    return seq

  def exitClass () -> None :
    print ("""
This is a programme for DNA traitment :
    python main.py -h to see the help options
    python main.py -Td -(p/z) lang -(s/f) data to do traduction
    python main.py -Tn -(p/z) lang -(s/f) data to do transcription 
    python main.py -info -(p/z) lang -(s/f) data 

    
    The -(s/f) sequence or fasta file
    The -(z/p) ziglang or python
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
		
    seq : str = Excution.takeSeq(self)
		
    if self.job == "-info" :
      info : dict = Bio_libs.seq_info(seq,self.lang)
      pdict(info)

    elif self.job == "-Tn" :
      result : str = Bio_libs.transcription(seq,self.lang,self.direction)
      print ("[*] The result is : ",result)
		
    elif self.job == "-Td" :
      result : str = Bio_libs.traduction(seq,self.lang)
      if self.lang == "-p" :
        pdict(result)
      else :
        print (result)

    elif self.job == "-NW" :
      m : int = int(input("[*] put the match : "))
      mm : int = int(input("[*] put the match : "))
      gap : int = int(input("[*] put the match : "))
      path_1 : str = input("[*] Put the path to the fasta file 1 : ")
      path_2 : str = input("[*] Put the path to the fasta file 1 : ")
      zigTools.globalAlignment(path_1.encode("utf-8"),path_2.encode("utf-8"),m,mm,gap) 

commend = Excution(sys.argv[1:len(sys.argv)])
commend.run()
