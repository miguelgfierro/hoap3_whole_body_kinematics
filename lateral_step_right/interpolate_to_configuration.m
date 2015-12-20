function [q_right, q_dot_right, q_left, q_dot_left] = interpolate_to_configuration (T, Ts, q0_right, q0_left, q1_right, q1_left)
time=0:Ts:T-Ts;
for jj=1:6
    q_right(jj,:) = interpolation (T, time, q0_right(jj), q1_right(jj), 0, 0);
    q_left(jj,:) = interpolation (T, time, q0_left(jj), q1_left(jj), 0, 0);
end

q_dot_right = [zeros(6,1),diff(q_right,1,2)/Ts];
q_dot_left = [zeros(6,1),diff(q_left,1,2)/Ts];