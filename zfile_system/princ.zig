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
		65, 71, 68, 69, 
		89, 32, 84, 78, 
		75,
	},
	AAcodons : [21][6][:0]const u8 = .{
		.{"ATG","","","","",""},
		.{"TGG","","","","",""},
		.{"CGT","CGC","CGA","CGG","AGA","AGG"},
		.{"TTT","TTC","","","",""},
		.{"ATT","ATC","ATA","","",""},
		.{"TTA","TTG","CTT","CTC","CTA","CTG"},
		.{"GTT","GTC","GTA","GTG","",""},
		.{"TCT","TCC","TCA","TCG","AGT","AGC"},
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
