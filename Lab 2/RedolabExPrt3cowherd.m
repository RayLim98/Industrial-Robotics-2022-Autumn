herd = RobotCows();
count = 200;

droneOrigin = eye(4);

message = sprintf('hello')
text_h = text(10, 50, message, 'FontSize', 20, 'Color', [.6 .2 .6]);

position = transl(0,0,10)
End = position
tranimate(droneOrigin,End, "fps", 50)
herd.PlotSingleRandomStep()

Start = End
End = position * trotx(-10,"deg")
tranimate(Start,End, "fps", 50)
herd.PlotSingleRandomStep()

position = transl(0,2,10)

Start = End
End = position * trotx(-10,"deg")
tranimate(Start,End, "fps", 50)
% where is cow in respect to drone
herd.PlotSingleRandomStep()

Start = End
End = position
tranimate(Start,End, 'fps', 50)
herd.PlotSingleRandomStep()

Start = End
End = position * troty(20 ,'deg')
tranimate(Start, End, 'fps', 50)
herd.PlotSingleRandomStep()

position = transl(2,2,10)
Start = End
End = position * troty(20 ,'deg')
tranimate(Start, End, 'fps', 50)
herd.PlotSingleRandomStep()

Start = End
End = position
tranimate(Start, End, 'fps', 50)
herd.PlotSingleRandomStep()

position = transl(2, 2, 0)
Start = End
End = position
tranimate(Start, End, 'fps', 50)
herd.PlotSingleRandomStep()
