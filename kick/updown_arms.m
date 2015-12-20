function [q_right, q_left] = updown_arms (Ts, T_tot, q0_right, q0_left, q1_right, q1_left)
T = T_tot/2;

% iterations = T/Ts-1;
% delta_right = (q1_right-q0_right)/iterations;
% delta_left = (q1_left-q0_left)/iterations;
% for jj=1:4  
%     q_left(jj,:) = [q0_left(jj):delta_left(jj):q1_left(jj), q1_left(jj):-delta_left(jj):q0_left(jj)];
%     q_right(jj,:) = [q0_right(jj):delta_right(jj):q1_right(jj), q1_right(jj):-delta_right(jj):q0_right(jj)];
% end

q_left = [interpolate_variable(Ts, T, q0_left, q1_left), interpolate_variable(Ts, T, q1_left, q0_left)];
q_right = [interpolate_variable(Ts, T, q0_right, q1_right), interpolate_variable(Ts, T, q1_right, q0_right)];