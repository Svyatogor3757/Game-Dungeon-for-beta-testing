function Interactions = Interactions_Init(Interactions)
    if nargin < 1
        Interactions = [];
    end
  %Зеркала    
    Interactions{1} = [1 610 2008 80 80];
    Interactions{2} = [1 836 2008 80 80];
    Interactions{3} = [1 836 1732 80 80];
    Interactions{4} = [1 314 1732 80 80];
    Interactions{5} = [1 314 1314 80 80];
    Interactions{6} = [1 769 1314 80 80];
    Interactions{7} = [1 769 1189 80 80];
    Interactions{8} = [1 455 1189 80 80];
    Interactions{9} = [1 455 1049 80 80];
    Interactions{10} = [1 1469 1049 80 80];
    Interactions{11} = [1 1469 1242 80 80];
    Interactions{12} = [1 1361 1242 80 80];
    Interactions{13} = [1 1361 1128 80 80];
    Interactions{14} = [1 1238 1128 80 80];
    Interactions{15} = [1 1238 1483 80 80];
    Interactions{16} = [1 1361 1396 80 80];
    Interactions{17} = [1 1479 1396 80 80];
    Interactions{18} = [1 1126 1396 80 80];
    Interactions{19} = [1 1126 1190 80 80];
    %Двери
    %Дверь из холодоса
    Interactions{20} = [2 132 527 58 95];
    %Дверь из комнаты управления
    Interactions{21} = [2 2037 382 59 80];
    %Дверь из реактора
    Interactions{22} = [2 3574 285 59 82];
    %Дверь из лазеров
    Interactions{23} = [2 394 2209 58 104];
    %Дверь из комнаты с дверьми
    Interactions{24} = [2 83 2776 59 76];
    %Дверь из комнаты с прожектором
    Interactions{25} = [2 1222 225 59 93];
    %Дверь в холодильник
    Interactions{26} = [2 4032 1168 58 81];
    %Дверь в дверную комнату
    Interactions{27} = [2 3648 1612 57 100];
    %Дверь в реактор
    Interactions{28} = [2 2881 1451 59 99];
    %Дверь в лазеры
    Interactions{29} = [2 3001 1974 56 80];
    %Дверь в комнату управления
    Interactions{30} = [2 2012 1585 58 96];
    %Бокс рикардо шапки
    Interactions{31} = [9 1188 389 125 125];
    %Noname двери
    %Верхний ряд (24)
    Interactions{32} = [3 239 2776 59 70];
    Interactions{33} = [3 395 2776 59 70];
    Interactions{34} = [3 551 2776 59 70];
    Interactions{35} = [3 707 2776 59 70];
    Interactions{36} = [3 863 2776 59 70];
    Interactions{37} = [3 1019 2776 59 70];
    Interactions{38} = [3 1175 2776 59 70];
    Interactions{39} = [3 1331 2776 59 70];
    Interactions{40} = [3 1487 2776 59 70];
    Interactions{41} = [3 1643 2776 59 70];
    Interactions{42} = [3 1799 2776 59 70];
    Interactions{43} = [3 1954 2776 59 70];
    Interactions{44} = [3 2110 2776 59 70];
    Interactions{45} = [3 2266 2776 59 70];
    Interactions{46} = [3 2422 2776 59 70];
    Interactions{47} = [3 2578 2776 59 70];
    Interactions{48} = [3 2734 2776 59 70];
    Interactions{49} = [3 2890 2776 59 70];
    Interactions{50} = [3 3046 2776 59 70];
    Interactions{51} = [3 3201 2776 59 70];
    Interactions{52} = [3 3358 2776 59 70];
    Interactions{53} = [3 3514 2776 59 70];
    Interactions{54} = [3 3671 2776 59 70];
    Interactions{55} = [3 3825 2776 59 70];
    Interactions{56} = [3 3981 2776 59 70];
    Interactions{57} = [3 4100 2840 79 38];
    %Нижний ряд
    Interactions{58} = [3 162 2870 59 79];
    Interactions{59} = [3 318 2870 59 79];
    Interactions{60} = [3 474 2870 59 79];
    Interactions{61} = [3 630 2870 59 79];
    Interactions{62} = [3 786 2870 59 79];
    Interactions{63} = [3 942 2870 59 79];
    Interactions{64} = [3 1098 2870 59 79];
    Interactions{65} = [3 1254 2870 59 79];
    Interactions{66} = [3 1410 2870 59 79];
    Interactions{67} = [3 1566 2870 59 79];
    Interactions{68} = [3 1722 2870 59 79];
    Interactions{69} = [3 1878 2870 59 79];
    Interactions{70} = [3 2033 2870 59 79];
    Interactions{71} = [3 2189 2870 59 79];
    Interactions{72} = [3 2345 2870 59 79];
    Interactions{73} = [3 2501 2870 59 79];
    Interactions{74} = [3 2657 2870 59 79];
    Interactions{75} = [3 2813 2870 59 79];
    Interactions{76} = [3 2969 2870 59 79];
    Interactions{77} = [3 3125 2870 59 79];
    Interactions{78} = [3 3281 2870 59 79];
    Interactions{79} = [3 3437 2870 59 79];
    Interactions{80} = [3 3593 2870 59 79];
    Interactions{81} = [2 3749 2870 59 79]; % Нужная дверь
    Interactions{82} = [3 3908 2870 59 79];
    Interactions{83} = [3 4060 2870 59 79];
    
    Interactions{84} = [0 1232 1490 300 300];
    %Камера в холодосе
    Interactions{85} = [4 30 124 522 522];
    %Камера в комнате с прожектором
    Interactions{86} = [4 823 140 667 543];
    %Камера в комнате управления
    Interactions{87} = [4 1899 279 905 448];
    %Камера в реакторе
    Interactions{88} = [4 3484 174 558 647];
    %Камеры в лазерах (по пути прохождения)

    Interactions{89} = [4 259 1527 757 825];
    Interactions{90} = [4 259 909 706 618];
    Interactions{91} = [4 965 909 661 743];
    Interactions{92} = [4 1032 1652 591 654];
    %Взаимодействие с прожектором
    Interactions{93} = [8 987 374 131 187];
    %Холодос - урановые стержни
    Interactions{94} = [6 359-14 201 105+14 45];
    %Реактор заложить уран
    Interactions{95} = [7 3992-80 305 53 81];
    %Звезда
    Interactions{96} = [5 1196 2011 32 45];
    Interactions{97} = [5 1277 2059 32 45];
    Interactions{98} = [5 1241 2130 32 45];
    Interactions{99} = [5 1150 2131 32 45];
    Interactions{100} = [5 1120 2059 32 45];



    %Портал
    Interactions{101} = [11 1415 2048 139 120];
    %Осьминожка
    Interactions{102} = [10 2466 484 133 109];
end