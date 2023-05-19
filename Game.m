 function Game
 %%Начальная конфигурация
    close all;
    global stray_number
    stray_number=1;
    is_Debug = 0; % Дополнительные функции для удобной отладки
    KeyPressedSWAD = [0 0 0 0]; %нажатые клавиши
    progress = [1 1]; %прогресс в диалогах
    add_progress = [1 1];
    is_move = 1; %прогресс в диалогах
    is_close = 0;
    box = 300;
    events_ones = ones(1,10); % Особые события, которые срабатывают лишь 1 раз и обнуляются
    KeyHistory = "";
    deadteleport = 0;
    beep on;
        %events_ones, 0 если да
        %1 1 дверь лазера
        %2 2 дверь лазера
        %3 3 дверь лазера (зажигать ли факела)
        %4 анимация портала
        %5 взятие урановых стержней
        %6 запитывание реактора
        %7 есть ли шапка
        %8 решена ли головоломка с кружкой
        %9 выход стенда рикардно
        %10
    dead_count = 0; %счетчик смертей

%% Настройка сцены
    Screen = groot();
    Scene = figure('Parent',Screen,'NumberTitle', 'off', 'Name', 'Game Dungeon for beta testing', 'Color','Black');
    gridback = axes('Parent',Scene);
    hold(gridback,'on');
    
    axis([3065+1 3065+300 590+1 590+300]);
    back = imread('Data/Images/Map.png');
    Back = imshow(back, 'Parent',gridback);
    set(Scene,'WindowKeyPressFcn',@Key_Down,'WindowKeyReleaseFcn',@Key_Release,'DeleteFcn',@CloseScene,'WindowState','fullscreen');  
    
%% Настройка Столкновений
    %Очередная коллизия = индекс, тип, x, y, w, h;
    Collisions = Collisions_Init(); 
    GCollisions = zeros(1,length(Collisions));%столкновения гг и объектов

%% Настройка Взаимодействий
    %Очередное взаимодействие = индекс, x, y, w, h;
    Interactions = Interactions_Init();
    %взаимодействие гг и объектов
    GInteractions = zeros(1,length(Interactions));% когда гг в объекте
    GInteractionsActive = zeros(1,length(Interactions));%когда гг провзаимодействовал
    
%% Настройка Лазеров
    %lasers1_rotate   =  1 - 45, 2 - 135, 3 - 225, 4 - 315
    lasers_rotate = [4 1 3 2 3 3 4 3 3 4 1 2 2 1 4 4 1 1 3] -1;
    %lasers_rotate = [1 4 3 1 2 4 3 1 2 3 4 1 1 2 1 1 1 1 2] -1;
    %1 4 3 1 2 4 3 1 2 3 4 1 3 2 1 1 1 1 2 - правильная комбинация []-1
    mirrors = [0 0 0 0 0];
    lasers{1} = laser_create(1,Collisions{26});
    lasers{2} = laser_create(2,Collisions{27});
    lasers{3} = laser_create(3,Collisions{28});
    lasers{4} = laser_create(4,Collisions{29});
    lasers{5} = laser_create(5,Collisions{30});
    lasers{6} = laser_create(6,Collisions{31});
    lasers{7} = laser_create(7,Collisions{32});
    lasers{8} = laser_create(8,Collisions{33});
    lasers{9} = laser_create(9,Collisions{34});
    lasers{10} = laser_create(10,Collisions{35});
    lasers{11} = laser_create(11,Collisions{36});
    lasers{12} = laser_create(12,Collisions{37});
    lasers{13} = laser_create(13,Collisions{38});
    lasers{14} = laser_create(14,Collisions{39});
    lasers{15} = laser_create(15,Collisions{40});
    lasers{16} = laser_create(16,Collisions{41});
    lasers{17} = laser_create(17,Collisions{42});
    lasers{18} = laser_create(18,Collisions{43});
    lasers{19} = laser_create(19,Collisions{44});
    
    xinit = [630+20 lasers{1}.object.XData(1)+20];
    yinit = [1895+20 lasers{1}.object.YData(1)+8];
    
%% Настройка дверей
        %Дверь лазер 1
        door1 = d_object('Data/Images/Animations/Doors.png',gridback,struct('X0', 0, 'OffsetX', 0, 'W', 158, 'H', 102,'Length',5),[ 0 0 ]);
        door1.PersonFrame = [1 1];
        door1.InstantMove(Collisions{23}(3),Collisions{23}(4));
        %Дверь лазер 2
        door2 = d_object('Data/Images/Animations/Doors.png',gridback,struct('X0', 1106, 'OffsetX', 0, 'W', 7, 'H', 226,'Length',9),[ 0 0 ]);
        door2.PersonFrame = [1 1];
        door2.InstantMove(Collisions{24}(3),Collisions{24}(4));
        %Дверь лазер 3
        door3 = d_object('Data/Images/Animations/Doors.png',gridback,struct('X0', 0, 'OffsetX', 0, 'W', 59, 'H', 69,'Length',14),[ 102 0 ]);
        door3.PersonFrame = [1 1];
        door3.InstantMove(Collisions{45}(3),Collisions{45}(4));

