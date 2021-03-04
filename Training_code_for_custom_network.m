%This creates a variable out of the subfolders containing all of the
%gesture images.
Gestures=imageDatastore("Insert Directory of folder that contains all of the sub folders with the gesture images","IncludeSubfolders",true,"LabelSource","foldernames");
%This splits the images with the same (gesture) label to 80% for training
%the custom network and 20% to test the network once it is trained.
[GestureTrain,GestureTest]=splitEachLabel(Gestures,0.8,"randomized");
%This loads in googlenet which is a pre-existing network as a variable 'net'
net=googlenet;
%net.Layers
lgraph=layerGraph(net);
newFCLayer=fullyConnectedLayer(5,"Name","new_FC_Layer");
lgraph=replaceLayer(lgraph,"loss3-classifier",newFCLayer);
newOut=classificationLayer("Name","new_out");
lgraph=replaceLayer(lgraph,"output",newOut);
%%
%Training options
%This changes training rate to be smaller as 0.1, the default setting, is 
%too fast and leads to inaccurate training results as the steps are too 
%large in training. sgdm is the gradient descent with momentum. It is a 
%method of training the network
%After testing and troubleshooting, these are the changes i made to the
%default settings. All the changes could be completed in one options
%function. The mini-batch size, max epochs and learn rate were changed to
%these optimised values.
options=trainingOptions("sgdm","InitialLearnRate",0.0005,"MiniBatchSize",10,"MaxEpochs",30,"Plots","training-progress")
%This line of code starts the training of the network with the GestureTrain 
%images I have collected by randomly separating all of the images for each 
%gesture folder into GestureTrain and GestureTest. This function also
%displays a graph of the training as it progresses, with Loss and accuracy
%plotted against Epochs completed during the training.
[Gesturenet,info]=trainNetwork(GestureTrain,lgraph,options);
