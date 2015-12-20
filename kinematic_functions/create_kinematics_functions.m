% This function puts in the directory provided as argument the files for
% the kinematics (for simulation)
function create_kinematics_functions (J_left, T_left, joint_var_left, J_right, T_right, joint_var_right, destination)
if not(exist (destination, 'dir'))
    mkdir(destination)
end
write_matrix_to_file(J_left, 'evaluate_jacobian_left','q','J',joint_var_left);
write_matrix_to_file(T_left(1:3,4), 'evaluate_position_left','q','p',joint_var_left);
write_matrix_to_file(T_left(1:3,1:3), 'evaluate_orientation_left','q','R',joint_var_left);
write_matrix_to_file(J_right, 'evaluate_jacobian_right','q','J',joint_var_right);
write_matrix_to_file(T_right(1:3,4), 'evaluate_position_right','q','p',joint_var_right);
write_matrix_to_file(T_right(1:3,1:3), 'evaluate_orientation_right','q','R',joint_var_right);
movefile('evaluate_jacobian_left.m',destination);
movefile('evaluate_position_left.m',destination);
movefile('evaluate_orientation_left.m',destination);
movefile('evaluate_jacobian_right.m',destination);
movefile('evaluate_position_right.m',destination);
movefile('evaluate_orientation_right.m',destination);