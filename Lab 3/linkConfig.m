function [outputArg1] = linkConfig()
%LINKCONFIG Summary of this function goes here
%   Detailed explanation goes here
L1 = Link('a', 0.180, 'd',0.475,'alpha', -pi/2,'offset',0, 'qlim', [deg2rad(-170), deg2rad(170)]);
L2 = Link('d', 0,'a', 0.385,'alpha', 0,'offset',  -pi/2, 'qlim', [deg2rad(-135), deg2rad(135)]);
L3 = Link('d', 0,'a', -0.116,'alpha', pi/2,'offset', pi/2, 'qlim', [deg2rad(-80), deg2rad(165)]);
L4 = Link('d',0.329,'a', 0,'alpha', pi/2,'offset', 0, 'qlim', [deg2rad(-185), deg2rad(185)]);
L5 = Link('d',0,'a',0,'alpha', -pi/2 ,'offset',0, 'qlim', [deg2rad(-120), deg2rad(120)]);
L6 = Link('d',0.084,'a', 0,'alpha', 0,'offset',0, 'qlim', [deg2rad(-360), deg2rad(360)]);

outputArg1 = [L1 L2 L3 L4 L5 L6];
end

