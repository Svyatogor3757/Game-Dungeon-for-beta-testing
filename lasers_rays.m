function [xinit,yinit,mirrors, is_open] = lasers_rays(lasers_rotate0,lasers, xinit0,yinit0,mirrors0)
offset = [20 20];
xinit = xinit0;
yinit = yinit0;
mirrors = mirrors0;
lasers_rotate = lasers_rotate0 + 1; %Это связано с тем, что отсчет с нуля
is_open = 0;
% первый столб ############################################################
    switch(lasers_rotate(1))
        case 1
            if mirrors(1)
                %начальная тока, конечная точка
                xinit = [xinit lasers{1}.object.XData(1)+offset(1) lasers{2}.object.XData(1)+offset(1)]; 
                yinit = [yinit lasers{1}.object.YData(1)+offset(2) lasers{2}.object.YData(1)+offset(2)];
                mirrors(2) = 1;
            else
               mirrors(2) = 0; 
            end
        case 4
            if mirrors(1) %побочная ветка
                xinit = [xinit lasers{1}.object.XData(1)+offset(1) 280];
                yinit = [yinit lasers{1}.object.YData(1)+offset(2) lasers{2}.object.YData(1)+offset(2)]; 
                mirrors(2) = 2;
            else
               mirrors(2) = 0; 
            end
        otherwise
            mirrors(2) = 0;
    end
% второй столб ############################################################   
    switch(lasers_rotate(2))
        case 4
            if mirrors(2) == 1
                xinit = [xinit lasers{2}.object.XData(1)+offset(1) lasers{3}.object.XData(1)+offset(1)];
                yinit = [yinit lasers{2}.object.YData(1)+offset(2) lasers{3}.object.YData(1)+offset(2)];
                mirrors(3) = 1;
            else
                mirrors(3) = 0; 
            end
        case 3
             if mirrors(2) == 1
                xinit = [xinit lasers{2}.object.XData(1)+offset(1) lasers{2}.object.XData(1)+offset(1)];
                yinit = [yinit lasers{2}.object.YData(1)+offset(2) 2172]; 
                mirrors(3) = 2;
             else
                mirrors(3) = 0; 
            end
        otherwise
            mirrors(3) = 0;
    end
% третий столб ############################################################   
    switch(lasers_rotate(3))
        case 3
            if mirrors(3) == 1
                xinit = [xinit lasers{3}.object.XData(1)+offset(1) lasers{4}.object.XData(1)+offset(1)]; 
                yinit = [yinit lasers{3}.object.YData(1)+offset(2) lasers{4}.object.YData(1)+offset(2)]; 
                mirrors(4) = 1;
            else
                mirrors(4) = 0; 
            end
        case 2
             if mirrors(3) == 1
                xinit = [xinit lasers{3}.object.XData(1)+offset(1) 974]; 
                yinit = [yinit lasers{3}.object.YData(1)+offset(2) lasers{3}.object.YData(1)+offset(2)];
                mirrors(4) = 2;
             else
                mirrors(4) = 0; 
            end
        otherwise
            mirrors(4) = 0;
    end
% четвертый столб #########################################################  
    switch(lasers_rotate(4))
        case 1
            if mirrors(4) == 1
                %начальная тока, конечная точка
                xinit = [xinit lasers{4}.object.XData(1)+offset(1) lasers{5}.object.XData(1)+offset(1)]; 
                yinit = [yinit lasers{4}.object.YData(1)+offset(2) lasers{5}.object.YData(1)+offset(2)];
                mirrors(5) = 1;
            else
                mirrors(5) = 0; 
            end
        case 2
             if mirrors(4) == 1
                xinit = [xinit lasers{4}.object.XData(1)+offset(1) lasers{4}.object.XData(1)+offset(1)];
                yinit = [yinit lasers{4}.object.YData(1)+offset(2) lasers{4}.object.YData(1)+offset(2) + 410];
                mirrors(5) = 2;
             else
                mirrors(5) = 0; 
            end
        otherwise
            mirrors(5) = 0;
    end
% пятый столб ############################################################   
    switch(lasers_rotate(5))
        case 2
            if mirrors(5) == 1
                xinit = [xinit lasers{5}.object.XData(1)+offset(1) lasers{6}.object.XData(1)+offset(1)];
                yinit = [yinit lasers{5}.object.YData(1)+offset(2) lasers{6}.object.YData(1)+offset(2)];
                mirrors(6) = 1;
            else
                mirrors(6) = 0; 
            end
        case 3
             if mirrors(5) == 1
                xinit = [xinit lasers{5}.object.XData(1)+offset(1) 280];
                yinit = [yinit lasers{5}.object.YData(1)+offset(2) lasers{5}.object.YData(1)+offset(2)]; 
                mirrors(6) = 2;
             else
                mirrors(6) = 0; 
            end
        otherwise
            mirrors(6) = 0;
    end
