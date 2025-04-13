const std = @import("std") ;

var gpa = std.heap.GeneralPurposeAllocator(.{}){} ;
const allocator = gpa.allocator() ;

const string : type = []const u8 ;

const fileInfo = struct {
    file_code : string ,
    regan : string ,
    genus : string ,
    species : string ,
    chromosome_num : u8 ,
    seq : []u8 = "" ,
    pub fn init (a : string , b : string ,c : string , d : string , e : u8 ,f : []u8,) fileInfo {
	return fileInfo {
 	    .file_code = a ,
 	    .regan = b ,
 	    .genus = c ,
 	    .species = d ,
 	    .chromosome_num = e ,
 	    .seq = f ,
	};
    }
	
    pub fn display(self : fileInfo) void {
        std.debug.print("file_code : {s}\n",.{self.file_code});
	std.debug.print("regan : {s}\n",.{self.regan});
	std.debug.print("genus : {s}\n",.{self.genus});
	std.debug.print("species : {s}\n",.{self.species});
	std.debug.print("chromosome_number : {c}\n",.{self.chromosome_num});
    }
	
    pub fn deinit(self :fileInfo) void {
	defer allocator.free(self.seq) ;
    }
};

fn find (some : []u8 , thing : u8 ) u8 {	
    var index : u8 = 0 ;
    for (some) |char| {
	if (char == thing) {
	    break ;
	} else {
	    index += 1 ;
	}
    }
    return index ;
}


pub fn readFile (path : string ) []u8 {
    const file = std.fs.cwd().openFile(path,.{}) catch |err| {
        std.debug.print("Error : {}",.{err}) ;
        return &[_]u8{};
    };
    defer file.close() ;

    const fileContent = file.readToEndAlloc(allocator ,std.math.maxInt(usize)) catch |err| {
        std.debug.print("Error : {}",.{err}) ;
        return &[_]u8{} ;
    };

    return fileContent ;
}

pub fn readFasta(fileContent : []u8 ) fileInfo {
    const header = fileContent[1..find(fileContent,44)] ;
    const seq = fileContent[find(fileContent,10)+1..fileContent.len] ;
    var count_new_line : usize = 0 ;
    for (seq) |char| {
  	if (char == 10){
    	    count_new_line += 1 ;
        }
    }
    var pure_seq = allocator.alloc(u8,seq.len-count_new_line) catch |err| {
  	std.debug.print ("Error : {}",.{err});
        return fileInfo.init("","","","",0,&[_]u8{}) ;
    };
    var index : usize = 0 ;
    for (seq) |char| {
  	if (char != 10) {
    	    pure_seq[index] = char ;
            index += 1 ;
        }
    }

    var rest : [5][]const u8 = undefined ;
    var str = std.mem.split(u8,header," ") ;
    index = 0 ;
    while (str.next()) |chunk| {
	rest[index] = chunk ;
	index += 1 ;
    }
    return fileInfo.init(
	header[0..find(header,58)] ,
	header[find(header,58)+1..find(header,32)] ,
	rest[1],
	rest[2],
	header[header.len-1] ,
	pure_seq,
    );

}

pub fn freeMemOf(memory : []u8) void {
    defer _ = gpa.deinit();
    defer allocator.free(memory) ;
}