%% Портал, осьминожка, Ricardo, RacardoShapka
        s_objs{1} = d_object('Data/Images/Animations/Portal.png',gridback,struct('X0', 1, 'OffsetX', 1, 'W', 160, 'H', 120,'Length',12),[ 1 0]);
        s_objs{1}.InstantMove(1406,2050);
        s_objs{1}.object.Visible = 0;
        s_objs{1}.AnimTimer.StartDelay = 0.1;
        s_objs{1}.AnimTimer.TimerFcn = @takeBreak;
        s_objs{2} = d_object('Data/Images/Animations/Architect.png',gridback,struct('X0', 1, 'OffsetX', 1, 'W', 68, 'H', 70,'Length',11),[ 235 164]);
        s_objs{2}.InstantMove(2506,470);
        s_objs{2}.AnimTimer.TimerFcn = @takeBreak;
        uran0 = d_object('Data/Images/Area_Elements_2.png',gridback,struct('X0', 25, 'OffsetX', 0, 'W', 19, 'H', 23,'Length',1),[0 0]);
        uran0.InstantMove(360,202);
        uran0.object.Visible = 0;
        s_objs{3} = d_object('Data/Images/Animations/Ricardo.png',gridback,struct('X0', 0, 'OffsetX', 0, 'W', 80, 'H', 133,'Length',14),[ 0 0]);
        s_objs{3}.InstantMove(1212,358);
        s_objs{3}.AnimTimer.TimerFcn = @takeBreak;
        
         lang = get_file_strings('Data/language.txt');
        if(isempty(lang) || lang{1} ~= "Ru" && lang{1} ~= "En")
            lang{1} = 'En';
            set_file_strings('Data/language.txt',lang{1});
        end
        dialogs_Architector = c_dialog([2436 485], get_dialogs(strcat('Data/Dialogs/d1_',lang{1},'.txt')), 1,1, gridback);
        dialogs_Architector.Visible = 0;
        
%% Огни
        fire_prop = [0 0 0 0 0]; %Visiblep 1,2,3,4,5
        fire= [];
        fire{1} = d_object('Data/Images/Animations/Fire.png',gridback,struct('X0', 1, 'OffsetX', 1, 'W', 14, 'H', 15,'Length',6),[ 31 0]);
        fire{1}.AnimTimer.TimerFcn = @takeBreak;
        fire{1}.InstantMove(1205,2010);
        fire{1}.AnimTimer.StartDelay = 0.14; 
        fire{2} = d_object('Data/Images/Animations/Fire.png',gridback,struct('X0', 1, 'OffsetX', 1, 'W', 14, 'H', 15,'Length',6),[ 31 0]);
        fire{2}.InstantMove(1286,2056);
        fire{2}.AnimTimer.TimerFcn = @takeBreak;
        fire{2}.AnimTimer.StartDelay = 0.14; 
        fire{3} = d_object('Data/Images/Animations/Fire.png',gridback,struct('X0', 1, 'OffsetX', 1, 'W', 14, 'H', 15,'Length',6),[ 31 0]);
        fire{3}.InstantMove(1250,2128);
        fire{3}.AnimTimer.TimerFcn = @takeBreak;
        fire{3}.AnimTimer.StartDelay = 0.14; 
        fire{4} = d_object('Data/Images/Animations/Fire.png',gridback,struct('X0', 1, 'OffsetX', 1, 'W', 14, 'H', 15,'Length',6),[ 31 0]);
        fire{4}.InstantMove(1159,2129);
        fire{4}.AnimTimer.TimerFcn = @takeBreak;
        fire{4}.AnimTimer.StartDelay = 0.14; 
        fire{5} = d_object('Data/Images/Animations/Fire.png',gridback,struct('X0', 1, 'OffsetX', 1, 'W', 14, 'H', 15,'Length',6),[ 31 0]);
        fire{5}.InstantMove(1129,2056);
        fire{5}.AnimTimer.TimerFcn = @takeBreak;
        fire{5}.AnimTimer.StartDelay = 0.14; 
        
%% Настройка персонажа
    player = d_object('Data/Images/Animations/Player.png',gridback,struct('X0', 0, 'OffsetX', 0, 'W', 34, 'H', 48,'Length',9),[639 511 575 703 769 833]);
    %player.InstantMove(315,2088); %Начальное положение
    player.InstantMove(2479,550); %Начальное положение
    player.PersonFrame = [0 2];
    player.AnimTimer.TimerFcn = @playertakeBreak; %таймер анимации
    [playerimovei,~,playerimoveialpha] = imread('Data/Images/Animations/InstantMove.png');
    anim0 = 0; %анимация простоя без повтора
    camera = [1 0 0 0 0]; 
    % is_look использование камеры, которая следует за тобой, 
    %x0 x y0 y параметры камеры
    
    %% прочие объекты
    s_objs{4} = d_object('Data/Images/Area_Elements_2.png',gridback,struct('X0', 0, 'OffsetX', 0, 'W', 20, 'H', 17,'Length',4),[ 45 0]);
    s_objs{4}.object.Visible = 0;
    
    s_objs{5} = d_object('Data/Images/Animations/Icing.png',gridback,struct('X0', 0, 'OffsetX', 0, 'W', 34, 'H', 48,'Length',5),[132 4 68 196 0]);
    s_objs{5}.object.Visible = 0;
    s_objs{5}.InstantMove(0,0);
    %s_objs{5}.AnimYobji = randi([1 4]); %выбираем одну из 4 анимаций
    %не, лучше будем выбирать в зависимости от ориентации игрока
    %s_objs{5}.AnimTimer.TimerFcn = @takeBreak;
    %s_objs{5}.AnimTimer.StartDelay = 0.14; 
    
    s_objs{6} = d_object('Data/Images/Area_Elements_2.png',gridback,struct('X0', 0, 'OffsetX', 0, 'W', 191, 'H', 33,'Length',1),[62 0]);
    s_objs{6}.InstantMove(3548, 366);
    
    %% шапка
    function bandana()
        %3S 1W 2A 4D
        if s_objs{4}.object.Visible && ~events_ones(7)
            switch(player.AnimYobji)
                case 3 %S
                    s_objs{4}.PersonFrame = [0 1];
                    s_objs{4}.InstantMove(player.object.XData(1)+9,player.object.YData(1));
                case 1 %W
                    s_objs{4}.PersonFrame = [2 1];
                    s_objs{4}.InstantMove(player.object.XData(1)+8,player.object.YData(1)-2);
                case 2 %A
                    s_objs{4}.PersonFrame = [1 1];
                    s_objs{4}.InstantMove(player.object.XData(1)+8,player.object.YData(1));
                case 4 %D
                    s_objs{4}.PersonFrame = [3 1];
                    s_objs{4}.InstantMove(player.object.XData(1)+8,player.object.YData(1));
            end
        end
    end
