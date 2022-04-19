clear
clc
clf
mdl_planar3
syms l1 l2 l3 x y phi q1 q2 q3 Jq;

p3.teach()


x = l1*cos(q1) + l2*cos(q1+q2) + l2*cos(q1+q2+q3);
y = l1*sin(q1) + l2*sin(q1+q2) + l2*sin(q1+q2+q3);
phi = q1 + q2 + q3;

Jq =  [- sin(q1 + q2 + q3) - sin(q1 + q2) - sin(q1), - sin(q1 + q2 + q3) - sin(q1 + q2), -sin(q1 + q2 + q3);
      cos(q1 + q2 + q3) + cos(q1 + q2) + cos(q1),   cos(q1 + q2 + q3) + cos(q1 + q2),  cos(q1 + q2 + q3);
                       1,                                  1,                  1]
subs(subs(subs(Jq,q1,0),q2,0),q3,0)
J = p3.jacob0(p3.getpos())