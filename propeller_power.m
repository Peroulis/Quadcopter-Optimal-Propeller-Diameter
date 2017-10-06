%{
----------------------BEST PROPELLER FOR A QUADCOPTER--------------------
---------------------------PEROULIS KONSTANTINOS--------------------------
---------------email: peroulis.constantinos@outlook.com-------------------
--------------------------------------------------------------------------
%}


clear
clc
%----------------------------SCRIPT VARIABLES------------------------------
turn=1;
end_turn = 0;   % end turn (terminate the program) is false
ans_in_plot_hold = 2;
percentage(1)=0;
bat_percentage(1)=0;
minus(1)=0;
%---------------------------START LOOP-------------------------------------
while end_turn==0; %while end turn (terminate the program) is false
%-------------------------INPUT QUESTIONS----------------------------------
%-------------------------------INPUT----------------------------------
%    battery_w=0.484;    %prototype battery weight
%    Ah=4.5; %prototype battery Ah
%    additional_w = 0.3562 ;  
%    frame_w = 0.34; 
%    w1 = frame_w + additional_w ;  %prototype frame weight(0.34gr) + additional (0.3562) = 0.6962
%    S=4;
%    motor_w = 0.08; % the motor weight of the prototype
%----------------------------END INPUT-------------------------------------
    w1=input('Input frame weight (kg)= ');
    battery_w = input('battery weight (kg)= ');
    input_ans_frame_motor = input ('Motor weight is additional? \n 1 FOR YES \n 2 FOR NO \n ');    
    motor_w = 0 ;
    if input_ans_frame_motor == 1 ;
         motor_w = input('motor weight (kg)= ');
    end
    Ah = input('Ah = ');
    S = input('Battery cells = ');
    additional_weight = input ('Additional weight (kg)(0 for no additional weight) = ');
%---------------------END INPUT QUESTIONS----------------------------------
%-------------------------OPERATIONS---------------------------------------
V=S*3.7; %Volt of the battery
if input_ans_frame_motor == 1 
    w = (w1 + battery_w)/4 + motor_w + additional_weight/4; % weight = (frame + battery)/4 + motor weight
else
    w = (w1 + battery_w)/4 + additional_weight/4;
