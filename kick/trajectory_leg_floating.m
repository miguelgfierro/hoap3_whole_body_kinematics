%********************
% floating left leg
%********************
function [xd, xd_dot] = trajectory_leg_floating (T, Ts, p0, delta_x, delta_y, delta_z)
time=0:Ts:T-Ts;
time_phase1 = 0:Ts:(T/2-Ts);
time_phase2 = 0:Ts:(T/2-Ts);

% frontal plane
% x axis
x1 = interpolation (T/2, time_phase1, p0(1), p0(1)+delta_x, 0, 0);
x2 = interpolation (T/2, time_phase2, p0(1)+delta_x, p0(1), 0, 0);
xd(1,:) = [x1, x2];

% sagital plane
% y axis
xd(2,:) = interpolation (T, time, p0(2), p0(2)+delta_y, 0, 0);

% z axis
z1 = interpolation (T/2, time_phase1, p0(3), p0(3)+delta_z, 0, 0);
z2 = interpolation (T/2, time_phase2, p0(3)+delta_z, p0(3), 0, 0);
xd(3,:) = [z1,z2];

%desired velocity
xd_dot = [zeros(3,1),diff(xd,1,2)/Ts];