% шестой столб ############################################################   
    switch(lasers_rotate(6))
        case 4
            if mirrors(6) == 1
                xinit = [xinit lasers{6}.object.XData(1)+offset(1) lasers{7}.object.XData(1)+offset(1)];
                yinit = [yinit lasers{6}.object.YData(1)+offset(2) lasers{7}.object.YData(1)+offset(2)];
                mirrors(7) = 1;
            else
                mirrors(7) = 0; 
            end
        case 3
             if mirrors(6) == 1
                xinit = [xinit lasers{6}.object.XData(1)+offset(1) lasers{6}.object.XData(1)+offset(1)];
                yinit = [yinit lasers{6}.object.YData(1)+offset(2) 1420]; 
                mirrors(7) = 2;
             else
                mirrors(7) = 0; 
            end
        otherwise
            mirrors(7) = 0;
    end
% седьмой столб ############################################################   
    ir=7;
    switch(lasers_rotate(ir))
        case 3
            if mirrors(ir) == 1
                xinit = [xinit lasers{ir}.object.XData(1)+offset(1) lasers{ir+1}.object.XData(1)+offset(1)];
                yinit = [yinit lasers{ir}.object.YData(1)+offset(2) lasers{ir+1}.object.YData(1)+offset(2)];
                mirrors(ir+1) = 1;
            else
                mirrors(ir+1) = 0; 
            end
        case 2
             if mirrors(ir) == 1
                xinit = [xinit lasers{ir}.object.XData(1)+offset(1) 952];
                yinit = [yinit lasers{ir}.object.YData(1)+offset(2) lasers{ir}.object.YData(1)+offset(2)]; 
                mirrors(ir+1) = 2;
             else
                mirrors(ir+1) = 0; 
            end
        otherwise
            mirrors(ir+1) = 0;
    end    
% восьмой столб ############################################################   
    ir=8;
    switch(lasers_rotate(ir))
        case 1
            if mirrors(ir) == 1
                xinit = [xinit lasers{ir}.object.XData(1)+offset(1) lasers{ir+1}.object.XData(1)+offset(1)];
                yinit = [yinit lasers{ir}.object.YData(1)+offset(2) lasers{ir+1}.object.YData(1)+offset(2)];
                mirrors(ir+1) = 1;
            else
                mirrors(ir+1) = 0; 
            end
        case 2
             if mirrors(ir) == 1
                xinit = [xinit lasers{ir}.object.XData(1)+offset(1) lasers{ir}.object.XData(1)+offset(1)];
                yinit = [yinit lasers{ir}.object.YData(1)+offset(2) 1420]; 
                mirrors(ir+1) = 2;
             else
                mirrors(ir+1) = 0; 
            end
        otherwise
            mirrors(ir+1) = 0;
    end
% девятый столб ############################################################   
    ir=9;
    switch(lasers_rotate(ir))
        case 2
            if mirrors(ir) == 1
                xinit = [xinit lasers{ir}.object.XData(1)+offset(1) lasers{ir+1}.object.XData(1)+offset(1)];
                yinit = [yinit lasers{ir}.object.YData(1)+offset(2) lasers{ir+1}.object.YData(1)+offset(2)];
                mirrors(ir+1) = 1;
            else
                mirrors(ir+1) = 0; 
            end
        case 3
             if mirrors(ir) == 1
                xinit = [xinit lasers{ir}.object.XData(1)+offset(1) 280];
                yinit = [yinit lasers{ir}.object.YData(1)+offset(2) lasers{ir}.object.YData(1)+offset(2)]; 
                mirrors(ir+1) = 2;
             else
                mirrors(ir+1) = 0; 
            end
        otherwise
            mirrors(ir+1) = 0;
    end
% десятый столб ############################################################   
    ir=10;
    switch(lasers_rotate(ir))
        case 3
            if mirrors(ir) == 1
                xinit = [xinit lasers{ir}.object.XData(1)+offset(1) lasers{ir+1}.object.XData(1)+offset(1)];
                yinit = [yinit lasers{ir}.object.YData(1)+offset(2) lasers{ir+1}.object.YData(1)+offset(2)];
                mirrors(ir+1) = 1;
            else
                mirrors(ir+1) = 0; 
            end
        case 4
             if mirrors(ir) == 1
                xinit = [xinit lasers{ir}.object.XData(1)+offset(1) lasers{ir}.object.XData(1)+offset(1)];
                yinit = [yinit lasers{ir}.object.YData(1)+offset(2) 990]; 
                mirrors(ir+1) = 2;
             else
                mirrors(ir+1) = 0; 
            end
        otherwise
            mirrors(ir+1) = 0;
    end
