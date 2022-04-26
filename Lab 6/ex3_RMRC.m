clear 
clc
clf

mdl_puma560
p560.teach()
hold on
q1 = p560.getpos()
T1 = p560.fkine(q1)
Tf = transl(-0.2,0.5,0.2)
qF = p560.ikine(Tf)
qM = jtraj(q1, qF,30);

p560.plot(qM,'trail','b-');

%%
steps = 30
deltaT = 0.05
x1 = T1(1:3,4)
x2 = Tf(1:3,4)

p560.plot(qz)

x = zeros(3,steps);
s = lspb(0,1,steps);                                 % Create interpolation scalar
for i = 1:steps
    x(:,i) = x1*(1-s(i)) + s(i)*x2;                  % Create trajectory in x-y plane
end

% 3.8
qMatrix = nan(steps,6);

% 3.9
qMatrix(1,:) = p560.ikine(T1,q1);                 % Solve for joint angles

% 3.10
for i = 1:steps-1
    xdot = (x(:,i+1) - x(:,i))/deltaT;                             % Calculate velocity at discrete time step
    J = p560.jacob0(qMatrix(i,:));            % Get the Jacobian at the current state
    J = J(1:3,1:3)
    qdot = inv(J)*xdot;                             % Solve velocitities via RMRC
    qMatrix(i+1,:) =  qMatrix(i,:) + deltaT*[qdot;0;0;0]';                   % Update next joint state
end

p560.plot(qMatrix,'trail','r-');
