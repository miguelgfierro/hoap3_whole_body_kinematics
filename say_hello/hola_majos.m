function q_right = hola_majos (Ts, T_tot, q0_right, q1_right)
T=1;
q_right = [interpolate_variable(Ts, T/2, q0_right, q1_right), interpolate_variable(Ts, T/2, q1_right, q0_right)];
q_right=replicate_vector(q_right,T_tot);