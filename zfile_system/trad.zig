const print = @import("std").debug.print ;
const info = @import("princ.zig") ;
const mem = @import("std").mem ;
const file = @import("readFiles.zig");

var gpa = @import("std").heap.GeneralPurposeAllocator(.{}){} ;
const allocator = gpa.allocator();

pub fn tradSeq (seq : []const u8) []u8 {
    const table = info.AAs{} ;  
    const length_of_prot = seq.len/3 ;
    var AAseq = allocator.alloc(u8,length_of_prot) catch |err| {
        print ("Error : {}\n",.{err});
	return &[_]u8{} ;
    } ;
	
    var start : usize = 0 ;
    var end : usize = 3 ;
    var IndexOfAAseq : usize = 0 ;
    while (end <= seq.len) : (end += 3) {
	outer : for (table.AAcodons,0..) |AA,index| {
	            for (AA) |codon| {
		        if (mem.eql(u8,seq[start..end],codon)){
			    AAseq[IndexOfAAseq] = table.AAnames[index] ;
			    IndexOfAAseq += 1 ;
			    break : outer ;
			}
			if (mem.eql(u8,"",codon)) {
			    break ;
			}
		    }
		}		
	    start = end ;
	}
    
    return AAseq ;
}

pub fn freeMemOf(memory : []u8) void {
    defer _ = gpa.deinit() ;
    defer allocator.free(memory) ;
}
