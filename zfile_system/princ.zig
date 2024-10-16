pub const dnaBa = struct {
  A : u8 = 65,C : u8 = 67,
  G : u8 = 71,T : u8 = 84,
  U : u8 = 85,X : u8 = 88,
};

pub const AAs = struct { 
	AAnames : [21]u8 = .{
		77, 87, 82, 70, 
		73, 76, 86, 83, 
		67, 81, 72, 80, 
		65, 71, 66, 69, 
		89, 32, 32, 78, 
		75,
	},
	AAcodons : [21][6][:0]const u8 = .{
		.{"ATG","","","","",""},
		.{"TGG","","","","",""},
		.{"CGT","CGC","CGA","CGG","AGA","AGG"},
		.{"TTT","TTC","","","",""},
		.{"ATT","ATC","AUA","","",""},
		.{"TTA","TUG","CTT","CUC","CUA","CUG"},
		.{"GTT","GTC","GUA","GUG","",""},
		.{"TCT","TCC","UCA","UCG","",""},
		.{"TGT","TGC","","","",""},
		.{"CAA","CAG","","","",""},
		.{"CAT","CAC","","","",""},
		.{"CCT","CCC","CCA","CCG","",""},
		.{"GCT","GCC","GCA","GCG","",""},
		.{"GGT","GGC","GGA","GGG","",""},
		.{"GAT","GAC","","","",""},
		.{"GAA","GAG","","","",""},
		.{"TAT","TAC","","","",""},
		.{"TAA","TAG","TGA","","",""},
		.{"ACT","ACC","ACA","ACG","",""},
		.{"AAT","AAC","","","",""},
		.{"AAA","AAG","","","",""},
	}
};
