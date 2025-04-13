// this file is for creating a matrix for the alignment Algos

const allocator = @import("std").heap.page_allocator ;
const print = @import("std").debug.print ;

pub const Matrix = struct {
    map : [][]isize ,
    hor : usize ,
    ver : usize ,
    pub fn init (row : usize , col : usize) Matrix {
  	const table = allocator.alloc([]isize,row) catch |err| {
	    print ("[1] Error : {}\n",.{err}) ;
	    return Matrix{
		.map = &[_][]isize{} ,
		.hor = 0 ,
		.ver = 0 ,
	        };
	    };
	    for (0..row) |index| {
	        table[index] = allocator.alloc(isize,col) catch |err| {
		print ("[2] Error : {}\n",.{err}) ;
		return Matrix{
		    .map = &[_][]isize{} ,
		    .hor = 0 ,
		    .ver = 0 ,
		    };
		};
		@memset(table[index],0) ;
	    }
	    return Matrix{
		.map = table ,
		.hor = row ,
		.ver = col ,
	    };
    }
	
    pub fn printm (self : *Matrix) void {
	for (0..self.hor) |i| {
	    for (0..self.ver) |j| {
		print ("{d} ",.{self.map[i][j]}) ;
	    }
	    print ("\n",.{}) ;
	}
    }

    pub fn deinit(self : *Matrix) void {
	defer allocator.free(self.map) ;
	for (self.map) |line| {
	    defer allocator.free(line) ;
	}
    }
};

