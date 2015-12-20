function J = evaluate_geometric_jacobian (A, T, joint_type)
%EVALUATE_GEOMETRIC_JACOBIAN computes the differential kinematics for the
%manipulator defined by the transformation matrixes A and T whose
%definition is given in the function FORWARD_KINEMATICS
%
%  J = evaluate_geometric_jacobian (A, T, joint_type) generates one matrix
%  12 * n, where n is the number of degrees of freedom of the manipulator
%  defined by A and T. The J matrix represents the geometric Jacobian of
%  the robotic manipulator defined in input. All the joints are supposed to
%  be revolute or prismatic (defined by joint_type)
 
%   Author: Paolo Pierro
%   $Revision: 3.0 $  $Date: 2009/03/02 $

% Determine the n. of degrees of freedom
[a, b, n] = size (A);

% Initialize the matrix for increasing speed
J_p = sym(zeros(3, n));
J_o = sym(zeros(3, n));

% Evaluate the position of the end-effector, defined by the first three
% elements of the forth column of the matrix T
p_ee=T(1:3,4);

% Versor z of the origin (first reference system)
z(:,1) = sym([0; 0; 1]);

% Position of the origin (first reference system)
p(:,1) = sym([0; 0; 0; 1]);

P = cum_prod_sym (A);
for jj=1:n
    % contribution to the end-effector velocity of the jj-th joint
    [J_p(1:3,jj), J_o(1:3,jj)] = jacobian_component (z(:,jj), (p_ee-p(1:3,jj)), joint_type(jj));
    
    % Versor z of the jj-th reference system with respect to the origin
    z(:, jj+1) = P(1:3,1:3,jj)*z(:,1);
    
    % Position z of the jj-th reference system with respect to the origin
    p(:, jj+1) = P(:,:,jj)*p(:,1);
end

% Geometric Jacobian
J = [J_p; J_o];

%%%%%%%%%%%%%%%%%%%%%%%
% Auxiliary functions %
%%%%%%%%%%%%%%%%%%%%%%%

% Calculate the contribution to the end-effector linear and angular speed of
% the joint specified as input (it works only with revolute  and prismatic joints).
function [jp, jo] = jacobian_component (z, p, type)
switch type
    case 'p'
          % prismatic joint
          jp = z;
          jo = sym(zeros(3,1));
          
    case 'r'
          % revolute joint
          jp = cross(z,p);
          jo = z;
end

% Determine the vector of matrixes P(:,:,jj) where the matrix jj represents
% the cumulative product of the A matrix until jj
function P = cum_prod_sym (A)
[a, b, n] = size (A);
P(:,:,1) = A(:,:,1);
for ii=2:n
    P(:,:,ii) = P(:,:,ii-1)*A(:,:,ii);
end
