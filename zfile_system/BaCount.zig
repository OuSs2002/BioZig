const info = @import("princ.zig") ;

const counter = struct {
	A : u32 = 0 ,
	C : u32 = 0 ,
	G : u32 = 0 ,
	T : u32 = 0 ,
	U : u32 = 0 ,
	unkown : u32 = 0 ,
};

pub fn CountSeq (seq : []u8) counter {
	var seqBAcount = counter{};
	const dna = info.dnaBa{};
	for (seq) |char| {
		_ = switch (char) {
			dna.A => seqBAcount.A += 1,
			dna.C => seqBAcount.C += 1,
			dna.G => seqBAcount.G += 1,
			dna.T => seqBAcount.T += 1,
			dna.U => seqBAcount.U += 1,
			else => seqBAcount.unkown += 1,
		};
	}
	return seqBAcount ;
}
