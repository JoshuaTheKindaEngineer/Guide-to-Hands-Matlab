%The full code that combines the Simulink hand code and Arduino hand
%control to allow both to be controlled at the same time.
%This code clears all of the pre-existing arduino connections to allow new ones
%to be made.
clear a
clear S1
clear S2
clear S3
clear S4
clear S5
%These variables pull in the webcam live feed and custom network trained in
%the other document
f=figure;
w=webcam;
net=Gesturenet;
Out=0;
i=1
a=arduino('COM4','Mega2560')
%D_ stands for signal pin that the servo motor is attached to on the arduino
%(orange wire on motor)
% a refers to connected arduino
%min pulse duration sets the 0 for writePosition as a pulse of 700*10^-6
%This value sets the servo motor to the 0 position
% max pulse sets max to 2300*10^-6 which sets servo motor to 180 degree
% position.
%S1 Thumb, S2 index, S3 middle, S4 ring, S5 little
 S1=servo(a,'D3','MinPulseDuration',700*10^-6,'MaxPulseDuration',2300*10^-6);
 S2=servo(a,'D4','MinPulseDuration',700*10^-6,'MaxPulseDuration',2300*10^-6);
 S3=servo(a,'D5','MinPulseDuration',700*10^-6,'MaxPulseDuration',2300*10^-6);
 S4=servo(a,'D9','MinPulseDuration',700*10^-6,'MaxPulseDuration',2300*10^-6);
 S5=servo(a,'D10','MinPulseDuration',700*10^-6,'MaxPulseDuration',2300*10^-6);

while ishandle(f) 
    im=snapshot(w);
    image(im)
    img=imresize(im,[224,224]);
    [label,score] = classify(net,img);
    title({char(label), num2str(max(score),2)});
    drawnow
if max(score)>=0.98
      if label=='Gesture 1'
         writePosition(S1,1)
         writePosition(S2,1)
         writePosition(S3,1)
         writePosition(S4,1)
         writePosition(S5,1)
          Out=1;
         sim('Final_Simulink_Hand')
      elseif label=='Gesture 2'
         writePosition(S1,0)
         writePosition(S2,0)
         writePosition(S3,0)
         writePosition(S4,0)
         writePosition(S5,0)
         Out=2;
     sim('Final_Simulink_Hand')
      elseif label=='Gesture 3'
        Out=3;
     sim('Final_Simulink_Hand')
          for i=1:5
         writePosition(S1,0)
         pause(0.1)
         writePosition(S2,0)
         pause(0.1)
         writePosition(S3,0)
         pause(0.1)
         writePosition(S4,0)
         pause(0.1)
         writePosition(S5,0)
         pause(0.1)
         writePosition(S1,0.75)
         pause(0.1)
         writePosition(S2,0.75)
         pause(0.1)
         writePosition(S3,0.75)
         pause(0.1)
         writePosition(S4,0.75)
         pause(0.1)
         writePosition(S5,0.75)
         pause(0.1)
         i=i+1
        end
      elseif label=='Gesture 4'
         writePosition(S1,1)
         writePosition(S2,0)
         writePosition(S3,0)
         writePosition(S4,1)
         writePosition(S5,1)
         Out=4;
     sim('Final_Simulink_Hand')
      elseif label=='Gesture 5'
         writePosition(S1,0)
         writePosition(S2,0)
         writePosition(S3,1)
         writePosition(S4,1)
         writePosition(S5,0)
         Out=5;
     sim('Final_Simulink_Hand')
      end
 else
     writePosition(S1,0)
     writePosition(S2,0)
     writePosition(S3,0)
     writePosition(S4,0)
     writePosition(S5,0)
     Out=0;
    set_param('Final_Simulink_Hand', 'SimulationCommand', 'stop');
end

end