%% Отладка
    if(~is_Debug )
        set(Scene,'MenuBar','none','ToolBar','none'); %скрывает лишнее
    else
        laser_coll = [];  
        %Рисуем хитбоксы взаимодействий для отладки
        for i=1:length(Collisions)
            if isempty(Collisions{i})
                continue;
            end
            obj=Collisions{i};
            rectangle('Position',[obj(3) obj(4) obj(5) obj(6)],'EdgeColor' , 'r','Parent',gridback);
            tid = text(1,1,num2str(i),'Parent',gridback);
            set(tid,'Color','r','Position',[obj(3)+obj(5)-3 obj(4)+5],'HorizontalAlignment','right');
        end
        for i=1:length(Interactions)
            if isempty(Interactions{i})
                continue;
            end
            obj=Interactions{i};
            rectangle('Position',[obj(2) obj(3) obj(4) obj(5)],'EdgeColor' , 'b','Parent',gridback);
            tid = text(1,1,num2str(i),'Parent',gridback);
            set(tid,'Color','blue','Position',[obj(2)+obj(4)-3 obj(3)+5],'HorizontalAlignment','right');
        end
        set(Back,'ButtonDownFcn',@debug_click); %отладка координат при клике
    end
    
   %% система лазеров
   h1 = line('XData',xinit,'YData',yinit,'color','y','LineWidth',4);
   [xinit, yinit, mirrors]=lasers_rays(lasers_rotate,lasers,xinit,yinit,mirrors);
   set(h1,'XData',xinit,'YData',yinit);
   if h1.Visible ~= mirrors(1)
      h1.Visible = mirrors(1); 
   end
    %        axis([ 0 Back.XData(2)+400 0 Back.YData(2)+400]); %фулл карта
    
    
    
%     dia_1 = c_dialog([3147 700], get_file_strings('1.txt'), 1, gridback);
%     dia_1.Next_String(1);
%     dia_1.Visible = 0;

GInteractionsActive(102) = 3;
GInteractions(102) = 1;

%% 
%Главный игровой цикл
    while ~is_close
        tic
        Y=player.object.YData;
        X=player.object.XData;
        old_dead_count = dead_count;
        if all ( ~KeyPressedSWAD )
        player.Animframe = -1;
            if ~anim0 && playerAnimate()
                 anim0=1; 
            end  
        end

%% управление, перемещение %S-Down, W-Up, A-Left, R-Rigth
    if is_move == 1
        if KeyPressedSWAD(2) %W
           player.AnimYobji = 2;
           playerAnimate();
           player.Move(0,-1);
           anim0 = 0;
        end
        if KeyPressedSWAD(3) %A
           player.AnimYobji = 3;
           playerAnimate();
           player.Move(-1,0);
           anim0 = 0;
        end
        if KeyPressedSWAD(4) %D
           player.AnimYobji = 4;
           playerAnimate();
           player.Move(1,0);
           anim0 = 0;
        end
        
        if KeyPressedSWAD(1) %S
           player.AnimYobji = 1;
           playerAnimate();
           player.Move(0,1);
           anim0 = 0;
        end
    end

%% Отрисовка огня
        for i=1:length(fire_prop)
            if fire{i}.object.Visible ~= fire_prop(i) 
                    fire{i}.object.Visible = fire_prop(i);
            end
            if fire_prop(i) && ~events_ones(3) &&  abs(player.object.XData(1)-fire{i}.object.XData(1)) < 400 && abs(player.object.YData(1)-fire{i}.object.YData(1)) < 600
                
                fire{i} = Animate(fire{i},0);
            elseif events_ones(3)
                fire_prop = fire_prop *0;
            end
        end
%% Отрисовка портала
    if  s_objs{1}.object.Visible && abs(player.object.XData(1)-s_objs{1}.object.XData(1)) < 400 && abs(player.object.YData(1)-s_objs{1}.object.YData(1)) < 600
        s_objs{1} = Animate(s_objs{1},0);  
    end
  
%% Проверка столкновений
        for i=1:length(Collisions)
            if isempty(Collisions{i})
                continue;
            end
        obj = Collisions{i};
            if(obj(2)) %столкновение при входе - 0 (защита объекта), при выходе - 1 (удерживание в объекте)
                
                %за фигурой
                cx_ = player.object.XData(1) < obj(3);
                cy_ = player.object.YData(1) < obj(4);
                %перед фигурой
                cx = player.object.XData(2) > obj(3) + obj(5);
                cy = player.object.YData(2) > obj(4) + obj(6);
                
                 if (cx_ || cy_ || cx || cy)   
                    GCollisions(i) = 1;
                 else
                    GCollisions(i) = 0;
                 end
            else
                  %Очередная коллизия = индекс, тип, x, y, w, h;
                  cx  = player.object.XData(2)>obj(3);
                  cx_ = player.object.XData(1)<obj(3)+obj(5);
                  cy  = player.object.YData(2)>obj(4);
                  cy_ = player.object.YData(1)<obj(4)+obj(6);
                  
                 if (cx_ && cy_ && cx && cy)   
                    GCollisions(i) = 1;
                 else
                    GCollisions(i) = 0;
                 end
                
            end     
        end
      
%% Проверка на разрез от лазера :)
if(is_Debug )
 %нагружает знатно
 %for i=2:length(laser_coll)
     %delete(laser_coll{i})
 %end
 %laser_coll = [];