% 11-тый столб ############################################################   
    ir=11;
    switch(lasers_rotate(ir))
        case 4
            if mirrors(ir) == 1
                xinit = [xinit lasers{ir}.object.XData(1)+offset(1) lasers{ir+1}.object.XData(1)+offset(1)];
                yinit = [yinit lasers{ir}.object.YData(1)+offset(2) lasers{ir+1}.object.YData(1)+offset(2)];
                mirrors(ir+1) = 1;
            else
                mirrors(ir+1) = 0; 
            end
        case 1
             if mirrors(ir) == 1
                xinit = [xinit lasers{ir}.object.XData(1)+offset(1) 1605];
                yinit = [yinit lasers{ir}.object.YData(1)+offset(2) lasers{ir}.object.YData(1)+offset(2)]; 
                mirrors(ir+1) = 2;
             else
                mirrors(ir+1) = 0; 
            end
        otherwise
            mirrors(ir+1) = 0;
    end
% 12-тый столб ############################################################   
    ir=12;
    switch(lasers_rotate(ir))
        case 1
            if mirrors(ir) == 1
                xinit = [xinit lasers{ir}.object.XData(1)+offset(1) lasers{ir+1}.object.XData(1)+offset(1)];
                yinit = [yinit lasers{ir}.object.YData(1)+offset(2) lasers{ir+1}.object.YData(1)+offset(2)];
                mirrors(ir+1) = 1;
                mirrors(ir+4) = 0;
            else
                mirrors(ir+1) = 0;
                mirrors(ir+4) = 0;
            end
        case 2
             if mirrors(ir) == 1
                xinit = [xinit lasers{ir}.object.XData(1)+offset(1) lasers{ir+4}.object.XData(1)+offset(1)];
                yinit = [yinit lasers{ir}.object.YData(1)+offset(2) lasers{ir+4}.object.YData(1)+offset(2)]; 
                mirrors(ir+4) = 1;
                mirrors(ir+1) = 0;
             else
                mirrors(ir+4) = 0;
                mirrors(ir+1) = 0;
            end
        otherwise
            mirrors(ir+1) = 0;
            mirrors(ir+4) = 0;
    end
% 13-тый столб, 1 вариант от 12 столба ############################################################  
    ir=13;
    switch(lasers_rotate(ir))
        case 3
            if mirrors(ir) == 1
                xinit = [xinit lasers{ir}.object.XData(1)+offset(1) lasers{ir+1}.object.XData(1)+offset(1)];
                yinit = [yinit lasers{ir}.object.YData(1)+offset(2) lasers{ir+1}.object.YData(1)+offset(2)];
                mirrors(ir+1) = 1;
            else
                mirrors(ir+1) = 0; 
            end
        case 2
             if mirrors(ir) == 1
                xinit = [xinit lasers{ir}.object.XData(1)+offset(1) 1605];
                yinit = [yinit lasers{ir}.object.YData(1)+offset(2) lasers{ir}.object.YData(1)+offset(2)]; 
                mirrors(ir+1) = 2;
             else
                mirrors(ir+1) = 0; 
            end
        otherwise
            mirrors(ir+1) = 0;
    end
% 14-тый столб, 1 вариант от 12 столба ############################################################  
    ir=14;
    switch(lasers_rotate(ir))
        case 2
            if mirrors(ir) == 1
                xinit = [xinit lasers{ir}.object.XData(1)+offset(1) lasers{ir+1}.object.XData(1)+offset(1)];
                yinit = [yinit lasers{ir}.object.YData(1)+offset(2) lasers{ir+1}.object.YData(1)+offset(1)-5];
                mirrors(ir+1) = 1;
            else
                mirrors(ir+1) = 0; 
            end
        case 1
             if mirrors(ir) == 1
                xinit = [xinit lasers{ir}.object.XData(1)+offset(1) lasers{ir}.object.XData(1)+offset(1)];
                yinit = [yinit lasers{ir}.object.YData(1)+offset(2) 990]; 
                mirrors(ir+1) = 2;
             else
                mirrors(ir+1) = 0; 
            end
        otherwise
            mirrors(ir+1) = 0;
    end
