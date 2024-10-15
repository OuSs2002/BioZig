const file = @import("readFiles.zig") ;
const read = @import("std").mem.span ;
const print = @import("std").debug.print ;
const trans = @import("trans.zig") ;
const Seq = @import("takeSeqFromFiles.zig");
const count = @import("BaCount.zig");

export fn readFasta(path : [*c]const u8) void {
  const new_path = read(path) ;
	const fileContent = file.readFile(new_path) ;
	print ("The Content : {s}\n",.{fileContent}) ;
	file.freeAll(fileContent) ;
}

export fn takeSeq (path : [*c]const u8) void {
	const new_path = read(path) ;
	const fileContent = file.readFile(new_path) ;
	const seq = Seq.retSeq(fileContent) ;
	print ("The sequence is : {s}\n",.{seq}) ;
	print ("The length of the seq : {d}\n",.{seq.len}) ;
	file.freeAll(fileContent) ;
	Seq.freeMemOfSeq(seq) ;
}

export fn rnaMaker(path : [*c]const u8) void {
	const new_path = read(path) ;
	const fileContent = file.readFile(new_path) ;
	const seq = Seq.retSeq(fileContent) ;
	const result = trans.transSeq(seq) ;
	print ("The result : \n{s}\n",.{result}) ;
	file.freeAll(fileContent) ;
	Seq.freeMemOfSeq(seq) ;
	trans.freeSeq(result) ;
}

export fn seqCount(filePath : [*c]const u8) void {
	const path = read(filePath);
	const fileContent = file.readFile(path);
	const seq = Seq.retSeq(fileContent) ;
	const seqInfo = count.CountSeq(seq) ;
	print ("the result is : {any}\n",.{seqInfo}) ;
	file.freeAll(fileContent);
	Seq.freeMemOfSeq(seq);
}