end
        for i=2:length(h1.XData)
        objX = [h1.XData(i-1) h1.XData(i)];
        objY = [h1.YData(i-1) h1.YData(i)];
        if objX(1) == objX(2)
            if objY(1) - objY(2) > 0
            obj = [objX(1)+1 objY(2) 1 objY(1)-objY(2)];
            else
            obj = [objX(1)+1 objY(1) 1 objY(2)-objY(1)];    
            end
           
        else
            if objX(1) - objX(2) > 0
            obj = [objX(2) objY(1)+1 objX(1)-objX(2) 1 ];
            else
            obj = [objX(1) objY(1)+1 objX(2)-objX(1) 1];    
            end
           
        end
        
        %Очередная коллизия = индекс, тип, x, y, w, h;
        cx  = player.object.XData(2)>obj(1);
        cx_ = player.object.XData(1)<obj(1)+obj(3);
        cy  = player.object.YData(2)>obj(2);
        cy_ = player.object.YData(1)<obj(2)+obj(4);
          if (cx_ && cy_ && cx && cy && mirrors(1))   %смотрим, доступен ли лазер и находимся ли мы в нём
             %GCollisions(i) = 1;
             %dead
             if(dead_count < 1)
                add_progress(1) = 12;
             end
             playerlaserDead();
             
          end
          if(is_Debug )
          %нагружает знатно
          %laser_coll{i-1} = rectangle('Position',[obj(1) obj(2) obj(3) obj(4)],'EdgeColor' , 'r','Parent',gridback);
          end
         end
 
%% Реакция на столкновения
        for i=find(GCollisions>0)
            obj = Collisions{i};
            switch(obj(1))
                case 1 % граница
                    if(dead_count == old_dead_count) 
                    %защита от того, когда мы застреваем в текстурах и умираем
                    player.object.YData=Y;
                    player.object.XData=X;  
                    end
            end
        end
       %Бандана
        if GInteractions(85) && sum(KeyPressedSWAD) > 0
            s_objs{4}.object.Visible = 1;
            bandana();
        end    
%% Проверка взаимодействий
        for i=1:length(Interactions)
            if isempty(Interactions{i})
                continue;
            end
        obj = Interactions{i};
                  %Очередная коллизия = индекс, тип, x, y, w, h;
                  cx  = player.object.XData(2)>obj(2);
                  cx_ = player.object.XData(1)<obj(2)+obj(4);
                  cy  = player.object.YData(2)>obj(3);
                  cy_ = player.object.YData(1)<obj(3)+obj(5);
                  
                 if (cx_ && cy_ && cx && cy)   
                    GInteractions(i) = 1;
                 else
                    GInteractions(i) = 0;
                 end                   
        end
%% Реакция на взаимодействие

