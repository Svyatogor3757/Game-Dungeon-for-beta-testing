%Данный класс позволяет реализовать диалоги с различными персонажами
classdef c_dialog
    properties
    	Dialogs
        DialogIndex %CELL
        StringIndex %ROW
        Rectangle
        RectangleText
        Parent
        AutoSize = 1;
        OffsetXY = 10;
        OffsetXY_K;
    end
    properties (Dependent)
        Visible
    end
    
    methods
        %% Создание объекта диалога, 
        %параметры: позиция облака, строки
        %начальное положение s0 - строки (из диалога), 
        %sd0 - столбца (из всех диалогов)
        function ret = c_dialog(position,strings,s0,sd0,parent)
            ret.Dialogs = strings;
            ret.StringIndex = s0;
            ret.DialogIndex = sd0;
            ret.Parent = parent;
            
            if length(position) == 2
                [w, h] = ret.CloudSize();
                Pos = [position w h];
                ret.AutoSize = 1;
            else
                Pos = position;
                ret.AutoSize = 0;
            end
            
            ret.Rectangle = rectangle('Parent',parent,'Position',[Pos(1) Pos(2) Pos(3) Pos(4)],'FaceColor','w','LineWidth',2,'Curvature',0.3);
            ret.RectangleText = text(1,1,strings{s0},'Parent',parent);
            set(ret.RectangleText,'Position',[Pos(1) Pos(2)] +ret.OffsetXY,'FontName','GOST Common','FontSize',12,'Color','Black');
        end
        %% Отображает следующую по счету строку в диалоге
        function obj = Next_String(obj,val,is_repeat,s0)
            if nargin == 2
                is_repeat = 0;
                s0 = 1;
            end
            if length(obj.Dialogs{obj.DialogIndex}) >= obj.StringIndex +val
                obj.StringIndex = obj.StringIndex +val;
            elseif is_repeat
                obj.StringIndex = s0;
            end
            obj.Get_String(obj.StringIndex);
        end
        
        %% Следующий диалог
        function obj = Next_Dialog(obj)
           strings1 = obj.Dialogs{obj.DialogIndex};
           if( obj.DialogIndex + 1 < strings1)
             obj.DialogIndex = obj.DialogIndex + 1; 
           end
        end

        
        %% Получить строку диалога
        %Параметры: stringi OR stringi, dalogi
        function obj = Get_String(obj,stringi, dialogi)
            if stringi > length(obj.Dialogs{obj.DialogIndex}) || stringi < 1
                disp("Нет такого индекса в Strings");
                return;
            end
            
            if nargin == 2
                obj.StringIndex = stringi;
            else
                obj.StringIndex = stringi;
                obj.DialogIndex = dialogi;
            end
            strings = obj.Dialogs{obj.DialogIndex};
            obj.RectangleText.String = strings(obj.StringIndex);
            if obj.AutoSize
                 [w, h] = obj.CloudSize();
                 obj.Rectangle.Position = [obj.Rectangle.Position(1) obj.Rectangle.Position(2) w h];
            end
        end
        
        %% Отображение диалога
        function ret = get.Visible(obj)
            ret = [obj.Rectangle.Visible obj.RectangleText.Visible];
        end
        
        function obj = set.Visible(obj,val)
            if length(val) == 1
                obj.Rectangle.Visible = val;
                obj.RectangleText.Visible = val;
            elseif length(val) == 2
               obj.Rectangle.Visible = val(1);
               obj.RectangleText.Visible = val(2);  
            else
               disp("я принимаю максимум 2 параметра"); 
            end
        end
        
        %% Авто Размер облака
        function [w, h] = CloudSize(obj)
             w = 7 *obj.lengthCurrentString() + obj.OffsetXY*obj.OffsetXY_K;
             h = 22;
        end
        
        % Длина текущей строки диалога
        function len = lengthCurrentString(obj)
            strings = obj.Dialogs{obj.DialogIndex};
            len = length(strings{obj.StringIndex});
        end
        
        %% Коэффициент роста размера диалога от размера экрана
        function ret = get.OffsetXY_K(obj)
            k = 1;
            ScreenSize = obj.Parent.Parent.Position;
            ret = ( ScreenSize(3) > 855 )*k + (ScreenSize(3) < 855)* round( obj.lengthCurrentString()*20/72 ,0);
        end
        
    end
    
end