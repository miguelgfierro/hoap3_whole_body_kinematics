function q = up_down_head (Ts, T, q0, q1)
iterations = T/Ts-1;
% cabeza
delta = (q1-q0)/iterations*2;
q_a = q0:delta:q1;
q_b = q1:-delta:q0;
q = [q_a, q_b];