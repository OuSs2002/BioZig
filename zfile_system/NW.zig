const print = @import("std").debug.print ;

const mat = @import("matrix.zig") ;
const TA = @import("ToolsForAlign.zig") ; // short of ToolOfAlign

const string : type = []u8 ;

pub fn NW (list : []string , match : u8 , mmatch : u8 , gap : u8) mat.Matrix {
    const seq_1 = list[1] ;
    const seq_2 = list[0] ;
    const seq1 = seq_1 ;
    const seq2 = seq_2 ;
    const new_gap = @abs(gap) ;
    var nwVec = mat.Matrix.init(seq1.len+1,seq2.len+1) ;
    for (1..nwVec.ver) |index| {
        nwVec.map[0][index] = nwVec.map[0][index-1] - new_gap ;
    }
    for (1..nwVec.hor) |index| {
  	nwVec.map[index][0] = nwVec.map[index-1][0] - new_gap ;
    }
    for (1..nwVec.hor) |i| {
	for (1..nwVec.ver) |j| {
	    var x : isize = 0 ; var y : isize = 0 ; var z : isize = 0 ;
	    const score : u8 = if (seq1[i-1] == seq2[j-1]) match else mmatch ;
	    x = nwVec.map[i][j-1] - new_gap ;
	    y = nwVec.map[i-1][j-1] + score ;
	    z = nwVec.map[i-1][j] - new_gap ;
	    nwVec.map[i][j] = TA.biger(x,y,z) ;
	}
    }
	
    return nwVec ;
}
