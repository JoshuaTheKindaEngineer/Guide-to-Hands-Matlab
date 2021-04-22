f=figure;
w=webcam;
net=Gesturenet;
Out=0;
%This overall while loop containing an if loop has the same structure as
%the simulink code. 'While ishandle(f)' means that while the figure (f) 
%exists, the code within the while loop will continue to run. Constant 
%snapshots are taken live from the webcam, resized to be inputted into my 
%custom network and then run through the network. The networks gesture 
%prediction is then displayed on the figure of the webcams live feed along 
%with the certainty of the predictions. The 'if' loop that follows this code 
%runs if the certainty of the prediction made by the network is above or
%equal to 0.98. If it is not, the program tells Simulink to stop running a 
%simulation. If the certainty is above 0.98, the inner 'if' loop will run. 
%This inner 'if' loop looks at the label of the classification given to the 
%current webcam video and runs different codes based on which label is 
%present. The different codes run the simulink model 
%(named 'mk3_hand_model_torue_input') saved in the same folder as this code, 
%with the value assigned to 'Out' by that condition of the if loop (e.g.:
%Out=2). This Out variable exists in the Simulink model 
%'mk3_hand_model_torue_input' and is multiplied by a constant (1) to act as
%the control input into switch ports that select which data inputs pass 
%through to control the simulated hand.
while ishandle(f)
    im=snapshot(w);
    image(im)
    img=imresize(im,[224,224]);
    [label,score] = classify(net,img);
    title({char(label), num2str(max(score),2)});
    drawnow
if max(score)>=0.98
      if label=='Fist'
         Out=1;
         sim('Final_hand_model')
      elseif label=='OpenHand'
     Out=2;
     sim('Final_hand_model')
      elseif label=='Balala'
     Out=3;
     sim('Final_hand_model')
      elseif label=='scissors'
     Out=4;
     sim('Final_hand_model')
      elseif label=='Rocking'
     Out=5;
     sim('Final_hand_model')
      end
else
    Out=0;
    set_param('Final_hand_model', 'SimulationCommand', 'stop');
        
end

end
