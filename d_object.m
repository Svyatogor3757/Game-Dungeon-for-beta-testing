classdef d_object
   properties
   object
   objectImage
   objectImageAlpha
   AlphaobjectImage
   Parent
   dx = 3;
   dy = 3;
   AnimTimer
   AnimTimerNextFrame = 1; %Можно ли переключать следующий фрейм
   Anim = struct(); %Параметры для создания кадров
   AnimYobjs = []; %Разные анимации по Y
   AnimYobji = 1; %Индекс текущей анимации
   Animframe = 1; %Текущий кадр анимации
   end
   properties (Dependent)
       PersonFrame
       NextFrame 
       takeBreak
       CurrentFrame
       Position
   end
   methods
       function ret = d_object(objectImage,objparent,anim,animyobjs)
           ret.AnimYobjs = animyobjs; 
           ret.Anim = anim; %S-Down, W-Up, A-Left, R-Rigth
           ret.Parent = objparent;
           ret.AnimTimer = timer();
           ret.AnimTimer.StartDelay = 0.1;

           [ret.objectImage, ~,ret.objectImageAlpha] = imread(objectImage); %текстура со всеми фреймами
           ret.object = image([[0 0 0] [0 0 0]], 'Parent',objparent); %запись и отображение персонажа
           ret.PersonFrame = [0 1]; %1 кадр
       end
       
       function obj = set.PersonFrame(obj,value)
            obj.Animframe = value(1);
            obj.AnimYobji = value(2);

            playerimage = obj.PersonFrame();
            obj.object.CData = playerimage{1};
            obj.object.AlphaData = playerimage{2};
       end
       
       function ret = get.PersonFrame(obj)
           ofh = obj.AnimYobjs(obj.AnimYobji)+1 : obj.AnimYobjs(obj.AnimYobji) +obj.Anim.H;
           ofw = obj.Animframe*obj.Anim.W + obj.Animframe*obj.Anim.OffsetX + obj.Anim.X0 + 1 : (obj.Animframe*obj.Anim.W+obj.Animframe*obj.Anim.OffsetX+obj.Anim.X0) + obj.Anim.W;
           ret{1} = obj.objectImage(ofh,ofw,1:3); % H,W,RGB
           ret{2} = obj.objectImageAlpha(ofh,ofw);
       end
       
       function obj = set.NextFrame(obj,value) %Xoffset, X0, Yoffset
           if abs(value(1))
               if obj.Animframe+value(1) < obj.Anim.Length && obj.Animframe+value(1) >= 0
                    obj.Animframe = obj.Animframe+value(1);
               else
                   if(value(1)>0)
                    obj.Animframe = value(2);
                   else
                    obj.Animframe = obj.Anim.Length-1-value(2);   
                   end
               end
           end
           
           if value(3)
                if obj.AnimYobji+1 < length(obj.AnimYobjs)
                    obj.AnimYobji = obj.AnimYobji+1;
               else
                    obj.AnimYobji = 1;
               end
           end  
       end

       function obj = set.CurrentFrame(obj,~)
           obj.PersonFrame = [obj.Animframe obj.AnimYobji];
       end
       
       function obj = get.CurrentFrame(obj)
           obj.CurrentFrame = 1;
       end
             
       function Move(obj,x,y)
           obj.object.XData = obj.object.XData + obj.dx*x;
           obj.object.YData = obj.object.YData + obj.dy*y;
       end
       
       function InstantMove(obj,x,y)
           obj.object.XData = obj.object.XData - obj.object.XData(1) + x;
           obj.object.YData = obj.object.YData - obj.object.YData(1) + y;
       end
       
       function ret = get.Position(obj)
           ret =[ obj.object.XData(1) obj.object.YData(1)];
       end
       
       function obj = set.Position(obj, pos)
           if(length(pos) < 4)
              obj.object.XData = obj.object.XData - obj.object.XData(1) +pos(1);
              obj.object.YData = obj.object.YData - obj.object.YData(1) +pos(2);
           else
              obj.object.XData = [pos(1) pos(3)];
              obj.object.YData = [pos(2) pos(4)];
           end
       end
       
   end
end
