function [RobotoutlineX,RobotoutlineY,SensorX,SensorY] = plotRobot(RobotPosition,Arena,Robot)
%% this function generates the data for drawing the robot
Angle = 0:0.01:pi*2;
RobotoutlineX = zeros(length(Angle),1);
RobotoutlineY = zeros(length(Angle),1);
for i = 1:length(Angle)
    RobotoutlineX(i) = RobotPosition(1) + Robot.Diameter/2*cos(Angle(i));
    RobotoutlineY(i) = RobotPosition(2) + Robot.Diameter/2*sin(Angle(i));
end

SensorX = zeros(length(Robot.SenLocation),1);
SensorY = zeros(length(Robot.SenLocation),1);

for i = 1:length(Robot.SenLocation)
    SensorX(i) = RobotPosition(1) + 0.9*Robot.Diameter/2*cos(Robot.SenLocation(i) + RobotPosition(3));
    SensorY(i) = RobotPosition(2) + 0.9*Robot.Diameter/2*sin(Robot.SenLocation(i) + RobotPosition(3));
end
% figure()
plot(RobotoutlineX,RobotoutlineY,'.k',... 
    SensorX,SensorY,'.r', ...
    Arena.Walls(:,1),Arena.Walls(:,2),'.k', ...
    Arena.StartingPoint(1),Arena.StartingPoint(2));
hold on
plot(Arena.Targets(:,1),Arena.Targets(:,2),'*b','MarkerSize',10)
hold off
axis equal
grid

end
