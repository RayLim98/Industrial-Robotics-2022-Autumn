% message = sprintf('hello')
% text_h = text(10, 50, message, 'FontSize', 20, 'Color', [.6 .2 .6]);
% message = sprintf([num2str(round(car1Tr(1,:),2,'significant')),'\n' ...
%                   ,num2str(round(car1Tr(2,:),2,'significant')),'\n' ...
%                   ,num2str(round(car1Tr(3,:),2,'significant'))]);
% 
for i = 0:10 
    droneOrigin = eye(4);

    message = sprintf('hello')
    text_h = text(10, 50, message, 'FontSize', 20, 'Color', [.6 .2 .6]);

    position = transl(0,0,10)
    End = position
    tranimate(droneOrigin,End, "fps", 50)
    
    Start = End
    End = position * trotx(-10,"deg")
    tranimate(Start,End, "fps", 50)
    
    position = transl(0,2,10)
    
    Start = End
    End = position * trotx(-10,"deg")
    tranimate(Start,End, "fps", 25)
    
    Start = End
    End = position
    tranimate(Start,End, 'fps', 50)
    
    Start = End
    End = position * troty(20 ,'deg')
    tranimate(Start, End, 'fps', 50)
    
    position = transl(2,2,10)
    Start = End
    End = position * troty(20 ,'deg')
    tranimate(Start, End, 'fps', 50)
    
    Start = End
    End = position
    tranimate(Start, End, 'fps', 50)
    
    position = transl(2, 2, 0)
    Start = End
    End = position
    tranimate(Start, End, 'fps', 50)
    
    position = eye(4)
    Start = End
    End = position
    tranimate(Start, End, 'fps', 50)
end
    