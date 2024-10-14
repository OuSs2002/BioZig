class AA :
	def __init__ (self
	,name : str 
	,short_name : chr 
	,RNAseq : list[str]
	,DNAseq : list[str]
	) :
		self.name = name
		self.short_name = short_name
		self.RNAseq = RNAseq
		self.DNAseq = DNAseq

p0 =  AA("Thr",'T',['ACA','ACG','ACC','ACU'],['ACA','ACG','ACC','ACT'])
p1 =  AA("Leu",'L',['CUU','CUC','CUA','CUG','UUA','UUG'],['CTT','CTC','CTA','CTG','TTA','TTG'])
p2 =  AA("Pro",'P',['CCU','CCA','CCG','CCC'],['CCT','CCA','CCG','CCC'])
p3 =  AA("Phe",'F',['UUU','UUC'],['TTT','TTC'])
p4 =  AA("Ile",'I',['AUU','AUC','AUA'],['ATT','ATC','ATA'])
p5 =  AA("Met",'M',['AUG'],['ATG'])
p6 =  AA("Val",'V',['GUG','GUA','GUC','GUU'],['GTG','GTA','GTC','GTT'])
p7 =  AA("Ser",'S',['AGU','AGC','UCU','UCA','UCG','UCC'],['AGT','AGC','TCT','TCA','TCG','TCC'])
p8 =  AA("Ala",'A',['GCU','GCA','GCC','GCG'],['GCT','GCA','GCC','GCG'])
p9 =  AA("Tyr",'Y',['UAU','UAC'],['TAT','TAC'])
p10 = AA("His",'H',['CAU','CAC'],['CAT','CAC'])
p11 = AA("Gln",'E',['CAA','CAG'],['CAA','CAG'])
p12 = AA("Asn",'N',['AAU','AAC'],['AAT','AAC'])
p13 = AA("Lys",'K',['AAA','AAC'],['AAA','AAC'])
p14 = AA("Glu",'Q',['GAA','GAG'],['GAA','GAG'])
p15 = AA("Cys",'C',['UGU','UGC'],['TGT','TGC'])
p16 = AA("Trp",'W',['UGG'],['TGG'])
p17 = AA("Arg",'R',['CGU','CGC','CGA','CGG','AGA','AGG'],['CGT','CGC','CGA','CGG','AGA','AGG'])
p18 = AA("Gly",'G',['GGU','GGC','GGA','GGG'],['GGT','GGC','GGA','GGG'])
p19 = AA("   ",' ',['UAA','UGA','UAG'],['TAA','TGA','TAG'])

list_prot = [
	p0,p1,p2,p3,p4,p5,p6,p7,p8,p9,p10
	,p11,p12,p13,p14,p16,p17,p18,p19
]

def tradSeq (seq : str , typeSeq : str) -> dict[str] :
	results : dict = {
		"fullname" : "" ,
		"shortname" : "" ,
	}
	for i in range (0,len(seq),3) :
		for p in list_prot :
			if typeSeq == "DNA" :
				codons : list[str] = p.DNAseq
			else :
				codons : list[str] = p.RNAseq
			if seq[i:i+3] in codons :
				results["fullname"] += p.name
				results["shortname"] += p.short_name
				break

	return results 
