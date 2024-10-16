const file = @import("readFiles.zig") ;
const read = @import("std").mem.span ;
const print = @import("std").debug.print ;
const trans = @import("trans.zig") ;
const Seq = @import("takeSeqFromFiles.zig");
const count = @import("BaCount.zig");
const Mem = @import("memCont");

const Each = @import("std").meta.fields ;

const PyString : type = [*c]const u8 ;

export fn readFasta(path : PyString) void {
  const new_path = read(path) ;
	const fileContent = file.readFile(new_path) ;
	print ("The Content : {s}\n",.{fileContent}) ;
	file.freeAll(fileContent) ;
}

export fn takeSeq (path : PyString) void {
	const new_path = read(path) ;
	const fileContent = file.readFile(new_path) ;
	const seq = Seq.retSeq(fileContent) ;
	print ("The sequence is : {s}\n",.{seq}) ;
	print ("The length of the seq : {d}\n",.{seq.len}) ;
	Mem.freeMemOf(fileContent) ;
	Mem.freeMemOf(seq) ;
}

export fn rnaMaker(path : PyString) void {
	const new_path = read(path) ;
	const fileContent = file.readFile(new_path) ;
	const seq = Seq.retSeq(fileContent) ;
	const result = trans.transSeq(seq) ;
	print ("The result : \n{s}\n",.{result}) ;
	file.freeAll(fileContent) ;
	Seq.freeMemOfSeq(seq) ;
	trans.freeSeq(result) ;
}

export fn seqCount(filePath : PyString) void {
	const path = read(filePath);
	const fileContent = file.readFile(path);
	const seq = Seq.retSeq(fileContent) ;
	const seqInfo = count.CountSeq(seq) catch |err| switch (err) {
		count.BioError.UnknownAcidBase ,count.BioError.TandUinSameSequence => {
			print ("Error : {}\n",.{err});
			file.freeAll(fileContent);
			Seq.freeMemOfSeq(seq);
			return ;
		},
	};
	inline for (Each(count.counter)) |item| {
		const key = item.name ;
		const types = item.type ;
		const value = @field(seqInfo, key) ;
		if (types == u32 or types == usize) {
			print ("{s} : {d}\n",.{key,value});
		} else {
			print ("{s} : {s}\n",.{key,value});
		}
	}
	file.freeAll(fileContent);
	Seq.freeMemOfSeq(seq);
}

