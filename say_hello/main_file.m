clc
clear all
close all
% initial conditions of the robot
motors0 = [0; 40; 3695; 9537; -5807; -334; 18810;-2000; 1; 8801; 0; 40; -3730; -9537; 5807; 425; -18800; 2000; 0; -8800; 418; 60; 60];


conversion = pi/180/209;
q0 = motors0*conversion;

q0_right_leg = q0(1:6);
q0_right_arm = q0(7:10);
q0_left_leg = q0(11:16);
q0_left_arm = q0(17:20);
q0_waist = q0(21);
q0_head = 0;
q0_hand = 0;


% time conditions
Ts = 1e-3;          % sampling time;
T = 10;
Tini=1;
Tfin=8;
Tfin2=1;
num_points = T/Ts;


% move arms
% desired final positions for the arms
q1_right_arm = [-6983;-4919;-2052;8798]*conversion;
q2_right_arm = [-6981;-681;3967;8795]*conversion;

q_right_arm1 = interpolate_variable(Ts, Tini, q0_right_arm, q1_right_arm); %right left go to high position
q_right_arm4 = hola_majos (Ts, Tfin, q1_right_arm, q2_right_arm); %say hello
q_right_arm2 = interpolate_variable(Ts, Tfin2, q1_right_arm, q0_right_arm); %right left go to start position

q_right_arm=[q_right_arm1,q_right_arm4,q_right_arm2];
q_right_leg=doesnt_move (Ts,T,q0_right_leg);
q_left_leg=doesnt_move (Ts,T,q0_left_leg);
q_left_arm=doesnt_move (Ts,T,q0_left_arm);

show_q (Ts, T, q_right_leg, q_left_leg, q_right_arm, q_left_arm);

% move waist
q_waist = q0_waist*ones(1, num_points);

% move head
head_movement = 'pan';
q_head0 = zeros(1, num_points/4);
q_head1 = -45*pi/180*ones(1, num_points/4);
q_head2 = 35*pi/180*ones(1, num_points/4);
q_head=[q_head0,q_head1,q_head2,q_head0];

% move hands
hand_movement = 'rotate';
hand_selection = 'right';
q_hand = 60*ones(1, num_points*9/10);
q_hand=[q_hand, zeros(1,num_points*1/10)];

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
write_to_file (Ts, q_right_leg, q_left_leg, q_right_arm, q_left_arm, q_waist, q_head, head_movement, q_hand, hand_movement, hand_selection,'saludo.csv')

%Write for simulator
q = [q_right_leg; q_right_arm; q_left_leg; q_left_arm; q_waist;q_head;q_hand];
q=q';
xlswrite('saludo.xls',q)
