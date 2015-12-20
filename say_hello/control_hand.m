function data = control_hand (angle, part, hand)
rad2grad = 180/pi;
switch hand
    case 'right'
        offset_hand = 0;
    case 'left'
        offset_hand = 256;
    otherwise
        offset_hand = 0;
end

switch part
    case 'rotate'
        offset_part = 0;
    case 'close'
        offset_part = 512;
    otherwise
        offset_part = 0;
end

data = min(max(angle * rad2grad, -60), 60) + 60 + offset_hand + offset_part;