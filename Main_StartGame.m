close all;
Start_Game();
function Start_Game
%Настройка сцены
    Screen = groot();
    MenuBackgroundsNumber = randi([1 4]);
    if MenuBackgroundsNumber == 4
        MenuBackgroundsTextColor = 'white';
    else
        MenuBackgroundsTextColor = 'black'; 
    end
    Scene = figure('NumberTitle', 'off', 'Name', 'Menu Dungeon for beta testing','ToolBar', 'none', 'MenuBar', 'none','Units','pixels','color','#f8f8f4','Resize','off');
    Scene.Parent = Screen;
    set(Scene, 'Position', [0 0 1170 700]);
    gridback = axes('Parent',Scene,'Units','pixels','visible','off','position',[0 -80 1280 853]);
    set(gridback,'Box','off','LineWidth',0.001);
    hold(gridback,'on');
    back = imread(strcat('Data/Images/MenuBackgrounds/B',num2str(MenuBackgroundsNumber),'.png'));
    Back = imshow(back);
    Back.Parent = gridback;
    set(Scene,'KeyReleaseFcn',@Key_Release);
    
    cx = Screen.ScreenSize(3)/2 - Scene.Position(3)/2;
    cy = Screen.ScreenSize(4)/2 - Scene.Position(4)/2;
    %Отобразить окно по центру
    set(Scene,'position',[cx cy Scene.Position(3) Scene.Position(4)]);

%Мультиязычность
    lang = get_file_strings('Data/language.txt');
    if(isempty(lang) || lang{1} ~= "Ru" && lang{1} ~= "En")
        lang{1} = 'En';
        set_file_strings('Data/language.txt',lang{1});
    end
    buttonstext = get_file_strings(strcat('Data/Dialogs/ui_',lang{1},'.txt'));
    

