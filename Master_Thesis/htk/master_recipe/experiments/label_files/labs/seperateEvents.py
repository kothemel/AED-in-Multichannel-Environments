import scipy.io.wavfile as wav
import numpy as np
import csv as csv
import glob
import os
from subprocess import call,Popen

f2 = open('codetrain.scp', 'w')
#for i in range (1,7):

	#if i==8:
	#	continue

	os.chdir('S0'+str(i))
	session = os.getcwd();

	f = open('duration.txt', 'r');
	audio_duration = float(f.readline());

	readdata = csv.reader(open("s0"+session[-1:]+".csv",'r'))
	data = []

	# store the time intervals denoted in the .csv file
	for row in readdata:
		data.append(row)

  	# for every channel isolate the data according to the .csv file
  	
  	for j in range (1,25):
  		count = 1
  		os.chdir('ISOLATED');
  		#call(["mkdir", "mic"+str(j)])
		os.chdir('../');


  		#command = 'sox  S0'+str(i)+'_'+str(j)+'.wav' +' '+'ISOLATED/mic'+str(j)+'/S0'+str(i)+'-eventid'+str(count)+'-mic'+str(j)+'.wav'+' trim'+' '+'0'+' '+data[0][0]+'\n'+'done'
  		#os.system(command)
  		#f2.write('../training_set/wav/S0'+str(i)+'/ISOLATED/mic'+str(j)+'/S0'+str(i)+'-eventid'+str(count)+'-mic'+str(j)+'.wav '+'../training_set/mfcc/S0'+str(i)+'/ISOLATED/mic'+str(j)+'/S0'+str(i)+'-eventid'+str(count)+'-mic'+str(j)+'.mfc\n');
  		labfile = open('S0'+str(i)+'-eventid'+str(count)+'-mic'+str(j)+'.lab','w')
  		command = "sox 'S0'+str(i)+'-eventid'+str(count)+'-mic'+str(j)+'.wav -n stat 2>&1 | sed -n 's#^Length (seconds):[^0-9]*\([0-9.]*\)$#\1#p' " 
		labfile.write('si')
  		count=count+1

  		for k in range (0, len(data)):
  			if ((i==2) and (count==265 or count==267)) or ((i==3) and (count==27 or count==39 or count==51 or count==63 or count==83 or count==85 or count==99)) or ((i==4) and count==151):
  				print count
  				count=count+1
  				continue
  				
  			start = data[k][0]
  			duration = str(float(data[k][1]) - float(data[k][0]))

  			#command = 'sox  S0'+str(i)+'_'+str(j)+'.wav' +' '+'ISOLATED/mic'+str(j)+'/S0'+str(i)+'-eventid'+str(count)+'-mic'+str(j)+'.wav'+' trim'+' '+start+' '+duration+'\n'+'done'
	  		#os.system(command)
	  		#f2.write('../training_set/wav/S0'+str(i)+'/ISOLATED/mic'+str(j)+'/S0'+str(i)+'-eventid'+str(count)+'-mic'+str(j)+'.wav '+'../training_set/mfcc/S0'+str(i)+'/ISOLATED/mic'+str(j)+'/S0'+str(i)+'-eventid'+str(count)+'-mic'+str(j)+'.mfc\n');
	  		labfile = open('S0'+str(i)+'-eventid'+str(count)+'-mic'+str(j)+'.lab','w')
			labfile.write(data[k][2])
	  		count=count+1

	  		
	  		if (k<(len(data)-1)):
				end = data[k][1]
	  			sp_end = data[k+1][0]

	  			if (sp_end>end):
		  			sp_duration = str(float(sp_end)-float(end))
		  			#command = 'sox  S0'+str(i)+'_'+str(j)+'.wav' +' '+'ISOLATED/mic'+str(j)+'/S0'+str(i)+'-eventid'+str(count)+'-mic'+str(j)+'.wav'+' trim'+' '+end+' '+sp_duration+'\n'+'done'
			  		#os.system(command)
			  		#f2.write('../training_set/wav/S0'+str(i)+'/ISOLATED/mic'+str(j)+'/S0'+str(i)+'-eventid'+str(count)+'-mic'+str(j)+'.wav '+'../training_set/mfcc/S0'+str(i)+'/ISOLATED/mic'+str(j)+'/S0'+str(i)+'-eventid'+str(count)+'-mic'+str(j)+'.mfc\n');
			  		labfile = open('S0'+str(i)+'-eventid'+str(count)+'-mic'+str(j)+'.lab','w')
					labfile.write('si')
			  		count=count+1

		start = data[k][1]
		duration = str(audio_duration - float(start))

		#command = 'sox  S0'+str(i)+'_'+str(j)+'.wav' +' '+'ISOLATED/mic'+str(j)+'/S0'+str(i)+'-eventid'+str(count)+'-mic'+str(j)+'.wav'+' trim'+' '+start+' '+duration+'\n'+'done'
		#os.system(command)
		#f2.write('../training_set/wav/S0'+str(i)+'/ISOLATED/mic'+str(j)+'/S0'+str(i)+'-eventid'+str(count)+'-mic'+str(j)+'.wav '+'../training_set/mfcc/S0'+str(i)+'/ISOLATED/mic'+str(j)+'/S0'+str(i)+'-eventid'+str(count)+'-mic'+str(j)+'.mfc\n');
		labfile = open('S0'+str(i)+'-eventid'+str(count)+'-mic'+str(j)+'.lab','w')
		labfile.write('si')


	#print data[1][0]
	os.chdir('../')
