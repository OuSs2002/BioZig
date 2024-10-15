var gpa = @import("std").heap.GeneralPurposeAllocator(.{}){} ;
const allocator = gpa.allocator();
const print = @import("std").debug.print ;
const file = @import("readFiles.zig");

pub fn retSeq (fileContent : []u8) []u8 {
	var count_new_line : usize = 0;
	var index : usize = undefined ;
	for (fileContent,0..) |buffer,i| {
		if (buffer == 10) {
			index = i ;
			break ;
		}
	}
	const seq = fileContent[index..fileContent.len];
	for (seq) |char| {
		if (char == 10){
			count_new_line += 1 ;
		}
	}
	var pure_seq = allocator.alloc(u8,seq.len-count_new_line) catch |err| {
		print ("Error : {}\n",.{err}) ;
		return &[_]u8{} ;
	};
	index = 0 ;
	for (seq) |char| {
		if (char != 10) {
			pure_seq[index] = char ;
			index += 1 ;
		}
	}
	
	return pure_seq ;
}

pub fn freeMemOfSeq (mem : []u8) void {
	defer _ = gpa.deinit() ;
	defer allocator.free(mem) ;
	print ("Done !",.{}) ;
}


test "Seq " {
	const path = "/home/mykali/Desktop/BC/sequence.fasta" ;
	const fileContent = file.readFile(path) ;
	const seq = retSeq(fileContent) ;
	print ("{s}\n",.{seq}) ;
	file.freeAll(fileContent) ;
	freeMemOfSeq(seq);
}
