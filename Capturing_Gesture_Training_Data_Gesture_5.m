w = webcam;
%This code looks to see if the folder full of training images for gesture 5
%exists and if it does it deletes it.
if isfolder('Insert Directory of folder that will contain gesture 5 images')
    rmdir('Insert Directory of folder that will contain gesture 5 images','s')
end
%This line of code creates the new directory of images that is about to be
%filled with images of gesture 5.
mkdir('Insert Directory of folder that will contain gesture 5 images')
%This for loop captures 50 images and adds them to the newly created folder
%for gesture 5 images
for i=1:50 % run for 50 iterations
    imgoriginal = w.snapshot;
    img=imresize(imgoriginal,[224 224]);
    imshow(img) % display the image
    f = fullfile('Insert Directory of folder that will contain gesture 5 images',['Gesture 5' num2str(i) '.jpg'])
    imwrite( img,f)
    pause(1); % pause for one second
    i=i+1;
end