is_open = 0;
        for i=find(GInteractions>0)
              obj = Interactions{i};
            switch(obj(1))
                case 1 %вращение столба
                    if GInteractionsActive(i) == 1
                       lasers{i}.NextFrame = [1 0 0];
                       lasers{i} = lasers{i}.CurrentFrame();
                       lasers_rotate(i) = lasers{i}.Animframe;
                    end
                    
                     if GInteractionsActive(i) == 2
                       lasers{i}.NextFrame = [-1 0 0];
                       lasers{i} = lasers{i}.CurrentFrame();
                       lasers_rotate(i) = lasers{i}.Animframe; 
                     end
                     if GInteractionsActive(i) > 0
                       if mirrors(1)
                           if h1.Visible ~= mirrors(1)
                              h1.Visible = mirrors(1); 
                           end
                        xinit = xinit(1:2);
                        yinit = yinit(1:2);
                        [xinit, yinit, mirrors, is_open]=lasers_rays(lasers_rotate,lasers,xinit,yinit,mirrors);
                        set(h1,'XData',xinit,'YData',yinit);
                       else
                          h1.Visible = mirrors(1);
                       end
                        GInteractionsActive(i) = 0;
                     end
                case 2 % Открытие дверей
                    if GInteractionsActive(i) == 3          
                        switch(i) %определяем, куда тпхаемся (входим в разные места карты)
                            case 23
                                player.InstantMove(3008,2065);
                            case 29
                                player.InstantMove(407,2142);
                            case 26
                                player.InstantMove(147,470);
                            case 20
                                player.InstantMove(4039,1259);
                            case 25
                                player.InstantMove(3765,2817);
                            case 82
                                player.InstantMove(1234,342);
                            case 21
                                player.InstantMove(2021,1523);
                            case 30
                                %Нельзя попасть
                                InstantplayerHome();
                            case 28
                                player.InstantMove(3639,317);
                            case 22
                                player.InstantMove(2891,1393);
                            case 27
                                player.InstantMove(154,2812);
                            case 24
                                player.InstantMove(3658,1550);
                            case 81
                                player.InstantMove(1234,332);
                        end
                        GInteractionsActive(i) = 0;
                        playerAnimate();
                    end
                case 3 % Дверь хрен знает куда
                
                case 4 % камера
                    camera(1) = 0;
                    camera(2) = Interactions{i}(2);
                    camera(3) = Interactions{i}(2) + Interactions{i}(4);
                    camera(4) = Interactions{i}(3);
                    camera(5) = Interactions{i}(3) + Interactions{i}(5);
                    
                    %Если находимся в холодильнике без шапки
                    if i == 85 && events_ones(7)
                        debuf = debuf + 0.1;
                        progress=[1 3];
                        add_progress(1) = progress(2); 
                    %если шапка
                    elseif i == 85 && ~events_ones(7)
                        debuf = 0;
                        %1234
                    else
                        debuf = 0;
                    end
                    
                    %выход стенда рикардо
                    if i == 86 && ~events_ones(8) && events_ones(9)
                       events_ones(9) = 0;
                       AnimObjPlayX(s_objs{3}.object,s_objs{3}.objectImage,s_objs{3}.objectImageAlpha,0.14,0,80,14,0,133);  
                    end
                    
                     if i == 87  %Осьминожка
                      s_objs{2} = Animate( s_objs{2},0);
                     end
                    
               case 5 %звезда
                    if GInteractionsActive(i) == 3 
                        switch(i) %определяем, кого зажигаем
                            case 96
                                fire_prop(1) = ~fire_prop(1);
                                fire_prop(3) = ~fire_prop(3);
                                fire_prop(4) = ~fire_prop(4);
                            case 97
                                fire_prop(2) = ~fire_prop(2);
                                fire_prop(5) = ~fire_prop(5);
                                fire_prop(4) = ~fire_prop(4);
                            case 98
                                fire_prop(3) = ~fire_prop(3);
                                fire_prop(5) = ~fire_prop(5);
                                fire_prop(1) = ~fire_prop(1);
                            case 99
                                fire_prop(4) = ~fire_prop(4);
                                fire_prop(2) = ~fire_prop(2);
                                fire_prop(1) = ~fire_prop(1);
                            case 100
                                fire_prop(5) = ~fire_prop(5);
                                fire_prop(2) = ~fire_prop(2);
                                fire_prop(3) = ~fire_prop(3);
                        end  
                    end
                    GInteractionsActive(i) = 0;
               case 6 %взял урановые стержни
                   if GInteractionsActive(i) == 3 && events_ones(5)
                    events_ones(5)=0;
                    progress= [1 4];
                    add_progress(1) = progress(2); 
                    uran0.object.Visible = 1;
                   end
                   GInteractionsActive(i) = 0;

               case 7 %вставил урановые стержни
                   if GInteractionsActive(i) == 3 && ~events_ones(5) && events_ones(6)
                        events_ones(6)=0;
                        mirrors(1) = 1;
                        progress= [1 5];
                        add_progress(1) = progress(2); 
                        h1.Visible = mirrors(1);
                        uran = d_object('Data/Images/Area_Elements_2.png',gridback,struct('X0', 0, 'OffsetX', 0, 'W', 25, 'H', 45,'Length',1),[0 0]);
                        uran.InstantMove(3954,324);
                        is_move = 0;
                        laser_reactor = d_object('Data/Images/Animations/Laser_Reactor.png',gridback,struct('X0', 0, 'OffsetX', 0, 'W', 27, 'H', 92,'Length',8),[1 0]);
                        laser_reactor.InstantMove(3848,717);
                        pause(0.4);
                        AnimObjPlayX(laser_reactor.object,laser_reactor.objectImage,laser_reactor.objectImageAlpha,0.1,0,27,8,1,92);
                        is_move = 1;
                   end
                   GInteractionsActive(i) = 0;
                case 8 % прожектор
                    if GInteractionsActive(i) == 3
                        if events_ones(8)
                            is_move = 0;
                            KeyPressedSWAD = KeyPressedSWAD *0;
                            events_ones(8) = ~RGB_Minigame();
                            if ~ events_ones(8) && ~Collisions{103}(1)
                               Collisions{103}(1) = 1; 
                            end
                            is_move = 1;
                        end
                    end
                    GInteractionsActive(i) = 0;
                case 9
                    
                    if GInteractionsActive(i) == 3 && ~events_ones(9) && events_ones(7)
                        events_ones(7) = 0;
                        s_objs{4}.object.Visible = 1;
                        s_objs{3}.PersonFrame = [14 1];
                        progress = [1 13];
                        add_progress(1) =  progress(2);
                        
                    end
                    GInteractionsActive(i) = 0;
                 case 10 % Осьминожка   
                    %% Диалоги  
                    if GInteractionsActive(102) == 3
                        %progress: 1 - текущий диалог, 2 - текущая ветвь диалога
                        is_move = 0;
                        dialogs_Architector.Visible = 1;
                        if(progress(2) == add_progress(1))
                            dialogs_Architector = dialogs_Architector.Get_String(progress(1),progress(2));
                        else
                            dialogs_Architector = dialogs_Architector.Get_String(progress(1),add_progress(1));
                        end
                        
                        if(length(dialogs_Architector.Dialogs{dialogs_Architector.DialogIndex})+1 >= progress(1) + 1) 
                        progress(1) = progress(1) + 1;
                        else
                           if(progress(2) ~= add_progress(1))
                              progress(1) = 1;
                              add_progress(1) = progress(2); 
                              dialogs_Architector = dialogs_Architector.Get_String(progress(1),progress(2));
                              progress(1) = 2;
                           else
                              is_move = 1;
                              dialogs_Architector.Visible = 0;
                              progress(1) = 1;
                              progress = next_dialog(progress);
                              add_progress(1) = progress(2);
                           end
                           
                        end
                        GInteractionsActive(102) = 0;
                    end
                case 11 %end
                    if  ~events_ones(4) && GInteractionsActive(i) == 3
                        is_move = 0;
                        axis([3657 3656+300 2055 2054+300]);
                        tid = text(3807,2100,num2str(dead_count) + " смертей. Хорош!",'Parent',gridback);
                        set(tid,'Color','w','HorizontalAlignment','center','FontSize',48,'Units','pixels','FontName','GOST Common','FontAngle','italic');
                        pause(5);
                        is_close = 1;
                        StartGame();
                    end
            end
        end      
        a=0;
        for iii=85:92
            if GInteractions(iii) == 1
                a= a+1;
            end
        end
        if ~a && ~camera(1)
           camera(1) = 1;
           playerAnimate();
        end
        

