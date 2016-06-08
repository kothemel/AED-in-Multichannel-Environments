# Clean old files
#rm -f proto/dnn0 dnn/init/hmmdefs

# Initiate the initial DNN model
#python GenInitDNN.py -v dnn_settings/HTE.dnn.am proto/dnn0
#cp dnn0 ../proto

#Connect the output of GMM model with the DNN ones
#../../bin.cpu/HHEd -H hmm_model/hmmdefs -M dnn/init connect.hed  Embedded/tiedlist

# Variance vector generator
#../../bin.cpu/HCompV -p *%%% -k *.%%% -C config_files/cvn.cfg -q v -c cvn -S label_files/train.scp

# Pretrain stage
../../bin.cpu/HNTrainSGD -C config_files/config.basic -C config_files/config.pretrain -H dnn/init/hmmdefs \
-M dnn -S label_files/dnn.train.scp -N label_files/dnn.hv.scp -l LABEL -I mlf_files/labslist.mlf hmm_model/hmmlist