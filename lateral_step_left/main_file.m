%%%%%%%%%%%%%%%%%%   PASO LATERAL IZQUIERDO    %%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear all
close all
% initial conditions of the robot
motors0 = [0; 40; 3695; 9537; -5807; -334; 18810;-2000; 1; 8801; 0; 40; -3730; -9537; 5807; 425; -18800; 2000; 0; -8800; 418; 60; 60]; %initial pose arms down

conversion = pi/180/209;
q0 = motors0*conversion;

q0_right_leg = q0(1:6);
q0_right_arm = q0(7:10);
q0_left_leg = q0(11:16);
q0_left_arm = q0(17:20);
q0_waist = q0(21);
q0_head = motors0(22);
q0_hand = 0;

% time conditions
Ts = 2e-3;          % sampling time;
T=4;
num_points=T/Ts;

% move legs
[q_right_leg, q_left_leg] = move_legs (Ts, T, q0_right_leg, q0_left_leg);

% move arms
q_left_arm=doesnt_move (Ts,T,q0_left_arm);
q_right_arm=doesnt_move (Ts,T,q0_right_arm);

show_q (Ts, T, q_right_leg, q_left_leg, q_right_arm, q_left_arm);

% move waist
q_waist = q0_waist*ones(1, num_points);

% move head
head_movement = 'tilt';
q_head = q0_head*ones(1, num_points); 

% move hands
hand_movement = 'rotate';
hand_selection = 'right';
q_hand = zeros(1, num_points);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Calculate velocity
q_right_leg_dot=velocity(Ts,q_right_leg);
q_left_leg_dot=velocity(Ts,q_left_leg);
q_right_arm_dot=velocity(Ts,q_right_arm);
q_left_arm_dot=velocity(Ts,q_left_arm);
q_waist_dot=velocity(Ts,q_waist);

xlswrite('q_right_leg_dot',q_right_leg_dot)  
xlswrite('q_left_leg_dot',q_left_leg_dot)
xlswrite('q_right_arm_dot',q_right_arm_dot)
xlswrite('q_left_arm_dot',q_left_arm_dot)
xlswrite('q_waist_dot',q_waist_dot)

%Write files
%Write for robot
write_to_file (Ts, q_right_leg, q_left_leg, q_right_arm, q_left_arm, q_waist, q_head, head_movement, q_hand, hand_movement, hand_selection, 'lateralI.csv')

%Write for simulator
q = [q_right_leg; q_right_arm; q_left_leg; q_left_arm; q_waist;q_head;q_hand];
q=q';
xlswrite('lateralI.xls',q)
