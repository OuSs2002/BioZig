const info = @import("princ.zig") ;

pub const counter = extern struct {
	A : u32 = 0 ,
	C : u32 = 0 ,
	G : u32 = 0 ,
	T : u32 = 0 ,
	U : u32 = 0 ,
	Length : usize = 0 ,
	Type : [*c]const u8 = "NONE",
	GCp : f32 = 0.0 ,
};

pub fn CountSeq (seq : []const u8) counter {
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
      else => continue ,
		};
	}
	seqBAinfo.GCp = @as(f32,@floatFromInt(seqBAinfo.C + seqBAinfo.G)) / @as(f32,@floatFromInt(seqBAinfo.Length)) ;
	seqBAinfo.Type = if(seqBAinfo.T > 0) "DNA" else "RNA" ;
	return seqBAinfo ;
}