%% Особые события
    if mirrors(5) == 1 && events_ones(1)  %Открытие 1 двери лазера
        events_ones(1) = 0;
        Collisions{23}(1) = 0;
        box0 = 600;
        is_move = 0;
        axis([player.object.XData(1)-box0 player.object.XData(2)+box0 player.object.YData(1)-box0 player.object.YData(2)+ box0]);
        AnimObjPlayX(door1.object, door1.objectImage,door1.objectImageAlpha,0.15,0,158,7,0,102);
        is_move = 1;
    end
    if mirrors(10) == 1 && events_ones(2) %Открытие 2 двери лазера
        events_ones(2) = 0;
        Collisions{24}(1) = 0;
        is_move = 0;
        AnimObjPlayX(door2.object, door2.objectImage,door2.objectImageAlpha,0.15,1106,7,9,0,226);
        is_move = 1;
    end
    if is_open && events_ones(3) == 1  %Открытие глазастой двери
        events_ones(3) = 0;
        progress = [1 6];
        add_progress(1) = progress(2); 
        Collisions{45}(1) = 0; %отключает коллизию
        is_move = 0;
        axis([Interactions{84}(2) Interactions{84}(2)+Interactions{84}(4) Interactions{84}(3) Interactions{84}(3)+Interactions{84}(5)]);
        AnimObjPlayX(door3.object, door3.objectImage,door3.objectImageAlpha,0.15,door3.Anim.X0,door3.Anim.W,door3.Anim.Length,door3.AnimYobjs(door3.AnimYobji),door3.Anim.H);
        is_move = 1;
    end
    
    if all(fire_prop) && events_ones(4) %Активация портала
        events_ones(4) = 0;
        s_objs{1}.object.Visible = 1;
    end
    
%Финальная отрисовка, камера в функции animate
    drawnow
%% Учет длительности главного игрового цикла
   %b = toc();
   %speed = round(b *200 - debuf,0);
    speed = 6 - debuf;
          
    %походу наш игрок замерз
    if speed < -40 && ~s_objs{5}.object.Visible
    s_objs{5}.AnimYobji = player.AnimYobji; %ориентация игрока
    s_objs{5}.Position = player.Position();
    s_objs{5}.object.Visible = 1;
    AnimDelaultObjPlayX(s_objs{5}, 0.14); %obj, delay
    
    %img, img_alpha, delay, x0, w (weight step), xi (length|number of frames), y0, h
    %AnimObjPlayX(s_objs{5}.object, s_objs{5}.objectImage,s_objs{5}.objectImageAlpha,0.14, s_objs{5}.Anim.X0, s_objs{5}.Anim.W, s_objs{5}.Anim.Length, s_objs{5}.AnimYobjs(s_objs{5}.AnimYobji), s_objs{5}.Anim.H);
    end
    
    %обычно случается когда в холодосе замерз
    if speed < -50
       speed = 6;
       InstantplayerHome(); 
       s_objs{5}.object.Visible = 0;
    end
    if speed < 0
       speed = 0; 
       is_move = 0;
    end
    if speed > 10
       speed = 10; 
    end
    player.dx = speed;
    player.dy = speed;
    if (is_Debug)
       %toc() 
    end 
    
    %% Читы
    if(contains(KeyHistory,"megalaserpower"))
            lasers_rotate = [1 4 3 1 2 4 3 1 2 3 4 1 3 2 1 1 1 1 2] -1;
            mirrors(1) = 1;
            for li=1:length(lasers)
               lasers{li}.Animframe = lasers_rotate(li);
               lasers{li} = lasers{li}.CurrentFrame();       
            end
            h1.Visible = mirrors(1); 
            xinit = xinit(1:2);
            yinit = yinit(1:2);
            [xinit, yinit, mirrors, ~]=lasers_rays(lasers_rotate,lasers,xinit,yinit,mirrors);
            set(h1,'XData',xinit,'YData',yinit);
            events_ones(3) = 0;
            progress = [1 6];
            add_progress(1) = progress(2); 
            Collisions{45}(1) = 0; %отключает коллизию
            %is_move = 0;
            axis([Interactions{84}(2) Interactions{84}(2)+Interactions{84}(4) Interactions{84}(3) Interactions{84}(3)+Interactions{84}(5)]);
            AnimObjPlayX(door3.object, door3.objectImage,door3.objectImageAlpha,0.15,door3.Anim.X0,door3.Anim.W,door3.Anim.Length,door3.AnimYobjs(door3.AnimYobji),door3.Anim.H);
            is_move = 1;
            
            KeyHistory = "";
            beep;
    end
    if(contains(KeyHistory,"givemebandana"))
            events_ones(7) = 0;
            s_objs{4}.object.Visible = 1;
            s_objs{3}.PersonFrame = [14 1];
            progress = [1 13];
            add_progress(1) =  progress(2);
            KeyHistory = "";
            player.AnimYobjs = player.AnimYobjs +258;
            playerAnimate();
            beep;
    end
    
     if(contains(KeyHistory,"deadteleport"))
         deadteleport = 1;
         KeyHistory = "";
         beep;
     end
      
     if(contains(KeyHistory,"alwayskillme"))
         playerlaserDead();
         %KeyHistory = "alwayskillme";
         beep;
     else
         if(contains(KeyHistory,"killme"))
         playerlaserDead();
         KeyHistory = "";
         beep;
         end
     end
    
    if(contains(KeyHistory,"debugmode"))
    is_Debug = 1;
    % Отладка
    if(~is_Debug )
        set(Scene,'MenuBar','none','ToolBar','none'); %скрывает лишнее
    else
        laser_coll = [];  
        %Рисуем хитбоксы взаимодействий для отладки
        for i=1:length(Collisions)
            if isempty(Collisions{i})
                continue;
            end
            obj=Collisions{i};
            rectangle('Position',[obj(3) obj(4) obj(5) obj(6)],'EdgeColor' , 'r','Parent',gridback);
            tid = text(1,1,num2str(i),'Parent',gridback);
            set(tid,'Color','r','Position',[obj(3)+obj(5)-3 obj(4)+5],'HorizontalAlignment','right');
        end
        for i=1:length(Interactions)
            if isempty(Interactions{i})
                continue;
            end
            obj=Interactions{i};
            rectangle('Position',[obj(2) obj(3) obj(4) obj(5)],'EdgeColor' , 'b','Parent',gridback);
            tid = text(1,1,num2str(i),'Parent',gridback);
            set(tid,'Color','blue','Position',[obj(2)+obj(4)-3 obj(3)+5],'HorizontalAlignment','right');
        end
        set(Back,'ButtonDownFcn',@debug_click); %отладка координат при клике
    end
            KeyHistory = "";
            beep;
    end
    
    end
