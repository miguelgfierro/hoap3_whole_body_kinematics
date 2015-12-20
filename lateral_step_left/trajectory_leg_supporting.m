%**********************
% supporting right leg
%**********************
%Trayectoria modificada para realizar pasos laterales

function [xd, xd_dot] = trajectory_leg_supporting (T, Ts, p0, delta_x, delta_y, delta_z)
time=0:Ts:T-Ts;
time_phase1 = 0:Ts:(T/2-Ts);
time_phase2 = 0:Ts:(T/2-Ts);

% frontal plane
% x axis
% x1 = interpolation (T/2, time_phase1, p0(1), p0(1)+delta_x, 0, 0);
% x2 = interpolation (T/2, time_phase2, p0(1)+delta_x, p0(1), 0, 0);
% xd(1,:) = [x1, x2];
xd(1,:) = interpolation (T, time, p0(1), p0(1)+delta_x, 0, 0);

% sagital plane
% y axis
y1 = interpolation (T/2, time_phase1, p0(2), p0(2)+delta_y, 0, 0);
y2 = interpolation (T/2, time_phase2, p0(2)+delta_y, p0(2), 0, 0);
xd(2,:) = [y1,y2];

% z axis
%xd(3,:) = interpolation (T, time, p0(3), p0(3)+delta_z, 0, 0);
z1 = interpolation (T/2, time_phase1, p0(3), p0(3)+delta_z, 0, 0);
z2 = interpolation (T/2, time_phase2, p0(3)+delta_z, p0(3), 0, 0);
xd(3,:) = [z1,z2];

xd_dot = [zeros(3,1),diff(xd,1,2)/Ts];