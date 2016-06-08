echo "---------------Clean expired directories---------------"


count=0

rm -rf ../training/input_hmm/hmm1 ../training/input_hmm/hmm2 ../training/input_hmm/hmm3 ../training/input_hmm/hmm4 \
		../training/input_hmm/hmm5 ../training/input_hmm/hmm6 ../training/input_hmm/hmm7 ../training/input_hmm/hmm8 \
		../training/input_hmm/hmm9 ../training/input_hmm/hmm-2GMM ../training/input_hmm/hmm-4GMM \
		../training/input_hmm/hmm-8GMM ../training/input_hmm/hmm-16GMM

# Step 1
echo "---------------Start training initial model---------------"


while [ $count -lt 9 ] 
do
    prvcnt=$count  
    let count++
    
    
    mkdir -p ../training/input_hmm/hmm$count
    ../../bin.cpu/HERest -A -D -T 1 -C config_files/config -I mlf_files/labslist.mlf -S label_files/train_list.scp -H ../training/input_hmm/hmm${prvcnt}/macros -H \
    ../training/input_hmm/hmm${prvcnt}/hmmdefs -M ../training/input_hmm/hmm$count  ../training/input_hmm/hmm0/monophones0
done

echo "---------------Finished training initial model---------------"


mkdir ../training/input_hmm/hmm-2GMM  ../training/input_hmm/hmm-4GMM  ../training/input_hmm/hmm-8GMM \
	  ../training/input_hmm/hmm-16GMM


# Step 2
echo "---------------Split gaussian mixture models---------------"

count=2
while [ $count -lt 32 ]
do
	mkdir ../training/input_hmm/hmm-${count}GMM/hmm1
	../../bin.cpu/HHEd -H ../training/input_hmm/hmm9/hmmdefs -M ../training/input_hmm/hmm-${count}GMM/hmm1 \
	../training/input_hmm/split${count}.hed ../training/input_hmm/hmmlist
	let "count = count*2"
done

echo "---------------GMM splitting ended---------------"


# Step 3
echo "---------------Start training updated models---------------"
model=2

while [ $model -lt 32 ] #for every model
do

	count=1

	while [ $count -lt 9 ] #for nine times, train!
	do
	    prvcnt=$count
	    let count++
	    
	    
	    mkdir -p ../training/input_hmm/hmm-${model}GMM/hmm$count
	    cp ../training/input_hmm/hmm9/macros ../training/input_hmm/hmm-${model}GMM/hmm1
		../../bin.cpu/HERest -A -D -T 1 -C config_files/config -I mlf_files/labslist.mlf -S label_files/train_list.scp -H ../training/input_hmm/hmm-${model}GMM/hmm${prvcnt}/macros\
		 -H ../training/input_hmm/hmm-${model}GMM/hmm${prvcnt}/hmmdefs -M ../training/input_hmm/hmm-${model}GMM/hmm$count  ../training/input_hmm/hmm0/monophones0
	done
	echo $nxtmodel
	let model=model*2
done

echo "---------------Finished training updated models---------------"

count=2

while [ $count -lt 16 ]
do
	echo "Start testing - Model with ${count} GMMs"

	../../bin/HVite -A -D -T 1 -H ../training/input_hmm/hmm-${count}GMM/hmm9/macros -H ../training/input_hmm/hmm-${count}GMM/hmm9/hmmdefs \
	 -C config_files/config -S label_files/force_align_test.scp -l '*' -i ../decoding/recout-${count}GMM-DD.mlf \
	  -w ..lang_model/auto/wdnet -p -380.0 -s 5.0 ../lang_model/lexicon Embedded_HMMs_training/input_hmm/hmmlist

	 # ../bin/HResults -I ../test_entire_s08/mfcc-delta-delta/testref-all39.mlf Embedded_HMMs_DeltaDelta/tiedlist \
	 # ../test_entire_s08/mfcc-delta-delta/recout-${count}GMM-DD.mlf
	let count=count*2 
done

echo "Finished testing"