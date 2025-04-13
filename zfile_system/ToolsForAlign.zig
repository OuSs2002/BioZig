// this file contain a function that NW and SW need

const string : type = []u8 ;

pub fn howLonger ( a : string , b : string) []string {
    var order : [2]string = undefined ;
    if (a.len >= b.len) {
  	order[0] = a ;
        order[1] = b ;
    } else {
        order[0] = b ;
        order[1] = a ;
    }

    return &order ;
}

pub fn biger (x : isize , y : isize ,z : isize) isize {
    const list : [3]isize = .{x,y,z} ;
    const result = @import("std").mem.max(isize,&list) ;
    return result ;
}

