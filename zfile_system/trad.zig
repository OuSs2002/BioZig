const print = @import("std").debug.print ;
const info = @import("princ.zig") ;

const codons = struct {
	name : []const u8 ,
	length : u3 ,
	list : anytype ,
	pub fn init (a : []const u8 , b : u3 ,c : anytype) codons {
		return .{
			.name = a ,
			.length = b,
			.list = c ,
		};
	}
};

test "Dynamic Array" {
	var gpa = @import("std").heap.GeneralPurposeAllocator(.{}){};
	const allocator = gpa.allocator() ;
	defer _ = gpa.deinit() ;

	var foo = try allocator.alloc([]const u8 ,6) ;
	foo[0] = "AUG" ;
	const cdMet = codons.init(@TypeOf(foo),"Met",1,foo[0]) ; 
	print ("{any} \n",.{cdMet}) ;
	defer allocator.free(foo) ; 
}

pub fn tradSeq (seq : []u8) []u8 {
	
} 
