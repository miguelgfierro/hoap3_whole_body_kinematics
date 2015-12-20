function q_out=doesnt_move (Ts,T,q_in)
q_out=[];
time = 0 : Ts : T-Ts;
n_times=length(time);
for i=1:n_times
    q_out=[q_out,q_in];
end
    