% 15-тый столб, 1 вариант от 12 столба ############################################################  
    ir=15;
    switch(lasers_rotate(ir))
        case 1
            if mirrors(ir) == 1
                xinit = [xinit lasers{ir}.object.XData(1)+offset(1) 1493+5];
                yinit = [yinit lasers{ir}.object.YData(1)+offset(1) lasers{ir}.object.YData(1)+offset(1)];
                is_open = 1;
            end
        case 4
             if mirrors(ir) == 1
                xinit = [xinit lasers{ir}.object.XData(1)+offset(1) 1094];
                yinit = [yinit lasers{ir}.object.YData(1)+offset(1) lasers{ir}.object.YData(1)+offset(1)]; 
                is_open = 0;
            end
        otherwise
            mirrors(ir+1) = 0;
            is_open = 0;
    end
% 16-тый столб, 2 вариант от 12 столба ############################################################  
    ir=16;
    switch(lasers_rotate(ir))
        case 1
            if mirrors(ir) == 1 && mirrors(ir-3) == 0
                xinit = [xinit lasers{ir}.object.XData(1)+offset(1) lasers{ir+1}.object.XData(1)+offset(1)];
                yinit = [yinit lasers{ir}.object.YData(1)+offset(2) lasers{ir+1}.object.YData(1)+offset(2)];
                mirrors(ir+1) = 1;
                mirrors(ir+2) = 0;
            else
                mirrors(ir+1) = 0;
                mirrors(ir+2) = 0;
            end
        case 4
             if mirrors(ir) == 1 && mirrors(ir-3) == 0
                xinit = [xinit lasers{ir}.object.XData(1)+offset(1) lasers{ir+2}.object.XData(1)+offset(1)];
                yinit = [yinit lasers{ir}.object.YData(1)+offset(2) lasers{ir+2}.object.YData(1)+offset(2)]; 
                mirrors(ir+2) = 1;
                mirrors(ir+1) = 0;
             else
                mirrors(ir+2) = 0;
                mirrors(ir+1) = 0;
            end
        otherwise
            mirrors(ir+1) = 0;
            mirrors(ir+2) = 0;
    end
% 17-тый столб, 2 вариант от 12 столба ############################################################  
ir=17;
    switch(lasers_rotate(ir))
        case 4
            if mirrors(ir) == 1
                xinit = [xinit lasers{ir}.object.XData(1)+offset(1) lasers{ir}.object.XData(1)+offset(1)];
                yinit = [yinit lasers{ir}.object.YData(1)+offset(2) lasers{11}.object.YData(1)+offset(1)];
            end
        case 3
             if mirrors(ir) == 1
                xinit = [xinit lasers{ir}.object.XData(1)+offset(1) lasers{ir}.object.XData(1)+offset(1)];
                yinit = [yinit lasers{ir}.object.YData(1)+offset(2) 1598]; 
             end
    end
% 18-тый столб, 3 вариант от 12 столба ############################################################  
    ir=18;
    switch(lasers_rotate(ir))
        case 1
            if mirrors(ir) == 1 
                xinit = [xinit lasers{ir}.object.XData(1)+offset(1) lasers{ir+1}.object.XData(1)+offset(1)];
                yinit = [yinit lasers{ir}.object.YData(1)+offset(2) lasers{ir+1}.object.YData(1)+offset(2)];
                mirrors(ir+1) = 1;
            else
                mirrors(ir+1) = 0; 
            end
        case 2
             if mirrors(ir) == 1
                xinit = [xinit lasers{ir}.object.XData(1)+offset(1) lasers{ir}.object.XData(1)+offset(1)];
                yinit = [yinit lasers{ir}.object.YData(1)+offset(2) 1598]; 
                mirrors(ir+1) = 2;
             else
                mirrors(ir+1) = 0; 
            end
        otherwise
            mirrors(ir+1) = 0;
    end
% 19-тый столб, 3 вариант от 12 столба ############################################################  
    ir=19;
    switch(lasers_rotate(ir))
        case 2
            if mirrors(ir) == 1
                xinit = [xinit lasers{ir}.object.XData(1)+offset(1) 1605];
                yinit = [yinit lasers{ir}.object.YData(1)+offset(2) lasers{ir}.object.YData(1)+offset(2)];

            end
        case 3
             if mirrors(ir) == 1
                xinit = [xinit lasers{ir}.object.XData(1)+offset(1) 1094];
                yinit = [yinit lasers{ir}.object.YData(1)+offset(2) lasers{ir}.object.YData(1)+offset(2)]; 

             end
    end
end