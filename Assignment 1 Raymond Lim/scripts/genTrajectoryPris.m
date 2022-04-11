function qM = genTrajectoryPris(q0,qlim, xValue, step)
    qf = q0;
    if xValue >= qlim(1) && xValue <= qlim(2)
        qPrisF = xValue ;
    else 
        if xValue > qlim(2)
            qPrisF = qlim(2);
        elseif xValue < qlim(1)
            qPrisF = qlim(1);
        end
    end     
    qf(1) = qPrisF;
    qM = jtraj(q0,qf,step);
end