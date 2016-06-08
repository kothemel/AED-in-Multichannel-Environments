
import scipy.io.wavfile as wav
import numpy as np
import csv as csv
import glob
import os
import subprocess
from decimal import Decimal

mlf_file = open("master.mlf", "w")
mlf_file.write("#!MLF!#\n")
path = "/media/kothemel/Elements1/Ubuntu_Backup/htk_thesis/training_set/wav/S01/ISOLATED/mic1/"
for i in range (1,251):
	label_file = open("label_files/labs/S01-eventid"+str(i)+"-mic1.lab", "r")
	event = label_file.read();
	mlf_file.write("\"*/S01-eventid"+str(i)+"-mic1.lab\"\n")

	command ="soxi -D "+path+"S01-eventid"+str(i)+"-mic1.wav"

	result = subprocess.check_output("soxi -D "+path+"S01-eventid"+str(i)+"-mic1.wav", shell=True)

	mlf_file.write("0 "+str(int((float(result)-0.02)*10000000)).rstrip()+" "+event+" [2]\n.\n")

mlf_file.close()


