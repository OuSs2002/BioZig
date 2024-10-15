def readFasta(path : str) -> str :
	seq : str = ""
	with open (path ,mode="r") as file :
		for line in file :
			if line[0] != ">" or len(line) != 0 :
				line = line.strip()
				seq += line
	return seq 