close();



%% ############ФУНКЦИИ############%

     function Key_Down(obj,event)
         event.Key
          switch event.Key
          case 's'
              KeyPressedSWAD(1)=1;
              KeyPressedSWAD(2)=0;
          case 'w'
              KeyPressedSWAD(2)=1;
              KeyPressedSWAD(1)=0;
          case 'a'
              KeyPressedSWAD(3)=1;
              KeyPressedSWAD(4)=0;
          case 'd'
              KeyPressedSWAD(4)=1;
              KeyPressedSWAD(3)=0;
%           case 'downarrow'
%               KeyPressedSWAD(1)=1;
%           case 'uparrow'
%               KeyPressedSWAD(2)=1;
%           case 'leftarrow'
%               KeyPressedSWAD(3)=1;
%           case 'rightarrow'
%               KeyPressedSWAD(4)=1;
          end

     end

    
    function Key_Release(~,event)
       
        switch event.Key
          case 's'
              if KeyPressedSWAD(1) == 1
                KeyPressedSWAD(1)=0;
              else
                  KeyPressedSWAD = KeyPressedSWAD *0; %err
              end
          case 'w'
              if KeyPressedSWAD(2) == 1
                KeyPressedSWAD(2)=0;
              else
                  KeyPressedSWAD = KeyPressedSWAD *0; %err
              end
          case 'a'
             if KeyPressedSWAD(3) == 1
                KeyPressedSWAD(3)=0;
              else
                  KeyPressedSWAD = KeyPressedSWAD *0; %err
              end
          case 'd'
             if KeyPressedSWAD(4) == 1
                KeyPressedSWAD(4)=0;
              else
                  KeyPressedSWAD = KeyPressedSWAD *0; %err
             end
