% HOAP kinematics
clear all
clc

%load the legs data
[a, d, alfa, teta, joint_var_right, joint_var_left] = legs_data();

% forward kinematics of the right supporting leg
[A_right, T_right] = forward_kinematics (a(1:5), d(1:5), alfa(1:5), teta(1:5));

% forward kinematics of the left floating leg
[A_left, T_left] = forward_kinematics (a(6:10), d(6:10), alfa(6:10), teta(6:10));

joint_type = ['r','r','r','r','r'];
J_left = evaluate_geometric_jacobian (A_left, T_left, joint_type);
J_right = evaluate_geometric_jacobian (A_right, T_right, joint_type);

create_kinematics_functions (J_left, T_left, joint_var_left, J_right, T_right, joint_var_right, 'Simulation')