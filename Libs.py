#this file is to make 
import sys
import ctypes

sys.path.append("files")

from file_system import trans 
from file_system import trad
from file_system import seqInfo
from file_system import readFasta

ziglibs = ctypes.CDLL("./zfile_system/libConPoint.so")


class Info_of_seq (ctypes.Structure) :
  _fields_ = [
    ("A",ctypes.c_uint32),
    ("C",ctypes.c_uint32),
    ("G",ctypes.c_uint32),
    ("T",ctypes.c_uint32),
    ("U",ctypes.c_uint32),
    ("Length",ctypes.c_size_t),
    ("Type",ctypes.c_char_p),
    ("GCp",ctypes.c_float),
  ]


class Bio_libs :
  def transcription (seq : str , lang : str = "-p" ,dirc : chr = 'f') -> str :
    if lang == "-p" :
      if dirc == 'f' :
        rna : str = trans.transForward(seq)
      else : 
        rna : str = trans.transBackward(seq)
    
      return rna
    
    elif lang == "-z" :
      ziglibs.rnaMaker.argtypes = [ctypes.c_char_p]
      ziglibs.rnaMaker.restype = ctypes.c_char_p
      result = ziglibs.rnaMaker(seq.encode("utf-8"))
      rna : str = result[0:len(seq)].decode("utf-8")
      return rna

  def traduction (seq : str ,lang : str = "-p" ,seqType : str = "DNA") -> str :
    if lang == "-p" :
      prot : str = trad.tradSeq(seq,seqType)
      return prot

    elif lang == "-z" :
      ziglibs.seqTrad.argtypes = [ctypes.c_char_p]
      ziglibs.seqTrad.restype = ctypes.c_char_p
      result = ziglibs.seqTrad(seq.encode("utf-8"))
      prot : str = result[0:int(len(seq)/3)].decode("utf-8")
      return prot

  def seq_info (seq : str , lang : str = "-p") -> dict :
    if lang == "-p" :
      seq_info_result : dict = seqInfo.seqinfo(seq)
      return seq_info_result
    
    elif lang == "-z" :
      ziglibs.seqCount.argtypes = [ctypes.c_char_p]
      ziglibs.seqCount.restype = Info_of_seq
      result = ziglibs.seqCount(seq.encode("utf-8"))
      seq_info_result : dict = {
        "A" : result.A,
        "C" : result.C,
        "G" : result.G,
        "T" : result.T,
        "U" : result.U,
        "Length" : result.Length, 
        "Type" : result.Type[0:len(result.Type)].decode("utf-8"),
        "GC%" : str(round(result.GCp * 100,2)) + "%" ,
      }
      return seq_info_result 

  def global_align (path_1 : str , path_2 : str , match : int , mmatch : int , gap : int , lang : str) -> int :
    if lang == "-p" :
      result : int = NW(seq1 , seq2 , match , mmatch , gap)
      return result
    elif lang == "-z" :
      ziglibs.globalAlignment(path_1.encode("utf-8"), path_2.encode("utf-8"), match , mmatch ,gap)
      return None


def pdict (info : dict) -> None :
  for key ,value in info.items() :
    print (f"{key} : {value}")

def takeSeqFromFile(path : str) -> str :
  ziglibs.takeSeq.argtypes = [ctypes.c_char_p]
  ziglibs.takeSeq.restype = ctypes.c_char_p
  zigSeq = ziglibs.takeSeq(path.encode("utf-8"))
  seq : str = zigSeq[0:len(zigSeq)-1].decode("utf-8")
  return seq
