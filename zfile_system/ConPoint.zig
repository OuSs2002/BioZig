// file of zig 
const read = @import("std").mem.span ;
const Each = @import("std").meta.fields ;
const print = @import("std").debug.print ;

// file from zigFiles to run the programme
const trans = @import("trans.zig") ;
const count = @import("BaCount.zig");
const file = @import("readFiles.zig") ;
const trad = @import("trad.zig") ;
const alignm = @import("NW.zig") ;
const TA = @import("ToolsForAlign.zig") ;

const PyString : type = [*c]const u8 ;

export fn readFasta(path : PyString) void {
  const new_path = read(path) ;
	const fileContent = file.readFile(new_path) ;
	print ("The Content : {s}\n",.{fileContent}) ;
	file.freeMemOf(fileContent) ;
}

export fn fasta_file_info (path : PyString) void {
	const new_path = read(path) ;
	const fileContent = file.readFile(new_path) ;
	const fastaInfo = file.readFasta(fileContent) ;
	fastaInfo.display() ;
	fastaInfo.deinit() ;
	file.freeMemOf(fileContent) ;
}

export fn rnaMaker(path : PyString) void {
	const new_path = read(path) ;
	const fileContent = file.readFile(new_path) ;
	const fastaInfo = file.readFasta(fileContent) ;
	const result = trans.transSeq(fastaInfo.seq) ;
	print ("The result : \n{s}\n",.{result}) ;
	fastaInfo.deinit() ;
	trans.freeMemOf(result) ;
	file.freeMemOf(fileContent) ;
}

export fn seqCount(path : PyString) void {
	const new_path = read(path);
	const fileContent = file.readFile(new_path);
	const fastaInfo = file.readFasta(fileContent) ;
	const seqInfo = count.CountSeq(fastaInfo.seq) catch |err| switch (err) {
		count.BioError.UnknownAcidBase ,count.BioError.TandUinSameSequence => {
			print ("Error : {}\n",.{err});
			fastaInfo.deinit() ;
			file.freeMemOf(fileContent);
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
	fastaInfo.deinit() ;
	file.freeMemOf(fileContent);
}

export fn globalAlignment(path_1 : PyString ,
													path_2 : PyString , 
													match : u8 , 
													mmatch : u8 ,
													gap : u8 ,
	) void {
	const path1 = read(path_1) ;
	const path2 = read(path_2) ;
	const fileContent1 = file.readFile(path1) ;
	const fileContent2 = file.readFile(path2) ;
	const fasta1 = file.readFasta(fileContent1) ;
	const fasta2 = file.readFasta(fileContent2) ;
	const seqs = TA.howLonger(fasta1.seq , fasta2.seq) ;
	var result = alignm.NW(seqs ,match ,mmatch ,gap) ;
	result.printm() ;
	print ("The socre of alignment is : {d}\n",.{result.map[fasta1.seq.len][fasta2.seq.len) ;
}

export fn seqTrad(path : PyString) void {
	const new_path = read(path) ;
	const fileContent = file.readFile(new_path) ;
	const fasta = file.readFasta(fileContent) ;
	const result = trad.tradSeq(fasta.seq) ;
	print ("The result : {s}\n",.{result}) ;
	fasta.deinit() ;
	trad.freeMemOf(result);
	file.freeMemOf(fileContent) ;
}
