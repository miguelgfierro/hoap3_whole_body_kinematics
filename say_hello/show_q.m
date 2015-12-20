%Para visualizar
function show_q (Ts, T, q_right_leg_rad, q_left_leg_rad, q_right_arm_rad, q_left_arm_rad)
time=0:Ts:T-Ts;     %time vector
q_right_m = [-91; -31; -71; -1; -61; -25];
q_right_M = [31; 21; 82; 130; 61; 25];
q_left_m = [-31; -21; -82; -130; -61; -25];
q_left_M = [91; 31; 71; 1; 61; 25];
range_q_right = [q_right_m, q_right_M];         %links positions range
range_q_left = [q_left_m, q_left_M];            %links positions range

q_right_leg = 180/pi.*q_right_leg_rad;
q_left_leg = 180/pi.*q_left_leg_rad;
q_right_arm = 180/pi.*q_right_arm_rad;
q_left_arm = 180/pi.*q_left_arm_rad;

%right leg links positions plot
figure('Name','Simulation right leg links positions','NumberTitle','off')
for ii=1:6
    subplot(2,3,ii);
    hold on
    plot(time,q_right_leg(ii,:),'b');
    plot(time,range_q_right(ii,:)'*ones(1,length(time)),'r')
    xlim([0 (T-Ts)]);
    [q_min, q_max] = evaulate_y_limits(q_right_leg(ii,:), range_q_right(ii,:));
    %ylim([[q_min, q_max]]);
    title(['\theta_',num2str(ii)])
    if min(q_right_leg(ii,:))<range_q_right(ii,1) || max(q_right_leg(ii,:))>range_q_right(ii,2)
        title(['OUT OF RANGE!!!: \theta_',num2str(ii)]);
    end
    xlabel('[s]')
    ylabel('[º]')
end

%left leg links positions plot
figure('Name','Simulation left leg links positions','NumberTitle','off')
for ii=1:6
    subplot(2,3,ii);
    hold on
    plot(time,q_left_leg(ii,:),'b');
    plot(time,range_q_left(ii,:)'*ones(1,length(time)),'r')
    xlim([0 (T-Ts)]);
    [q_min, q_max] = evaulate_y_limits(q_left_leg(ii,:), range_q_left(ii,:));
    %ylim([[q_min, q_max]]);
    title(['\theta_',num2str(ii)])
    if min(q_left_leg(ii,:))<range_q_left(ii,1) || max(q_left_leg(ii,:))>range_q_left(ii,2)
        title(['OUT OF RANGE!!!: \theta_',num2str(ii)]);
    end
    xlabel('[s]')
    ylabel('[º]')
end



figure('Name','Simulation right arm links positions','NumberTitle','off')
for ii=1:4
    subplot(2,2,ii);
    hold on
    plot(time,q_right_arm(ii,:),'b');
    xlim([0 (T-Ts)]);
    %ylim([min(q_right_arm(ii,:)), max(q_right_arm(ii,:))]);
    title(['\theta_',num2str(ii)])
    xlabel('[s]')
    ylabel('[º]')
end


figure('Name','Simulation left arm links positions','NumberTitle','off')
for ii=1:4
    subplot(2,2,ii);
    hold on
    plot(time,q_left_arm(ii,:),'b');
    xlim([0 (T-Ts)]);
    %ylim([min(q_left_arm(ii,:)), max(q_left_arm(ii,:))]);
    title(['\theta_',num2str(ii)])
    xlabel('[s]')
    ylabel('[º]')
end

%********************
% Support functions *
%********************
function [q_min, q_max] = evaulate_y_limits (q, range)
q_min = min(min(q), range(2));
q_max = max(max(q), range(1));
