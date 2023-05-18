
function is_win = RGB_Minigame()

    is_win=-1;
    Screen = groot();
    Scene = figure('Parent',Screen,'NumberTitle', 'off', 'Name', 'Game Dungeon for beta testing', 'Color','Black');
    gridback2 = axes('Parent',Scene);
    hold(gridback2,'on');
    axis([0 1776 0 1332]);
    back = imread('Data/Images/For_backscreen.png');
    Back = imshow(back, 'Parent',gridback2);
    set(Scene,'KeyReleaseFcn',@Key_Release);
    
    set(Scene,'DeleteFcn',@CloseScene);
    function CloseScene(obj, events)
        if is_win < 0
            is_win=0;
        end
    end
        
        
          First_cir{1} = d_object('Data/Images/Animations/Circle.png',gridback2,struct('X0', 0, 'OffsetX', 0, 'W', 444, 'H', 444,'Length',8),[ 0 444 888]);
          First_cir{1}.PersonFrame = [3 1];  
          First_cir{1}.object.XData = First_cir{1}.object.XData+250;   
          First_cir{1}.object.YData = First_cir{1}.object.YData+550;

          First_cir{2} = d_object('Data/Images/Animations/Circle.png',gridback2,struct('X0', 0, 'OffsetX', 0, 'W', 444, 'H', 444,'Length',8),[ 0 444 888]);
          First_cir{2}.PersonFrame = [1 2];  
          First_cir{2}.object.XData = First_cir{2}.object.XData+675;   
          First_cir{2}.object.YData = First_cir{2}.object.YData+550-445;
          
          First_cir{3} = d_object('Data/Images/Animations/Circle.png',gridback2,struct('X0', 0, 'OffsetX', 0, 'W', 444, 'H', 444,'Length',8),[ 0 444 888]);
          First_cir{3}.PersonFrame = [2 3];  
          First_cir{3}.object.XData = First_cir{3}.object.XData+1100;   
          First_cir{3}.object.YData = First_cir{3}.object.YData+550;
          
           Obvod=d_object('Data/Images/Animations/Circle.png',gridback2,struct('X0', 3559, 'OffsetX', 0, 'W', 455, 'H', 455,'Length',1),[379]);
           Obvod.object.XData = Obvod.object.XData+250-5;
           Obvod.object.YData = Obvod.object.YData+550-5;
           Obvoda=Obvod.object.AlphaData;
          y=1;
 Povor = 0;    
 Chose = 1;

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      while is_win == -1
          drawnow
        if Povor == 1
        First_cir{Chose}.NextFrame = [1 0 0];
        First_cir{Chose} = First_cir{Chose}.CurrentFrame();
        Povor = 0;
        end
        if Povor == 2
        First_cir{Chose}.NextFrame = [-1 0 0];
        First_cir{Chose} = First_cir{Chose}.CurrentFrame();
        Povor = 0;
        end
        if Povor == 3
            Povor = 0;
            Obvod.object.AlphaData=0;
            for p = 1:17
            First_cir{1}.object.XData = First_cir{1}.object.XData+25;
            First_cir{3}.object.XData = First_cir{3}.object.XData-25;
            First_cir{2}.object.YData = First_cir{2}.object.YData+445/17;
            drawnow
            end
            First_cir{2}.object.CData(First_cir{2}.object.CData==255)=0;
            First_cir{1}.object.CData(First_cir{1}.object.CData==255)=0;
            First_cir{3}.object.CData(First_cir{3}.object.CData==255)=0;
            
            
            Cir=First_cir{2}.object.CData+First_cir{1}.object.CData+First_cir{3}.object.CData;
            CirA=First_cir{2}.object.AlphaData | First_cir{1}.object.AlphaData | First_cir{3}.object.AlphaData;
            Ciri=imshow(Cir,'Parent',gridback2);
            Ciri.XData=First_cir{1}.object.XData;
            Ciri.YData=First_cir{2}.object.YData;
            Ciri.AlphaData = CirA;
            pause(3);
            
            if First_cir{1}.Animframe==0 && First_cir{3}.Animframe==0 && First_cir{3}.Animframe==0
                is_win=1;
                
            else
            Ciri.AlphaData=0;
            for p = 1:17
            First_cir{1}.object.XData = First_cir{1}.object.XData-25;
            First_cir{3}.object.XData = First_cir{3}.object.XData+25;
            First_cir{2}.object.YData = First_cir{2}.object.YData-445/17;
            drawnow
            end
            Obvod.object.AlphaData=Obvoda;
            end
        end

 
      end
       if is_win == 1
           close();
            return;
        end
       function Key_Release(obj,event)
        switch event.Key
          case 's'
          case 'w'
              Chose=2;
            InstantMove(Obvod,First_cir{2}.object.XData(1)-5,First_cir{2}.object.YData(1)-5)
          case 'a'
              Chose=1;
            InstantMove(Obvod,First_cir{1}.object.XData(1)-5,First_cir{1}.object.YData(1)-5)
          case 'd'
              Chose=3;
            InstantMove(Obvod,First_cir{3}.object.XData(1)-5,First_cir{3}.object.YData(1)-5)
          case 'e' %обычно, поворот влево
              Povor=1;

          case 'q' %обычно, поворот влево
              Povor=2;

          case 'space' %Открыть, взаимодействовать
              Povor=3;

        end 
    end
end