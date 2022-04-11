function lab1_q()
    imshow('Lab1_CircularRaceTrack.jpg'); 
    axis on
    hold on

    T1 = se2(300, 550, 0);
    T2 = se2(300, 125, 0);
    hold on 
    T1_h = trplot2(T1, 'frame', '1', 'color', 'b', 'length', 50);
    T2_h = trplot2(T2, 'frame', '2', 'color', 'r', 'length', 50);

    pathing = 360;
    car1Move = se2(pi*484/pathing,0,0);
    car1Turn = se2(0,0,-2*pi/pathing);

    car2Move = se2((pi * 375)/360, 0, 0);
    car2Turn = se2(0, 0, 2*pi/360);
    for i=1:360
        T1 = T1 * car1Turn * car1Move;
        T2 = T2 * (car2Turn)* (car2Move);

        delete(T1_h);
        delete(T2_h);

        T1_h = trplot2(T1, 'frame', '1', 'color', 'b', 'length', 50);
        T2_h = trplot2(T2, 'frame', '2', 'color', 'r', 'length', 50);
        drawnow();
    end