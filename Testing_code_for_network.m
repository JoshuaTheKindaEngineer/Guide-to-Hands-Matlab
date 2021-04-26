%Testing the custom trained network (Gesturenet) with test images.
%Test images is made up of the images originally collected into each gesture 
%folder, that were not used for the network training. This offers an
%opportunity to test the network with images it has never encountered. This
%is a great way to find out how accurate the network is. This phase of the
%process also allows for network optimisation to take place as the testing
%clearly shows the weaknesses with the network.
%Testpred outputs the predictions for what the test images are
TestPred=classify(Gesturenet,GestureTest);
%%
%Performance evaluation
%Used to influence changes to be made to netwrok to improve accuracy
%TestAct is the actual gesture present in the test image, found by reading 
%the labels of each image tested.
TestAct=GestureTest.Labels;
%NumCorrect gives the total correct predictions
NumCorrect=nnz(TestPred==TestAct);
%FractionCorrect gives the accuracy of the custom network. Numel works out 
%total number of images used for testing predictions
FractionCorrect=NumCorrect/numel(TestPred);
%Confusion chart gives a graphical representation of where the errors 
%occured (by class) so that you can find which classes are less 
%accurate/anomalous. This chart compares true values to predictions
confusionchart(GestureTest.Labels,TestPred)
%This code allows me to find images that were not predicted correctly so
%that I can check whether the failed prediction is actually due to an issue
%with the test image
idxWrong=find(TestPred~=TestAct);
for i=1:numel(idxWrong)
    idx=idxWrong(i);
    imshow(readimage(GestureTest,idx))
    title(GestureTest.Labels(idx))
end
numel(idxWrong)
