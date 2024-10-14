pub const dnaBa = struct {
  A : u8 = 65,C : u8 = 67,
  G : u8 = 71,T : u8 = 84,
  U : u8 = 85,X : u8 = 88,
};

//AAnames : [20][:0]const u8 = .{
//			"Met","Trp","Arg","Phe",
//			"Ile","Leu","Val","Ser","Cys",
//
//			"Gln","His","Pro","Ala",
//			"Gly","Asp","Glu","Trp",
//			"   ","Thr","Asn","Lys"
//		},

pub const AAs = struct { 
	AAnames : []u8 = .{
		77, 87, 82, 70, 
		73, 76, 86, 83, 
		67, 81, 72, 80, 
		65, 71, 66, 69, 
		89, 32, 32, 78, 
		75,
	},
	AAcodons : [21][6][:0]const u8 = .{
		.{"AUG","","","","",""},
		.{"UGG","","","","",""},
		.{"CGU","CGC","CGA","CGG","AGA","AGG"},
		.{"UUU","UUC","","","",""},
		.{"AUU","AUC","AUA","","",""},
		.{"UUA","UUG","CUU","CUC","CUA","CUG"},
		.{"GUU","GUC","GUA","GUG","",""},
		.{"UCU","UCC","UCA","UCG","",""},
		.{"UGU","UGC","","","",""},
		.{"CAA","CAG","","","",""},
		.{"CAU","CAC","","","",""},
		.{"CCU","CCC","CCA","CCG","",""},
		.{"GCU","GCC","GCA","GCG","",""},
		.{"GGU","GGC","GGA","GGG","",""},
		.{"GAU","GAC","","","",""},
		.{"GAA","GAG","","","",""},
		.{"UAU","UAC","","","",""},
		.{"UAA","UAG","UGA","","",""},
		.{"ACU","ACC","ACA","ACG","",""},
		.{"AAU","AAC","","","",""},
		.{"AAA","AAG","","","",""},
	}
};
