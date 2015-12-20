% inverse kinematics
% inverse kinematics
clc
close all
clear all

% robot dimensions
LEG_LINK1 = 0.039;
LEG_LINK2 = 0.105;
LEG_LINK3 = 0.105;
LEG_LINK4 = 0.040;

% initial conditions of the robot (from m03.csv)
q0_right = [0; 0.0033; 0.3086; 0.7964; -0.4849; -0.0279];          %initial position of the links in the right supporting leg
q0_left = [0; 0.0033; -0.3115; -0.7964; 0.4849; 0.0355];          %initial position of the links in the right supporting leg


%******************
% GAIT GENERATION *
%******************

% gait generation parameters
% time conditions
Ts = 1e-3;          %sampling time;
Tss = 3.5;            %time for the step in single support
Tds = 0.8*Tss;
T = 2*(Tss+Tds)-Tss;        %total time of simulation

% step conditions
L = 0.05;           %step length

%************************************
% double support phase on right leg *
%************************************
alfa = 0;           %desired orientation in degrees
[Rd0_right, Rd0_left] = determine_matrixes_rotation (alfa*pi/180);


% desired position conditions for the right supporting leg
delta_right(1) = LEG_LINK1+0.01;       %waist displacement in x (sagital plane)
delta_right(2) = 0;                     %waist displacement in y (frontal plane height)-> determine how much I elevate the waist
delta_right(3) = 0;                     %waist displacement in z (frontal plane lenght, i.e. direction of the step)

% desired position conditions for the left floating leg
delta_left(1) = -LEG_LINK1-0.01;         %waist displacement in x (sagital plane)
delta_left(2) = 0;                      %waist displacement in y (frontal plane lenght, i.e. opposite direction of the step)
delta_left(3) = 0;                      %waist displacement in z (frontal plane height)-> determine how much I elevate the foot

% trajectory generation
[q_right_ds, q_dot_right_ds, p_right_ds, R_right_ds, q_left_ds, q_dot_left_ds, p_left_ds, R_left_ds] = double_support (Tds, Ts, q0_right, q0_left, delta_right, Rd0_right, delta_left, Rd0_left);

q_right = q_right_ds;
q_left = q_left_ds;
q_dot_right = q_dot_right_ds;
q_dot_left = q_dot_left_ds;


%************************************
% single support phase on left leg *
%************************************
[a, dur] = size (q_right);
q0_right_ss = q_right(:,dur);
q0_left_ss = q_left(:,dur);

% desired position conditions for the left supporting leg
delta_left(1) = -0.01;          %waist displacement in x (sagital plane)
delta_left(2) = 0;            %waist displacement in y (frontal plane height)-> determine how much I elevate the waist
delta_left(3) = 0.01;            %waist displacement in z (frontal plane lenght, i.e. direction of the step)

% desired position conditions for the right floating leg
delta_right(1) = 0;               %leg displacement in x (sagital plane)
delta_right(2) = -L-0.02;              %leg displacement in y (frontal plane lenght, i.e. opposite direction of the step)
delta_right(3) = 0.04;            %leg displacement in z (frontal plane height)-> determine how much I elevate the foot

% desired orientation for the left supporting leg and for the right floating leg
alfa = 0;                        %desired orientation in degrees
[Rd0_left, Rd0_right] = determine_matrixes_rotation (alfa*pi/180);

[q_right_ss, q_dot_right_ss, p_right_ss, R_right_ss, q_left_ss, q_dot_left_ss, p_left_ss, R_left_ss] = left_leg_support (Tss, Ts, q0_right_ss, q0_left_ss, delta_right, Rd0_right, delta_left, Rd0_left);

q_right = [q_right, q_right_ss];
q_left = [q_left, q_left_ss];
q_dot_right = [q_dot_right, q_dot_right_ss];
q_dot_left = [q_dot_left, q_dot_left_ss];


%********************************
% Back to initial configuration *
%********************************
[a, dur] = size (q_right);
q0_right_ds = q_right(:,dur);
q0_left_ds = q_left(:,dur);

[q_right_ds, q_dot_right_ds, q_left_ds, q_dot_left_ds] = interpolate_to_configuration (Tds, Ts, q0_right_ds, q0_left_ds, q0_right, q0_left);

q_right = [q_right, q_right_ds];
q_left = [q_left, q_left_ds];
q_dot_right = [q_dot_right, q_dot_right_ds];
q_dot_left = [q_dot_left,q_dot_left_ds];



R_right =   [   1, 0, 0, 0, 0, 0;
                0, 1, 0, 0, 0, 0;
                0, 0,-1, 0, 0, 0;
                0, 0, 0, 1, 0, 0;
                0, 0, 0, 0, 1, 0;
                0, 0, 0, 0, 0,-1];

R_left =    [   1, 0, 0, 0, 0, 0;
                0, 1, 0, 0, 0, 0;
                0, 0, 1, 0, 0, 0;
                0, 0, 0,-1, 0, 0;
                0, 0, 0, 0,-1, 0;
                0, 0, 0, 0, 0,-1];
            
q_right_1=R_right'*q_right;
q_left_1=R_left'*q_left;

show_q (Ts, T, q_right, q_left, q_dot_right, q_dot_left);

time_vrml=[0:Ts:(T-Ts)]';
q_right_vrml=-q_right_1';
q_left_vrml=q_left_1';
write_to_file (q_right, q_left, 'rot_left.csv')