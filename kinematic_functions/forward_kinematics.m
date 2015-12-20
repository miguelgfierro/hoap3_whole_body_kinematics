function [A, T] = forward_kinematics (a, d, alfa, teta)
%FORWARD_KINEMATICS computes the forward kinematics using the
%Denavit-Hartenberg method
%
%  [A, T] = FORWARD_KINEMATICS (a, d, alfa, teta) generates one vector of
%  matrixes A, in which the A(:,:,j) represents the transformation matrix
%  from the reference system j-1 to the system j and one matrix T which is
%  the transformation matrix from the reference origin to the end-effector
%  reference. The a, d, alfa and teta are the parameters obtained using the
%  Denavit-Hartenberg convention.

%   Author: Paolo Pierro
%   $Revision: 2.0 $  $Date: 2008/06/24 $


% Determine the n. of degrees of freedom
n = length(a);
A=sym(zeros(4,4,n));

% Determine the transformation matrix from the systems coordinates i to i-1
for i=1:n
    A(:,:,i) = coordinate_transform (a(i), d(i), alfa(i), teta(i));
end

% Evaluate the transformation matrix from the origin up to the end-effector
T=simple(product(A,n));


% Evaluate the transformation matrix described by the joint parameters in
% input
function A = coordinate_transform (a, d, alfa, teta)
A1=[cos(teta), -sin(teta), 0, 0; sin(teta), cos(teta), 0, 0; 0, 0, 1, d; 0, 0, 0, 1];
A2=[1, 0, 0, a; 0, cos(alfa), -sin(alfa), 0; 0, sin(alfa), cos(alfa), 0; 0, 0, 0, 1];
A=A1*A2;

% Evaluate the product of the matrixes indexed by the third element of the
% vector matrix M
function P = product(M, n)
[a,b,c]=size(M);
if c==1
    P=M;
else
    P=M(:,:,1)*product(M(:,:,(2:n)),n-1);
end