%           case 'downarrow'
%               if KeyPressedSWAD(1) == 1
%                 KeyPressedSWAD(1)=0;
%               else
%                   KeyPressedSWAD = KeyPressedSWAD *0;
%                   disp("err");
%               end
%           case 'uparrow'
%             if KeyPressedSWAD(2) == 1
%                 KeyPressedSWAD(2)=0;
%               else
%                   KeyPressedSWAD = KeyPressedSWAD *0;
%                    disp("err");
%               end
%           case 'leftarrow'
%              if KeyPressedSWAD(3) == 1
%                 KeyPressedSWAD(3)=0;
%               else
%                   KeyPressedSWAD = KeyPressedSWAD *0;
%                    disp("err");
%               end
%           case 'rightarrow'
%              if KeyPressedSWAD(4) == 1
%                 KeyPressedSWAD(4)=0;
%               else
%                   KeyPressedSWAD = KeyPressedSWAD *0;
%                    disp("err");
%               end
          case 'e' %обычно, поворот влево
            for ii=find(GInteractions>0)
                GInteractionsActive(ii) = 1;
            end
          case 'q' %обычно, поворот влево
            for ii=find(GInteractions>0)
                GInteractionsActive(ii) = 2;
            end
          case 'space' %Открыть, взаимодействовать
            for ii=find(GInteractions>0)
                GInteractionsActive(ii) = 3;
            end
          case 'h'
             if is_move
                InstantplayerHome();
             end
        end
        
        %ЧИТЫ :)
        KeyHistory = KeyHistory + convertCharsToStrings(event.Key);
        if(length(KeyHistory) > 20)
           KeyHistory = "";
        end

    end 

    function playertakeBreak(obj, event)
        player.AnimTimerNextFrame = 1;
    end
    function takeBreak(~, ~)
        
    end

    function ret = playerAnimate()
        if( player.AnimTimer.Running == "off" )
                start(player.AnimTimer);
               if all ( ~KeyPressedSWAD )
                   player.NextFrame = [1 0 0];
               else
                   player.NextFrame = [1 1 0];
               end
               player.CurrentFrame();
               ret = 1;
        else
            ret = 0;
        end
        
        %Камера
        if(camera(1))
            axis([player.object.XData(1)-box player.object.XData(2)+box player.object.YData(1)-box player.object.YData(2)+ box]);
        else
            axis([camera(2) camera(3) camera(4) camera(5)]);
        end
    end

    function obj = Animate(obj, is_stand)
       if obj.AnimTimer.Running == "off"
           start(obj.AnimTimer);
           if( is_stand )
               obj.NextFrame = [1 0 0];
           else
               obj.NextFrame = [1 1 0];
           end
           obj.CurrentFrame();
       end  
    end

    function debug_click(obj, event)
        if event.Button == 1
            disp(round(event.IntersectionPoint,0));
        end
        if event.Button == 2
            aa = round(event.IntersectionPoint,0);
            player.InstantMove(aa(1),aa(2));
        end
    end
    %obj, img, img_alpha, delay, x0, w (weight step), xi (length|number of frames), y0, h
    function AnimObjPlayX(obj,img,img_alpha,delay,x0,w,xi,y0,h) 
           
           for Animframe=0:xi-1
               ofh = y0+1 : y0+h;
               ofw = x0+Animframe*w+1 : x0+Animframe*w + w;

               obj.CData = img(ofh,ofw,1:3); % H,W,RGB
               obj.AlphaData = img_alpha(ofh,ofw);

               drawnow
               pause(delay);
           end
    end

     function AnimDelaultObjPlayX(object,delay1)
        AnimObjPlayX(object.object,object.objectImage,object.objectImageAlpha,delay1,object.Anim.X0,object.Anim.W,object.Anim.Length,object.AnimYobjs(object.AnimYobji),object.Anim.H);
     end

    function CloseScene(obj, events)
        is_close=1;
    end
   
    function InstantplayerHome()
              if deadteleport
                 playerlaserDead();
                 return;
              end
              box2 = 100;
              is_move = 0;
              if GInteractions(87)
                axis([player.object.XData(1)-box2 player.object.XData(2)+box2 player.object.YData(1)-box2 player.object.YData(2)+ box2]);
              end
              %смещение, так как анимация больше персонажа
              player.object.XData(1) = player.object.XData(1) + 2;
              player.object.XData(2) = player.object.XData(1) + 30;
              player.object.YData(1) = player.object.YData(1) - 143;
              player.object.YData(2) = player.object.YData(1) + 190;
              %img, img_alpha, delay, x0, w (weight step), xi (length|number of frames), y0, h
              AnimObjPlayX(player.object,playerimovei,playerimoveialpha,0.14,0,30,11,0,190);
              player.InstantMove(2161,488); %spawn
              
              anim0 = 0; %анимация 0 - простоя
              %камеру перемещаем к игроку
              camera(1) = 0;
              camera(2) = Interactions{87}(2);
              camera(3) = Interactions{87}(2) + Interactions{87}(4);
              camera(4) = Interactions{87}(3);
              camera(5) = Interactions{87}(3) + Interactions{87}(5);
              %player.NextFrame = [1 0 0];
              %playerAnimate();
              axis([player.object.XData(1)-box2 player.object.XData(2)+box2 player.object.YData(1)-box2 player.object.YData(2)+ box2]);
              %смещение, так как анимация больше персонажа
              player.object.XData(1) = player.object.XData(1) + 2;
              player.object.XData(2) = player.object.XData(1) + 30;
              player.object.YData(1) = player.object.YData(1) - 143;
              player.object.YData(2) = player.object.YData(1) + 190;
              AnimObjPlayX(player.object,playerimovei,playerimoveialpha,0.14,330,30,10,0,190);
              %смещаем обратно
              player.AnimYobji = 1;
              playerAnimate();
              
              player.object.YData = [player.object.YData(1) + 143 player.object.YData(1) + player.Anim.H + 143];
              player.object.XData =[player.object.XData(1)-2 player.object.XData(1) + player.Anim.W - 2];
              %возвращаем управление
              KeyPressedSWAD = KeyPressedSWAD *0;
              is_move = 1;
    end

    function playerlaserDead()
      dead_count = dead_count +1;
      box2 = 100;
      is_move = 0;
          %смещение, так как анимация больше персонажа
          player.object.XData(1) = player.object.XData(1) + 2;
          player.object.XData(2) = player.object.XData(1) + 30;
          player.object.YData(1) = player.object.YData(1) - 143;
          player.object.YData(2) = player.object.YData(1) + 190;
      %img, img_alpha, delay, x0, w (weight step), xi (length|number of frames), y0, h
      AnimObjPlayX(player.object,playerimovei,playerimoveialpha,0.14,0,30,11,251,190);
      player.InstantMove(2161,488); %spawn
      
      anim0 = 0; %анимация 0 - простоя
              %камеру перемещаем к игроку
              camera(1) = 0;
              camera(2) = Interactions{87}(2);
              camera(3) = Interactions{87}(2) + Interactions{87}(4);
              camera(4) = Interactions{87}(3);
              camera(5) = Interactions{87}(3) + Interactions{87}(5);
              
              %playerAnimate();
              axis([player.object.XData(1)-box2 player.object.XData(2)+box2 player.object.YData(1)-box2 player.object.YData(2)+ box2]);
              %смещение, так как анимация больше персонажа
              player.object.XData(1) = player.object.XData(1) + 2;
              player.object.XData(2) = player.object.XData(1) + 30;
              player.object.YData(1) = player.object.YData(1) - 143;
              player.object.YData(2) = player.object.YData(1) + 190;
              AnimObjPlayX(player.object,playerimovei,playerimoveialpha,0.14,330,30,10,251,190);
              %смещаем обратно
              player.AnimYobji = 1;
              playerAnimate();
              player.object.YData = [player.object.YData(1) + 143 player.object.YData(1) + player.Anim.H + 143];
              player.object.XData =[player.object.XData(1)-2 player.object.XData(1) + player.Anim.W - 2];
              %возвращаем управление
              KeyPressedSWAD = KeyPressedSWAD *0;
              is_move = 1;
              player.InstantMove(2161,488); %spawn
        
    end

    function laser = laser_create(i,Collision)
        laser = d_object('Data/Images/Animations/Mirror.png',gridback,struct('X0', 0, 'OffsetX', 0, 'W', 39, 'H', 60,'Length',4),[ 0 0 ]);
        laser.PersonFrame = [lasers_rotate(i) 1];
        laser.InstantMove(Collision(3),Collision(4))
    end

    function ret = get_file_strings(file)
        fileID = fopen(file,'r');
        A = textscan(fileID,'%q');
        fclose(fileID);
        ret = convertCharsToStrings(A{1});
    end

     function set_file_strings(file,array)
        fileID = fopen(file,'w');
        if iscell(array)
            for ii=1:length(array)
                fwrite(fileID,array{ii},'char');
            end
        else
          fwrite(fileID,array,'char');  
        end
        fclose(fileID);
     end
     %% Получение диалогов с использование разделителя
     function dialogs = get_dialogs(file)
        fileID = fopen(file,'r');
        A = textscan(fileID,'%q','Delimiter',"\r\n");
        ret = A{1};
        fclose(fileID);
        dialogs = [];
        findsep=[0; find(A{1}==";")];
        for ii=2:length(findsep)
           dialogs{ii-1} = ret(findsep(ii-1)+1:findsep(ii)-1);
        end
     end
end
