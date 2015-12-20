function q_dot=velocity(Ts,q)
q_dot=diff(q,1,2)/Ts;
q_dot=[zeros(size(q,1),1),q_dot];
    
