%Прогресс [Нужный прогресс, Текущий прогресс]
%Доп Прогресс2 [Прогресс который нужно проиграть, Текущий прогресс]
%Если текущий прогресс с основным не стыкуется, то дополнительный обнуляем%
%Доп прогресс выполненный [] %выполненные доп события



%% Функция перенаправляет диалог на следующую ветвь
function progress = next_dialog(progress)
    switch(progress(2))
        
        case 1
            progress(2) = 2;    
        case 2
            progress(2) = 7;  
        case 3
            progress(2) = 8;
        case 4
            progress(2) = 9;
        case 5
            progress(2) = 10;
        case 6
            progress(2) = 11;
        case 13
            progress(2) = 7;
        
       %Повторы, если по 100 раз спрашиваешь
        case 7
            progress(2) = 7; 
        case 8
            progress(2) = 8; 
        case 9
            progress(2) = 9; 
        case 10
            progress(2) = 10;
        case 11
            progress(2) = 11; 
    end

end
 %%












        %fileID = fopen('Data/Dialogs/d3_Ru.txt','r');
        %A = textscan(fileID,'%q','Delimiter',"\r\n");
        %ret = A{1};
        %fclose(fileID);
        %dialogs = [];
        %findsep=[0; find(A{1}==";")];
        %for i=2:length(findsep)
        %   dialogs{i-1} = ret(findsep(i-1)+1:findsep(i)-1);
        %end