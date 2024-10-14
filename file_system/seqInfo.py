def seqinfo (seq : str) -> dict :
	sequence_info = {
		"A" : 0 ,"T" : 0 ,
		"C" : 0 ,"G" : 0 ,
		"U" : 0 ,
		"Type" : "Unkown" ,
		"Length" : 0 ,
		"%GC" : 0.0 ,
		"Tm" : 0 ,
	}
	sequence_info["A"] = seq.count("A")
	sequence_info["C"] = seq.count("C")
	sequence_info["G"] = seq.count("G")
	sequence_info["Length"] = len(seq)
	for i in seq :
		if i == "T" :
			sequence_info["T"] = seq.count("T")
			sequence_info["Type"] = "DNA"
		elif i == "U" :
			sequence_info["U"] = seq.count("U")
			sequence_info["Type"] = "RNA"
	
	sequence_info["%GC"] = (sequence_info["G"] + sequence_info["C"] ) / sequence_info["Length"]
	
	if sequence_info["Length"] < 14 :
		sequence_info["Tm"] = (sequence_info["A"] + sequence_info["T"]) * 2 + (sequence_info["C"] + sequence_info["G"]) * 2
	else :
		sequence_info["Tm"] = 64.9+41*((sequence_info["C"]+sequence_info["G"]-16.4)/(sequence_info["Length"]))
	
	return sequence_info

def pdict (d : dict) -> None :
	for key , value in d.items() :
		print (f"{key} = {value}")
