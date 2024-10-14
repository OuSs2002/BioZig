import os
import sys
from colorama import Fore as f
import time

def shows(s) -> None :
	for i in s :
		print (i,end="")
		sys.stdout.flush()
		time.sleep(0.05)
	print ()

def finder(t,fold,list_files) -> list :
	for f in fold :
		if t in f :
			list_files.append(f)
	return list_files

os.system("clear")
shows("WELCOME TO FVP(THE FILE VERFIRER PROGRAMM) .v1")
fs = os.listdir("file_system")

finded_files : list = []

finded_files = finder(".py",fs,finded_files)

req_files = [
	"trad.py",
	"trans.py",
	"seqInfo.py",
]

def show(s,isReady) -> None :
	for c in s :
		print (c,end="")
		sys.stdout.flush()
		time.sleep(0.05)
	print (isReady)

isGood : bool = True
Mess_files : list = []

for file in req_files :
	sent = f"[*] The State of the file {file} : "
	if file in finded_files :
		r = f.GREEN+"READY"+f.WHITE
		show(sent,r)
	else :
		r = f.RED+"NOT READY"+f.WHITE
		show(sent,r)
		isGood = False
		Mess_files.append(file)

if isGood == False :
	print ("PLEASE CHECK YOUR FILES : ")
	for file in Mess_files :
		print (f"- {file}")
else :
	shows("HAVE A HAPPY DAY")
	os.system("touch .cache")

