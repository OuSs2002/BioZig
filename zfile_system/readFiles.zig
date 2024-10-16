const std = @import("std") ;

var gpa = std.heap.GeneralPurposeAllocator(.{}){} ;
const allocator = gpa.allocator() ;

pub fn readFile (path : []const u8) []u8 {
  const file = std.fs.cwd().openFile(path,.{}) catch |err| {
    std.debug.print("Error : {}",.{err}) ;
    return &[_]u8{} ;
  };
  defer file.close() ;
  const fileContent = file.readToEndAlloc(allocator ,std.math.maxInt(usize)) catch |err| {
    std.debug.print("Error : {}",.{err}) ;
    return &[_]u8{} ;
  };
  
  return fileContent ;
}

pub fn freeMemOf(memory : []u8) void {
	defer _ = gpa.deinit() ;
	defer allocator.free(memory) ;
}
