clc
clear
clf
syms x y z


M = [x,y,z];

M = subs(subs(subs(M,x,2),y,10),z,20)