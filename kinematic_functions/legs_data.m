%This function loads tha data of the HOAP legs (in the manual)
function [a, d, alfa, teta, joint_var_right, joint_var_left] = legs_data()
syms a d alfa teta real
syms teta1 teta2 teta3 teta4 teta5 teta6 teta7 teta8 teta9 teta10 teta11 teta12 real
% syms L1 L2 L3 real

L1 = 0.039;
L2 = 0.105;
L3 = 0.105;

%Denavit-Hartenberg parameters table:

%right leg
a(1)=-L1;
a(2)=0;
a(3)=0;
a(4)=-L2;
a(5)=-L3;
a(6)=0;

d(1)=0;
d(2)=0;
d(3)=0;
d(4)=0;
d(5)=0;
d(6)=0;

alfa(1)=0;
alfa(2)=pi/2;
alfa(3)=pi/2;
alfa(4)=0;
alfa(5)=0;
alfa(6)=-pi/2;

teta(1)=teta1;
teta(2)=teta2+pi/2;
teta(3)=teta3;
teta(4)=teta4;
teta(5)=teta5;
teta(6)=teta6;

joint_var_right = [teta1, teta2, teta3, teta4, teta5, teta6];

%left leg
a(7)=-L1;
a(8)=0;
a(9)=0;
a(10)=-L2;
a(11)=-L3;
a(12)=0;

d(7)=0;
d(8)=0;
d(9)=0;
d(10)=0;
d(11)=0;
d(12)=0;

alfa(7)=0;
alfa(8)=pi/2;
alfa(9)=pi/2;
alfa(10)=0;
alfa(11)=0;
alfa(12)=-pi/2;

teta(7)=teta7;
teta(8)=pi/2+teta8;
teta(9)=teta9;
teta(10)=teta10;
teta(11)=teta11;
teta(12)=teta12;

joint_var_left = [teta7, teta8, teta9, teta10, teta11, teta12];