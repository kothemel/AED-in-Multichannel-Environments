# Clean old files
rm -f proto/dnn0 dnn/init/hmmdefs

# Initiate the initial DNN model
python GenInitDNN.py -v dnn_settings/HTE.dnn.am proto/dnn0
#cp dnn0 ../proto

#Connect the output of GMM model with the DNN ones
../bin.cpu/HHEd -H hmm_model/hmmdefs -M dnn/init connect.hed  Embedded_DD/tiedlist

# Variance vector generator
../bin.cpu/HCompV -p *%%% -k *.%%% -C cvn.cfg -q v -c cvn -S train.scp

# Pretrain stage
../bin.cpu/HNTrainSGD -C config.basic -C config.pretrain -H dnn/init/hmmdefs -M dnn -S dnn.train.scp -N dnn.hv.scp -l LABEL -I labslist.mlf tiedlist