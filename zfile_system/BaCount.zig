const info = @import("princ.zig") ;

pub const BioError = error {
	TandUinSameSequence ,
	UnknownAcidBase ,
};

pub const counter = struct {
	A : u32 = 0 ,
	C : u32 = 0 ,
	G : u32 = 0 ,
	T : u32 = 0 ,
	U : u32 = 0 ,
	unknown : u32 = 0 ,
	Length : usize = 0 ,
	Type : []const u8 = "NONE",
	GCp : f32 = 0.0 ,
};

pub fn CountSeq (seq : []u8) BioError!counter {
	var seqBAinfo = counter{};
	const dna = info.dnaBa{};
	seqBAinfo.Length = seq.len ;
	for (seq) |char| {
		_ = switch (char) {
			dna.A => seqBAinfo.A += 1,
			dna.C => seqBAinfo.C += 1,
			dna.G => seqBAinfo.G += 1,
			dna.T => seqBAinfo.T += 1,
			dna.U => seqBAinfo.U += 1,
			else => seqBAinfo.unknown += 1,
		};
	}
	if (seqBAinfo.unknown != 0) {
		return BioError.UnknownAcidBase ;
	}
	if (seqBAinfo.T > 0 and seqBAinfo.U > 0) {
		return BioError.TandUinSameSequence ;
	}
	seqBAinfo.GCp = @as(f32,@floatFromInt(seqBAinfo.C + seqBAinfo.G)) / @as(f32,@floatFromInt(seqBAinfo.Length)) ;
	seqBAinfo.Type = if(seqBAinfo.T > 0) "DNA" else "RNA" ;
	return seqBAinfo ;
}