%Интерфейс
    ButtonsImage = imread('Data/Images/Animations/Buttons.png');
    Anim_Button_0 = ButtonsImage(1:60,:,1:3);% H,W,RGB
    Anim_Button_1 = ButtonsImage(61:120,:,1:3);% H,W,RGB
    Anim_Button_2 = ButtonsImage(121:180,:,1:3);% H,W,RGB
    tit = text(1,1,'Dungeon for beta testing ', 'Parent', gridback);
    set(tit,'FontSize',42,'HorizontalAlignment','right','Units','pixels','Position',[1160 716],'FontName','GOST Common','Color',MenuBackgroundsTextColor);
    Button1 = imshow(Anim_Button_0, 'Parent', gridback,'XData',[80  80+280],'YData',[100 100+60]);
    %set(Button1,'ButtonDownFcn',@wbdcb);
    Button2 = imshow(Anim_Button_0, 'Parent', gridback,'XData',[80  80+280],'YData',[185 185+60]);
    Button3 = imshow(Anim_Button_0, 'Parent', gridback,'XData',[80  80+280],'YData',[270 270+60]);
    Button4 = imshow(Anim_Button_0, 'Parent', gridback,'XData',[1160-70  1160],'YData',[740 740+70]);
    Button5 = imshow(Anim_Button_0, 'Parent', gridback,'XData',[1160+20  1160+20+70],'YData',[740 740+70]);
    ButtonText{1} = text(1,1,buttonstext{1});
    ButtonText{2} = text(1,1,buttonstext{2});
    ButtonText{3} = text(1,1,buttonstext{3});
    ButtonText{4} = text(1,1,buttonstext{4});
    ButtonText{5} = text(1,1,buttonstext{5});
    set(ButtonText{1},'FontSize',24,'HorizontalAlignment','center','Units','pixels','FontName','GOST Common','Color', '#FFFFFF','PickableParts','none');
    set(ButtonText{2},'FontSize',24,'HorizontalAlignment','center','Units','pixels','FontName','GOST Common','Color', '#FFFFFF','PickableParts','none');
    set(ButtonText{3},'FontSize',24,'HorizontalAlignment','center','Units','pixels','FontName','GOST Common','Color', '#FFFFFF','PickableParts','none');
    set(ButtonText{4},'FontSize',24,'HorizontalAlignment','center','Units','pixels','FontName','GOST Common','Color', '#FFFFFF','PickableParts','none');
    set(ButtonText{5},'FontSize',24,'HorizontalAlignment','center','Units','pixels','FontName','GOST Common','Color', '#FFFFFF','PickableParts','none');
    set(ButtonText{1},'Position',[240-36 YtoInvY(152)]);
    set(ButtonText{2},'Position',[240-36 YtoInvY(152+74)]);
    set(ButtonText{3},'Position',[240-36 YtoInvY(152+80+74)]);
    set(ButtonText{4},'Position',[1030 114]);
    set(ButtonText{5},'Position',[1110 114]);
    
    set(Button1,'ButtonDownFcn',@ButtonDownMouse,'Tag', 'btn1');
    set(Button2,'ButtonDownFcn',@ButtonDownMouse,'Tag', 'btn2');
    set(Button3,'ButtonDownFcn',@ButtonDownMouse,'Tag', 'btn3');
    set(Button4,'ButtonDownFcn',@ButtonDownMouse,'Tag', 'btn4');
    set(Button5,'ButtonDownFcn',@ButtonDownMouse,'Tag', 'btn5');
    
    %set(Button3,'ButtonDownFcn',@ButtonDownMouse,'Tag', 'btn3');
    set(Scene,'DeleteFcn',@CloseScene);
    set(gcf,'WindowButtonMotionFcn',@wbdcb);
    
    is_close=0;
    is_Main =0;
    is_help =0;
    
    while ~is_close
        if is_Main
           Game();
           is_close=1;
        end
       drawnow
    end
    
    close();
    
    function Key_Release(~,event)
        switch event.Key
          case 'escape'
              is_close=1;
              close();
        end 
    end

        NIP = 0;
        h_r = 0;
        h_rr = 0;
    function ButtonDownMouse(obj,event)
        switch obj.Tag
            case 'btn1'
                if event.Button == 1
                    Button1.CData = Anim_Button_2;
                    pause(0.2);
                    Button1.CData = Anim_Button_1;
                    is_Main = 1;
                end
                
            case 'btn2'
                if event.Button == 1
                    Button2.CData = Anim_Button_2;
                    pause(0.2);
                    Button2.CData = Anim_Button_1;
                    
                    if(~is_help)
                        h_r = rectangle('Parent',gridback,'Position',[416 186 504+100 244+100],'FaceColor','#f8f8f4','LineWidth',2);
                        [map, ~, alp]=imread(strcat('Data/Images/Help_',lang{1},'.png'));
                        h_rr= imshow(map,'Parent',gridback,'XData',[418 418+504+100], 'YData',[188 188+244+100+20]);
                        set(h_rr,'AlphaData', alp);
                        
                        [img,~,img_alpha] = imread('Data/Images/Animations/Player.png');
                        NIP = imshow([0 0 0],'Parent',gridback,'XData',[418+97 418+20+97+30], 'YData',[188+23+20 188+187+80+23+20]);
                        AnimObjPlayX(NIP,img,img_alpha,0.1,1,32,13,1337,187);
                        is_help = 1;
                    else
                        delete(NIP);
                        delete(h_r);
                        delete(h_rr);
                        is_help = 0;
                    end
                end
            case 'btn3'
                if event.Button == 1
                    Button3.CData = Anim_Button_2;
                    pause(0.2);
                end
                is_close = 1;    
            case 'btn4'
                lang{1} = ButtonText{4}.String;
                buttonstext = get_file_strings(strcat('Data/Dialogs/ui_',lang{1},'.txt'));
                for i=1:5
                    ButtonText{i}.String = buttonstext{i};
                end
                set_file_strings('Data/language.txt',lang);
                
            case 'btn5'
                lang{1} = ButtonText{5}.String;
                buttonstext = get_file_strings(strcat('Data/Dialogs/ui_',lang{1},'.txt'));
                for i=1:5
                    ButtonText{i}.String = buttonstext{i};
                end
                set_file_strings('Data/language.txt',lang);
        end
    end
    function wbdcb(obj, ~) 
       if  obj.CurrentPoint(1)+9 > Button1.XData(1) && obj.CurrentPoint(1)+9 < Button1.XData(2)-18 && YtoInvY(obj.CurrentPoint(2))-30-56 > Button1.YData(1) && YtoInvY(obj.CurrentPoint(2))-30-56 < Button1.YData(2) 
           Button1.CData = Anim_Button_1;
       else
           Button1.CData = Anim_Button_0;
       end
       if  obj.CurrentPoint(1)+9 > Button2.XData(1) && obj.CurrentPoint(1)+9 < Button2.XData(2)-18 && YtoInvY(obj.CurrentPoint(2))-30-46 > Button2.YData(1) && YtoInvY(obj.CurrentPoint(2))-30-46 < Button2.YData(2) 
           Button2.CData = Anim_Button_1;
       else
           Button2.CData = Anim_Button_0;
              end
       if  obj.CurrentPoint(1)+9 > Button3.XData(1) && obj.CurrentPoint(1)+9 < Button3.XData(2)-18 && YtoInvY(obj.CurrentPoint(2))-30-36 > Button3.YData(1) && YtoInvY(obj.CurrentPoint(2))-30-36 < Button3.YData(2) 
           Button3.CData = Anim_Button_1;
       else
           Button3.CData = Anim_Button_0;
       end

       if  obj.CurrentPoint(1)+94 > Button4.XData(1) && obj.CurrentPoint(1)+94 < Button4.XData(2)-4 && YtoInvY(obj.CurrentPoint(2))-30 > Button4.YData(1) && YtoInvY(obj.CurrentPoint(2))-30 < Button4.YData(2) 
           Button4.CData = Anim_Button_1;
       else
           Button4.CData = Anim_Button_0;
       end
       
       if  obj.CurrentPoint(1)+94 > Button5.XData(1)-10 && obj.CurrentPoint(1)+94 < Button5.XData(2)-10 && YtoInvY(obj.CurrentPoint(2))-30 > Button5.YData(1) && YtoInvY(obj.CurrentPoint(2))-30 < Button5.YData(2) 
           Button5.CData = Anim_Button_1;
       else
           Button5.CData = Anim_Button_0;
       end
    end

       function AnimObjPlayX(obj,img,img_alpha,delay,x0,w,xi,y0,h) 
           Animframe = x0;
           
           for Xi=2:xi
               ofh = y0+1 : y0+h;
               ofw = (Animframe-1)*w+1 : (Animframe-1)*w + w;

               obj.CData = img(ofh,ofw,1:3); % H,W,RGB
               obj.AlphaData = img_alpha(ofh,ofw);

               drawnow
               Animframe=Animframe+1;
               pause(delay);
           end
       end
   
    function CloseScene(obj, events)
        is_close=1;
    end

    function yy = YtoInvY(y)
        yy = gridback.Position(4)-y;
    end

    function ret = get_file_strings(file)
        fileID = fopen(file,'r');
        A = textscan(fileID,'%q');
        fclose(fileID);
        ret = A{1};
    end

    function set_file_strings(file,array)
        fileID = fopen(file,'w');
        if iscell(array)
            for i=1:length(array)
                fwrite(fileID,array{i},'char');
            end
        else
          fwrite(fileID,array,'char');  
        end
        fclose(fileID);
    end  

end