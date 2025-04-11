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
const info = @import("princ.zig") ;

const PyString : type = [*c]const u8 ;

const BioError = error{
  UnkownNeclutide ,
  TandUinSameSequence ,
};

fn checkSeq (seq : []u8) BioError![]u8 {
  var TisHere : bool = false ;
  var UisHere : bool = false ;
  const dna = info.dnaBa{};
  for (seq) |nec| {
    _ = switch(nec) {
      dna.C,dna.G,dna.A => continue ,
      dna.T => TisHere = true ,
      dna.U => UisHere = true ,
      else => return BioError.UnkownNeclutide ,
    };
  }
  if (TisHere == UisHere) {
    return BioError.TandUinSameSequence ;
  }
  return seq ;
}

export fn takeSeq (path : PyString) PyString {
  const new_path = read(path) ;
  const fileContent = file.readFile(new_path) ;
  const fastaInfo = file.readFasta(fileContent) ;
  const seq = checkSeq(fastaInfo.seq) catch |err| {
    print ("[1] Error : {}\n",.{err}) ;
    const seq : PyString = "" ;
    return seq ;
  };
  
  return seq.ptr ; 
}

export fn rnaMaker(path : PyString) PyString {
	const seq = read(path) ;
	const rna = trans.transSeq(seq) ;
  return rna.ptr ;
}

export fn seqCount(path : PyString) count.counter {
	const seq = read(path);
	const seqInfo = count.CountSeq(seq) ;
	return seqInfo ;
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
	print ("The socre of alignment is : {d}\n",.{result.map[fasta1.seq.len][fasta2.seq.len]}) ;
}

export fn seqTrad(path : PyString) PyString {
	const seq = read(path) ;
	const prot = trad.tradSeq(seq) ;
  return prot.ptr ;
}






