const info = @import("princ.zig") ;
const print = @import("std").debug.print ;

var gpa = @import("std").heap.GeneralPurposeAllocator(.{}){} ;
const allocator = gpa.allocator() ;

pub fn transSeq (seq : []u8) []u8 {
	const dna = info.dnaBa{} ;
	var rna = allocator.alloc(u8,seq.len) catch |err| {
		print ("Error : {}\n",.{err}) ;
		return &[_]u8{} ;
	};
	for (seq,0..)|char,index| {
		rna[index] = switch(char){
			dna.A => dna.U,
			dna.T => dna.A,
			dna.C => dna.G,
			dna.G => dna.C,
			0 => 0,
			else => dna.X ,
		};
	}
	return rna ;
}

pub fn freeMemOf(memory : []u8) void {
	defer _ = gpa.deinit() ;
	defer allocator.free(memory);
}
