function write_to_file (Ts, q_right_leg, q_left_leg, q_right_arm, q_left_arm, q_waist, q_head, head_movement, q_hand, hand_movement, hand_selection, file_name)
conversion = 180/pi*209;
q = [q_right_leg; q_right_arm; q_left_leg; q_left_arm; q_waist];

Ts_header = Ts/1e-3;
motors = round([q .* conversion; control_head(q_head, head_movement); control_hand(q_hand, hand_movement, hand_selection)]');
[L, n] =size(motors);

fid = fopen(file_name, 'wt');
for jj=1:L
    fprintf(fid, '%d,', Ts_header);
    fprintf(fid, '%d,', 2);   
    for ii=1:23
        fprintf(fid, '%d,', motors(jj,ii));
    end
    fprintf(fid, 'R,R,R,R\n');
end
fclose(fid)