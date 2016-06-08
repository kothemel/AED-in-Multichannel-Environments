source environment

cp $RMHTK/lib/configs/config.dnncvn .
cp $RMHTK/lib/configs/config.dnnbasic .
cp $RMHTK/lib/info/ident_MFCC_0_D_A .

cp $RMHTK/lib/htefiles/HTE.dnn.am ..
source HTE.dnn.am
cp $RMHTK/lib/replacesil.hed .
cp $RMHTK/python_scripts/GenInitDNN.py .


if [[ ! -f proto/work ]]; then
    mkdir -p proto/work 
fi
cp Embedded_DD/hmm-8GMM/hmm9/hmmdefs proto/work/

# 14.3 Do layerwise discriminative pretraining and finetuning
if [[ ! -z $HTKLIB ]]; then
    HTKLIB='-LIB '$HTKLIB
else
    HTKLIB=''
fi
pretrain $HTKLIB -HNTRAINSGD $HTKBIN/HNTrainSGD -HHED $HTKBIN/HHEd HTE.dnn.am