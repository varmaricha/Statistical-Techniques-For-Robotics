% CREATE_AB_LINEAR
% 16-831 Fall 2016 - *Stub* Provided
% Computes the A and b matrices for the 2D linear SLAM problem
%
% Arguments: 
%     odom    - Matrix that contains the odometry measurements
%               between consecutive poses. Each row corresponds to
%               a measurement. 
%                 odom(:,1) - x-value of odometry measurement
%                 odom(:,2) - y-value of odometry measurement
%     obs     - Matrix that contains the landmark measurements and
%               relevant information. Each row corresponds to a
%               measurement.
%                 obs(:,1) - idx of pose at which measurement was 
%                   made
%                 obs(:,2) - idx of landmark being observed
%                 obs(:,3) - x-value of landmark measurement
%                 obs(:,4) - y-value of landmark measurement
%     sigma_o - Covariance matrix corresponding to the odometry
%               measurements
%     sigma_l - Covariance matrix corresponding to the landmark
%               measurements
% Returns:
%     A       - MxN matrix
%     b       - Mx1 vector
%
function [As, b] = create_Ab_linear(odom, obs, sigma_o, sigma_l)


% Useful Constants
n_poses = size(odom, 1) + 1; % +1 for prior on the first pose
n_landmarks = max(obs(:,2));

n_odom = size(odom, 1);
n_obs  = size(obs, 1);

% Dimensions of state variables and measurements (all 2 in this case)
p_dim = 2;
l_dim = 2;
o_dim = size(odom, 2);
m_dim = size(obs(1, 3:end), 2);

% A matrix is MxN, b is Nx1
N = p_dim*n_poses + l_dim*n_landmarks;
M = o_dim*(n_odom+1) + m_dim*n_obs;     % +1 for prior on the first pose
% Initialize matrices
A = zeros(M, N);
b = zeros(M, 1);

% Add odometry and landmark measurements to A, b - including prior on first
% pose

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%% Your code goes here %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

inv_root_sigma_o = sqrtm(inv(sigma_o));
inv_root_sigma_l = sqrtm(inv(sigma_l));
H_o = zeros(o_dim*n_odom+1,N);
temp = zeros(o_dim,N);
temp(1, 1:4) = [-1 0 1 0];
temp(2, 1:4) = [0 -1 0 1];
temp = inv_root_sigma_o * temp;
H_o(1,1) = 1; H_o(2,2) = 1;
%% H_o(1:2, :) = inv_root_sigma_o * H_o(1:2, :);
for i = 2:n_odom+1
    H_o(2*i-1, :) = temp(1,:);
    H_o(2*i, :) = temp(2,:);
    temp = circshift(temp,p_dim,2);
end

H_l = zeros(m_dim*n_obs,N);
%temp = zeros(m_dim,N);
% temp(1, 1:2) = [-1 0];
% temp(2, 1:2) = [0 -1];
% temp(1, p_dim*n_poses+1:p_dim*n_poses+2) = [1 0];
% temp(2, p_dim*n_poses+1:p_dim*n_poses+2) = [0 1];
% temp = inv_root_sigma_l * temp;

for i = 1:n_obs
    H_l(2*i-1, 2*obs(i,1)-1) = -1;
    H_l(2*i, 2*obs(i,1)) = -1;
    H_l(2*i-1, p_dim*n_poses + 2*obs(i,2)-1) = 1;
    H_l(2*i, p_dim*n_poses + 2*obs(i,2)) = 1;
    H_l(2*i-1:2*i, :) = inv_root_sigma_l * H_l(2*i-1:2*i, :); 
end

A = [H_o; H_l];

for i = 2:n_odom+1
    b(2*i-1, 1) = odom(i-1, 1);
    b(2*i, 1) = odom(i-1, 2);
    b(2*i-1:2*i, 1) = inv_root_sigma_o * b(2*i-1:2*i, 1);
end
i
for j = i+1:i+n_obs
    b(2*j-1, 1) = obs(j-i, 3);
    b(2*j, 1) = obs(j-i, 4);
    b(2*j-1:2*j, 1) = inv_root_sigma_l * b(2*j-1:2*j, 1);
end    

%% Make A a sparse matrix 
As = sparse(A);