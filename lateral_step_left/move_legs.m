function [q_right, q_left] = move_legs (Ts, T, q0_right, q0_left)

%Hago la rutina equivalente a la q tiene Paolo

% time conditions
Tds=T/4;
Tss=T/8;
%Tds=0.8;
%Tss=0.8;

% step conditions
L = 0.03;           %step length

%************************************
% double support phase on right leg *                         % DURA 1s
%************************************
alfa = 0;           %desired orientation in degrees
[Rd0_right, Rd0_left] = determine_matrixes_rotation (alfa*pi/180);


% desired position conditions for the right supporting leg
delta_right(1) = -0.05;                     %waist displacement in x (sagital plane)
delta_right(2) = 0;                  %waist displacement in y (frontal plane height)-> determine how much I elevate the waist
delta_right(3) = 0;                     %waist displacement in z (frontal plane lenght, i.e. direction of the step)

% desired position conditions for the left floating leg
delta_left(1) = 0.05;                    %waist displacement in x (sagital plane)
delta_left(2) = 0;                      %waist displacement in y (frontal plane lenght, i.e. opposite direction of the step)
%delta_left(3) = 0.01;                   %waist displacement in z (frontal plane height)-> determine how much I elevate the foot
delta_left(3) = 0;

% trajectory generation
[q_right_ds, q_dot_right_ds, p_right_ds, R_right_ds, q_left_ds, q_dot_left_ds, p_left_ds, R_left_ds] = double_support (Tds, Ts, q0_right, q0_left, delta_right, Rd0_right, delta_left, Rd0_left);

q_right = q_right_ds;
q_left = q_left_ds;
q_dot_right = q_dot_right_ds;
q_dot_left = q_dot_left_ds;


%************************************
% single support phase on right leg *                       % DURA 0.5s
%************************************
[a, dur] = size (q_right);
q0_right_ss = q_right(:,dur);
q0_left_ss = q_left(:,dur);
% desired position conditions for the right supporting leg
delta_right(1) = 0.01;          %waist displacement in x (sagital plane)
delta_right(2) = -0.01;            %waist displacement in y (frontal plane height)-> determine how much I elevate the waist
delta_right(3) = 0;            %waist displacement in z (frontal plane lenght, i.e. direction of the step)

% desired position conditions for the left floating leg
delta_left(1) = L;               %leg displacement in x (sagital plane)
delta_left(2) = 0;              %leg displacement in y (frontal plane lenght, i.e. opposite direction of the step)
delta_left(3) = 0.01;            %leg displacement in z (frontal plane height)-> determine how much I elevate the foot

% desired orientation for the right supporting leg and for the left floating leg
alfa = 0;                        %desired orientation in degrees
[Rd0_right, Rd0_left] = determine_matrixes_rotation (alfa*pi/180);

[q_right_ss, q_dot_right_ss, p_right_ss, R_right_ss, q_left_ss, q_dot_left_ss, p_left_ss, R_left_ss] = right_leg_support (Tss, Ts, q0_right_ss, q0_left_ss, delta_right, Rd0_right, delta_left, Rd0_left);

q_right = [q_right, q_right_ss];
q_left = [q_left, q_left_ss];
q_dot_right = [q_dot_right, q_dot_right_ss];
q_dot_left = [q_dot_left,q_dot_left_ss];

%************************************
% double support phase on right leg *                         % DURA 1s
%************************************
alfa = 0;           %desired orientation in degrees
[Rd0_right, Rd0_left] = determine_matrixes_rotation (alfa*pi/180);

[a, dur] = size (q_right);
q0_right_ds = q_right(:,dur);
q0_left_ds = q_left(:,dur);

% desired position conditions for the right supporting leg
delta_right(1) = 0.12;       %waist displacement in x (sagital plane)
%delta_right(2) = 0.01;                     %waist displacement in y (frontal plane height)-> determine how much I elevate the waist
delta_right(2) = 0;
delta_right(3) = 0;                     %waist displacement in z (frontal plane lenght, i.e. direction of the step)

% desired position conditions for the left floating leg
delta_left(1) = -0.12;         %waist displacement in x (sagital plane)
delta_left(2) = 0;                      %waist displacement in y (frontal plane lenght, i.e. opposite direction of the step)
%delta_left(3) = -0.01;                      %waist displacement in z (frontal plane height)-> determine how much I elevate the foot
delta_left(3) = 0;

% trajectory generation
[q_right_ds, q_dot_right_ds, p_right_ds, R_right_ds, q_left_ds, q_dot_left_ds, p_left_ds, R_left_ds] = double_support (Tds, Ts, q0_right_ds, q0_left_ds, delta_right, Rd0_right, delta_left, Rd0_left);

q_right = [q_right, q_right_ds];
q_left = [q_left, q_left_ds];
q_dot_right = [q_dot_right, q_dot_right_ds];
q_dot_left = [q_dot_left,q_dot_left_ds];

%************************************
% single support phase on left leg  *                       % DURA 0.5s
%************************************
[a, dur] = size (q_right);
q0_right_ss = q_right(:,dur);
q0_left_ss = q_left(:,dur);

% desired position conditions for the left supporting leg
delta_left(1) = -0.01;          %waist displacement in x (sagital plane)
delta_left(2) = -0.01;            %waist displacement in y (frontal plane height)-> determine how much I elevate the waist
delta_left(3) = 0;            %waist displacement in z (frontal plane lenght, i.e. direction of the step)

% desired position conditions for the right floating leg
delta_right(1) = L;               %leg displacement in x (sagital plane)
delta_right(2) = 0;              %leg displacement in y (frontal plane lenght, i.e. opposite direction of the step)
delta_right(3) = 0.01;            %leg displacement in z (frontal plane height)-> determine how much I elevate the foot

% desired orientation for the left supporting leg and for the right floating leg
alfa = 0;                        %desired orientation in degrees
[Rd0_left, Rd0_right] = determine_matrixes_rotation (alfa*pi/180);

[q_right_ss, q_dot_right_ss, p_right_ss, R_right_ss, q_left_ss, q_dot_left_ss, p_left_ss, R_left_ss] = left_leg_support (Tss, Ts, q0_right_ss, q0_left_ss, delta_right, Rd0_right, delta_left, Rd0_left);

q_right = [q_right, q_right_ss];
q_left = [q_left, q_left_ss];
q_dot_right = [q_dot_right, q_dot_right_ss];
q_dot_left = [q_dot_left, q_dot_left_ss];
 
%********************************
% Back to initial configuration *                         % DURA 1s
%********************************
[a, dur] = size (q_right);
q0_right_ds = q_right(:,dur);
q0_left_ds = q_left(:,dur);

[q_right_ds, q_dot_right_ds, q_left_ds, q_dot_left_ds] = interpolate_to_configuration (Tds, Ts, q0_right_ds, q0_left_ds, q0_right, q0_left);

q_right = [q_right, q_right_ds];
q_left = [q_left, q_left_ds]; 
 
 
 
