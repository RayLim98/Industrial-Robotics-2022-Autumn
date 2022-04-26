clear
clc
clf

% Get Jacob
syms l1 l2 l3 x y phi q1 q2 q3 Jq;

x = l1*cos(q1) + l2*cos(q1+q2) + l3*cos(q1+q2+q3);
y = l1*sin(q1) + l2*sin(q1+q2) + l3*sin(q1+q2+q3);
phi = q1 + q2 + q3;

Jq = [diff(x,q1),diff(x,q2),diff(x,q3) ...
    ; diff(y,q1),diff(y,q2),diff(y,q3) ...
    ; diff(phi,q1),diff(phi,q2),diff(phi,q3)];


Jq = subs(subs(subs(Jq,l1,1),l2,1),l3,1);
Jq = subs(subs(subs(Jq,q1,0),q2,0),q3,0)

mdl_planar3
p3.teach()
q = p3.getpos();
J = p3.jacob0([0,0,0])