function [Robot,RobotType] = RobotCharacteristics(type)
%% This function creats the robot structure
RobotType = type;
switch type
    case 1
        Robot.Diameter = 5.5; %[cm]
        Robot.WheelDiameter = 2; %[cm]
        Robot.SenLocation = [0,pi/4,pi/2,3*pi/4,pi,5*pi/4,3*pi/2,7*pi/4]; %[rad]
        Robot.TargetSen.Rang = 100; %[cm]
        Robot.TargetSen.Span = pi/6; %[rad]
        Robot.ObstacleSen.Rang = 5; %[cm]
        Robot.ObstacleSen.Span = pi/30; %[rad]
        Robot.dt = 5; %[sec]
        Robot.Motors = 2;
        Robot.Sensors = 2*length(Robot.SenLocation);
        
    case 2
        Robot.Diameter = 5.5; %[cm]
        Robot.WheelDiameter = 2; %[cm]
        Robot.SenLocation = [13,38.5,64,167,193,296,321.5,347]*pi/180; %[rad]
        Robot.TargetSen.Rang = 100; %[cm]
        Robot.TargetSen.Span = pi/6; %[rad]
        Robot.ObstacleSen.Rang = 5; %[cm]
        Robot.ObstacleSen.Span = 6*pi/180; %[rad]
        Robot.dt = 5; %[sec]
        Robot.Motors = 2;
        Robot.Sensors = 2*length(Robot.SenLocation);
    otherwise
        disp('Error: This robot type is not defined')
        RobotType = nan(1);
end
end
        
