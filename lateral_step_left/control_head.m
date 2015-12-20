function data = control_head (angle, part)
rad2grad = 180/pi;
switch part
    case 'tilt'
        data = min(max(angle * rad2grad, -45), 15) + 60;
    case 'pan'
        data = 316 + min(max(angle * rad2grad, -60), 60);
    case 'roll'
        data = 572 + min(max(angle * rad2grad, -15), 15);
    otherwise
        data = 120;
end