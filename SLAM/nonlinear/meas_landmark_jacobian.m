% MEAS_LANDMARK_JACOBIAN
% 16-831 Fall 2016 - *Stub* Provided
% Compute the Jacobian of the measurement function
%
% Arguments: 
%     rx    - robot's x position
%     ry    - robot's y position
%     lx    - landmark's x position
%     ly    - landmark's y position
%
% Returns:
%     H     - Jacobian of the measurement fuction
%
function H = meas_landmark_jacobian(rx, ry, lx, ly)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%% Your code goes here %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% syms rx ry lx ly;
% assume (rx, 'real');
% assume (ry, 'real');
% assume (lx, 'real');
% assume (ly, 'real');
% 
% H = jacobian([atan2(ly-ry, lx-rx), sqrt((lx-rx)^2 + (ly-ry)^2)], [rx ry lx ly]);

% H = [(ly - ry)/((lx - rx)^2 + (ly - ry)^2),    -(lx - rx)/((lx - rx)^2 + (ly - ry)^2),    -(ly - ry)/((lx - rx)^2 + (ly - ry)^2),  (lx - rx)/((lx - rx)^2 + (ly - ry)^2);
%  -(2*lx - 2*rx)/(2*((lx - rx)^2 + (ly - ry)^2)^(1/2)), -(2*ly - 2*ry)/(2*((lx - rx)^2 + (ly - ry)^2)^(1/2)), (2*lx - 2*rx)/(2*((lx - rx)^2 + (ly - ry)^2)^(1/2)), (2*ly - 2*ry)/(2*((lx - rx)^2 + (ly - ry)^2)^(1/2))];

H = [(ly - ry)/((lx - rx)^2 + (ly - ry)^2), -(lx - rx)/((lx - rx)^2 + (ly - ry)^2), -(ly - ry)/((lx - rx)^2 + (ly - ry)^2), (lx - rx)/((lx - rx)^2 + (ly - ry)^2); 
    -(2*lx - 2*rx)/(2*((lx - rx)^2 + (ly - ry)^2)^(1/2)), -(2*ly - 2*ry)/(2*((lx - rx)^2 + (ly - ry)^2)^(1/2)), (2*lx - 2*rx)/(2*((lx - rx)^2 + (ly - ry)^2)^(1/2)), (2*ly - 2*ry)/(2*((lx - rx)^2 + (ly - ry)^2)^(1/2))];
