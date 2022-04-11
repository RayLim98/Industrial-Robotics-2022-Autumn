%% Ur3 ready pose
qUr3Start = ur3.model.getpos();
qUr3Ready = [0 -pi/2 pi/2 -pi/2 -pi/2 -pi/2];
trR = ur3.model.fkine(qUr3Ready);
trR = trR(1:3, 1:3);

qUr3Matrix = jtraj(qUr3Start, qUr3Ready, 30);
ur3.model.plot(qUr3Matrix)