end
w = w * 9.82; % total weight * g
r = 1.225;
d = 0.04; %initial prop diameter
power = []; %power table
profile_drag = []; % profile drag power table
total_power = []; % total power table
i = 1;    %first row of all tables
a = [];   %diameter table
FM = 0.7;   %experimental                               IT CAN BE 0.7 - 1.0
datasave = [];    %for the output
ans_in_res = input('Do you want to see the results?\n 1 for YES\n 2 for NO\n');
w1 + battery_w + (motor_w*4) + additional_weight %total weight output
for d=0.04:0.01:0.3 % for diameters 0.04 to 0.3 meters and step 0.01 meter
    a(i)=d; %put diameter to diameter table
    power(i)=sqrt((w^3)/(2*pi*(a(i)^2)*r/4)); %put PDE power into power table 
    profile_drag(i) = power(i)*(1-FM)/FM;   %put profile drag power into profile drag table
    total_power(i) = (power(i)+profile_drag(i)); % add PDE power and proifle drag power and put it into total power table
    autonomy(i) = 60*Ah*V*0.6/(4*total_power(i)); %put battery autonomy for i diameter into autonomy table
    if d>0.04 % diameter must be greater than the initial diameter to avoid errors in i-1 (it doesn't exist when i=1)
        percentage(i) = (abs((total_power(i)-total_power(i-1)))/total_power(i-1))*100;
        %variation percentage of i total power from i-1 total power
        bat_percentage(i)= (abs((autonomy(i)-autonomy(i-1)))/autonomy(i-1))*100;
        %variation percentage of i battery autonomy from i-1 battery
        %autonomy
        minus(i)=bat_percentage(i)-percentage(i);
        %varietion of total power percentage from battery autonomy
        %percentage (it's a percentage)
    end
    if ans_in_res == 1 % if the user wants to see the results
        datasave=[datasave; a(i) power(i) profile_drag(i) total_power(i) autonomy(i) percentage(i) bat_percentage(i) minus(i)]; 
    end  % save output for the i results
    i=i+1; 
end

if ans_in_res == 1 % if the user wants to see the results
    fprintf(' Diameter  PDT   profile_drag  TOTAL_POWER Autonomy(min)\n') %output heading
disp(datasave) %display output
end

databest=[]; %making a table IF autonomy is more than 15 min
for i=1:27    %30-3
    if autonomy(i)> 15 %min
        databest=[databest; a(i) total_power(i) autonomy(i) percentage(i) bat_percentage(i) minus(i)];
    end %save output
end
fprintf(' Diameter Total_power Autonomy(min)\n') % best output heading
disp(databest) % best output display
%---------------------------------PLOTS------------------------------------
    
 subplot(3,1,1)  %making 3 plots in a column
%-----------PLOT 1---------------------
    if turn == 1 || ans_in_plot_hold == 2 || ans_in_plot_hold == 3 
        % if this is the first turn or if the user doesnt want to hold a diagram 
        % of 311 plot at the previous turn or he wants ALL the diagrammes 
        plot(a,power,'b-') %PDE POWER
        hold on                                             % hold 3,1,1 plot
        plot(a,profile_drag,'r-') %profile drag power plot
        plot(a,total_power,'g-')  %total power plot
        xlabel('diameter')
        ylabel('power')
        title('Theory of power disk')
        legend('tpe','profile drag','total power')
        hold off                                        % hold off 3,1,1 plot
    end
    %-----------PLOT 2---------------------
    subplot(3,1,2) 
    plot(a,percentage) %power percentage plot
    hold on
    xlabel('diameter')
    ylabel('%')
    plot(a,bat_percentage,'r-') % battery autonomy percentage plot
%    if turn == 1 % the question is in the first turn
%     ans_in_plot_312 = input ('Do you want to hold this plot? \n 1 for YES \n 2 for NO \n');
%    if ans_in_plot_312 == 2 % dont hold
%       hold off                                        % hold off 3,1,2 plot
%  end
%  end
   hold off
%-----------PLOT 3---------------------
    subplot(3,1,3)
    plot(a,minus) %plot of varietion of total power percentage from battery autonomy                                  
%    if turn == 1 % question is set in the first turn
      hold on                                         % hold 3,1,3 plot
      xlabel('diameter')
      ylabel('%')
%      ans_in_plot_313 = input ('Do you want to hold this plot? \n 1 for YES \n 2 for NO \n');
%      if ans_in_plot_313 == 2 % dont hold
         hold off                                        % hold off 3,1,3 plot
%      end
%    end
    %----------------------------END PLOTS---------------------------------
    if turn == 1 % ask if this is the first turn
        ans_in_plot_hold=input('Do you want to hold a diagram? \n 1 for YES \n 2 for NO \n 3 HOLD ALL \n');
    end     %end of the question
    if ans_in_plot_hold == 1 %if the user wants a diagram 
        if turn == 1 % ask if this is the first turn
            ans_in_plot_hold_2 = input('What diagram do you want? \n 1 for total power\n 2 for profile drag\n 3 for PDE\n 0 for end\n');
        end     %end of the question    
        subplot(3,1,1)
        if ans_in_plot_hold_2==1 % the user wants 3,1,1 total power
         plot(a,total_power)
         hold on
         xlabel('diameter')
         ylabel('power')
         legend('total power')
        elseif ans_in_plot_hold_2==2 % the user wants 3,1,1 profile drag
         plot(a,profile_drag)
         hold on
         xlabel('diameter')
         ylabel('power')
         title('Profile drag')
        elseif ans_in_plot_hold_2==3 % the user wants 3,1,1 PDE power
         plot(a,power)
         hold on
         xlabel('diameter')
         ylabel('power')
         title('PDT')
        elseif ans_in_plot_hold_2==0
         end_turn=1; % end  turn is true (terminate)
        end
    end
if end_turn == 0 % end turn is false (continue)
    end_turn=input('do you want to proceed?\n 1 yes \n 2 No\n');
    if end_turn == 1 %the user wants to proceed
        end_turn = 0; %false (continue)
    else
        end_turn = 1; % true (terminate)
    end
end
turn = turn + 1;
end