%This function loads the data of HOAP3 arms
%The base frame is the chest of the humanoid and the end effector is the
%elbow. We will later have to get the hand coordinates through a
%homogeneous transformation. 
function [a, d, alfa, teta, joint_var_right, joint_var_left] = arms_data()
syms a d alfa teta real
syms teta6 teta7 teta8 teta9 teta10 teta16 teta17 teta18 teta19 teta20 real

L1 = 111/1000;
L2 = 111/1000;
L3 = 171/1000;

%Denavit-Hartenberg parameters table (from HOAP manual):

%right arm 
a(1)=0;
a(2)=0;
a(3)=0;
a(4)=0;
a(5)=0;


d(1)=-L1;
d(2)=0;
d(3)=0;
d(4)=-L2;
d(5)=0;

alfa(1)=-pi/2;
alfa(2)=0;
alfa(3)=pi/2;
alfa(4)=pi/2;
alfa(5)=pi/2;


teta(1)=0;
teta(2)=teta7;
teta(3)=pi/2+teta8;
teta(4)=pi/2+teta9;
teta(5)=teta10;

joint_var_right = [teta6, teta7, teta8, teta9, teta10];

%left arm
a(6)=0;
a(7)=0;
a(8)=0;
a(9)=0;
a(10)=0;


d(6)=L1;
d(7)=0;
d(8)=0;
d(9)=-L2;
d(10)=0;

alfa(6)=-pi/2;
alfa(7)=0;
alfa(8)=pi/2;
alfa(9)=pi/2;
alfa(10)=pi/2;


teta(6)=0;
teta(7)=teta17;
teta(8)=pi/2+teta18;
teta(9)=pi/2+teta19;
teta(10)=teta20;

joint_var_left = [teta16, teta17, teta18, teta19, teta20];
