function Arena = SelectArena(type)
% This function creates a structure that defines the arena including Arena.Walls;Arena.Targets;Arena.StartingPoint;

% clf
Walls = nan;
PIW = 0; %   Points In Wall
startPosition = [95,5,pi];
MaxStep = 200;
%  Function:
Targets = [];
switch type
    case 1      % Source 1
        %   Outer Walls
        %   Upper & Lower Walls
        PIW = 200;
        x = linspace(0, 60, PIW)'; y = linspace(0, 0, PIW)';                %    Lower wall
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        x = linspace(0, 60, PIW)'; y = linspace(60, 60, PIW)';       %    Upper wall
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        %   Right & Left Walls
        PIW = 200;
        x = linspace(0, 0, PIW)'; y = linspace(0, 60, PIW)';       %    Left wall
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        x = linspace(60, 60, PIW)'; y = linspace(0, 60, PIW)';           %    Right wall
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        x = linspace(40, 40, PIW)'; y = linspace(0, 30, PIW)';       %    Right obstc
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        x = linspace(40, 45, PIW)'; y = linspace(30, 30, PIW)';           %    Right obstc
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        x = linspace(20, 20, PIW)'; y = linspace(60, 40, PIW)';           %   Left obstc
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];

        %   Targets
        Targets = [...
            8, 55;
            ];
        startPosition = [  ...
            55 5 pi;
            ];
    case 2      % Source 2
        %   Outer Walls
        %   Upper & Lower Walls
        PIW = 200;
        x = linspace(0, 50, PIW)'; y = linspace(0, 0, PIW)';                %    Lower wall
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        x = linspace(0, 50, PIW)'; y = linspace(100, 100, PIW)';       %    Upper wall
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        %   Right & Left Walls
        PIW = 200;
        x = linspace(0, 0, PIW)'; y = linspace(0, 100, PIW)';       %    Left wall
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        x = linspace(50, 50, PIW)'; y = linspace(0, 100, PIW)';           %    Right wall
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        x = linspace(12.5, 17.5, PIW)'; y = linspace(70, 70, PIW)';           %   Left obstc
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
%         x = linspace(12.5, 17.5, PIW)'; y = linspace(20, 20, PIW)';           %   Left obstc
%         Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        x = linspace(17.5, 17.5, PIW)'; y = linspace(20, 70, PIW)';           %   Left obstc
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
%         x = linspace(32.5, 37.5, PIW)'; y = linspace(70, 70, PIW)';           %   Right obstc
%         Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        x = linspace(32.5, 37.5, PIW)'; y = linspace(20, 20, PIW)';           %   Right obstc
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        x = linspace(32.5, 32.5, PIW)'; y = linspace(20, 70, PIW)';           %   Right obstc
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        %   Targets
        Targets = [...
            8, 92;
            ];
        startPosition = [  ...
            45 20 pi;
            ];
    case 3      % Source 3
         %    Straight Arena, "Encouraging reactivity to create robust machines" with obst
        %   Outer Walls
        %   Upper & Lower Walls
        PIW = 200;
        x = linspace(0, 50, PIW)'; y = linspace(0, 0, PIW)';                %    Lower wall
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        x = linspace(0, 50, PIW)'; y = linspace(100, 100, PIW)';       %    Upper wall
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        %   Right & Left Walls
        PIW = 200;
        x = linspace(0, 0, PIW)'; y = linspace(0, 100, PIW)';       %    Left wall
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        x = linspace(50, 50, PIW)'; y = linspace(0, 100, PIW)';           %    Right wall
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        x = linspace(25-10, 25+10, PIW)'; y = linspace(5+(80-5)/2, 5+75/2, PIW)';           %    obstc
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        MaxStep = 100;
        %   Targets
        Targets = [...
            25, 80;
            ];
        startPosition = [  ...
            25 5 pi/2;
            ];
        
    case 4      % Source 4
        %    Zigzag Arena, "Encouraging reactivity to create robust machines"
        %   Outer Walls
        %   Upper & Lower Walls
        PIW = 50;
        x = linspace(40, 40, PIW)'; y = linspace(0, 15, PIW)';
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        x = linspace(35, 40, PIW)'; y = linspace(0, 0, PIW)';
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        PIW = 200;
        x = linspace(0, 35, PIW)'; y = linspace(30, 0, PIW)';
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        x = linspace(20, 40, PIW)'; y = linspace(30, 15, PIW)';
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        x = linspace(20, 60, PIW)'; y = linspace(30, 60, PIW)';
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        x = linspace(0, 40, PIW)'; y = linspace(30, 60, PIW)';
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        x = linspace(40, 20, PIW)'; y = linspace(60, 80, PIW)';
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        x = linspace(60, 40, PIW)'; y = linspace(60, 80, PIW)';
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        x = linspace(20, 40, PIW)'; y = linspace(80, 100, PIW)';
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        x = linspace(40, 50, PIW)'; y = linspace(80, 90, PIW)';
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        x = linspace(40, 50, PIW)'; y = linspace(100, 90, PIW)';
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        
        %   Targets
        Targets = [...
            40, 90;

            ];
        startPosition = [  ...
            35 8 3*pi/4;
            ];
    case 5      % Source 5
        %	Winding, "Encouraging reactivity to create robust machines"
        %   Outer Walls
        width = 15;
        PIW = 4*width;
        x = linspace(3*width, 4*width, PIW)'; y = linspace(0, 0, PIW)';
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        
        PIW = 5*4*width;
        x = linspace(4*width, 4*width, PIW)'; y = linspace(0, 5*width, PIW)';
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        
        PIW = 4*4*width;
        x = linspace(3*width, 3*width, PIW)'; y = linspace(0, 4*width, PIW)';
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        
        PIW = 3*4*width;
        x = linspace(4*width, 1*width, PIW)'; y = linspace(5*width, 5*width, PIW)';
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        
        PIW = 3*4*width;
        x = linspace(3*width, 0*width, PIW)'; y = linspace(4*width, 4*width, PIW)';
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        
        PIW = 1.5*4*width;
        x = linspace(1*width, 1*width, PIW)'; y = linspace(5*width, 6.5*width, PIW)';
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        
        PIW = 2*4*width;
        x = linspace(1*width, 3*width, PIW)'; y = linspace(6.5*width, 6.5*width, PIW)';
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        
        PIW = 1*4*width;
        x = linspace(3*width, 3*width, PIW)'; y = linspace(6.5*width, 7.5*width, PIW)';
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        
        PIW = 3*4*width;
        x = linspace(3*width, 0*width, PIW)'; y = linspace(7.5*width, 7.5*width, PIW)';
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        
        PIW = 3.5*4*width;
        x = linspace(0*width, 0*width, PIW)'; y = linspace(7.5*width, 4*width, PIW)';
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        %   Targets
        Targets = [...
            2.5*width,7*width;
            ];
        
        startPosition = [  ...
            3.5*width 0.5*width pi/2;
            ];
    case 6      % Target 1 
        %    Deceptive Arena, "Encouraging reactivity to create robust machines"
        %   Outer Walls
        %   Upper & Lower Walls
        PIW = 200;
        x = linspace(0, 50, PIW)'; y = linspace(0, 0, PIW)';                %    Lower wall
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        x = linspace(2, 60.5, PIW)'; y = linspace(100, 110, PIW)';       %    Upper wall
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        %   Right & Left Walls
        PIW = 200;
        x = linspace(0, 2, PIW)'; y = linspace(0, 100, PIW)';       %    Left wall
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        x = linspace(50, 60, PIW)'; y = linspace(0, 110, PIW)';           %    Right wall
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        %   Inner Walls
        PIW = 100;
        x = linspace(25, 54, PIW)'; y = linspace(40, 45, PIW)';         %  Lower blocking wall
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        x = linspace(1.6, 30, PIW)'; y = linspace(80, 65, PIW)';       %    Middle blocking wall
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        x = linspace(38, 56.8, PIW)'; y = linspace(87, 75, PIW)';              %    Upper blocking wall
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        
        %   Targets
        Targets = [...
            
            45, 95;
            
            ];
        startPosition = [ 10 10 pi/2];
    case 7      % Target 2
        %   Outer Walls
        %   Upper & Lower Walls
        PIW = 200;
        x = linspace(0, 105, PIW)'; y = linspace(0, 0, PIW)';
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        x = linspace(0, 105, PIW)'; y = linspace(60, 60, PIW)';
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        %   Right & Left Walls
        PIW = 150;
        x = linspace(105, 105, PIW)'; y = linspace(0, 60, PIW)';
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        x = linspace(0, 0, PIW)'; y = linspace(60, 0, PIW)';
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        %   Inner Walls
        PIW = 70;
        x = linspace(0, 35, PIW)'; y = linspace(50, 50, PIW)';
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        x = linspace(25, 25, PIW)'; y = linspace(0, 30, PIW)';
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        %   Obstacles
        R = 10; Cx = 58; Cy = 24;
        x = Cx+R*cos(0:(2*pi/PIW):2*pi)'; y = Cy+R*sin(0:(2*pi/PIW):2*pi)';
        Walls( length(Walls) : length(Walls)+PIW, 1:2) = [ x, y ];
        
        x = linspace(70, 70, PIW)'; y = linspace(30, 50, PIW)';
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        x = linspace(95, 95, PIW)'; y = linspace(30, 50, PIW)';
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        x = linspace(70, 95, PIW)'; y = linspace(30, 30, PIW)';
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        x = linspace(70, 95, PIW)'; y = linspace(50, 50, PIW)';
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        
        Targets = [...
            90, 15;
            ];
        startPosition = [ 5 55 0];
       
    case 8      % Tmaze
        %   Outer Walls
        %   Upper & Lower Walls
        PIW = 200;
        x = linspace(0, 50, PIW)'; y = linspace(0, 0, PIW)';                %    Lower wall
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        x = linspace(0, 50, PIW)'; y = linspace(100, 100, PIW)';       %    Upper wall
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        %   Right & Left Walls
        PIW = 200;
        x = linspace(0, 0, PIW)'; y = linspace(0, 100, PIW)';       %    Left wall
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        x = linspace(50, 50, PIW)'; y = linspace(0, 100, PIW)';           %    Right wall
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        % Right & Left T-Walls
        PIW = 200;
        x = linspace(18, 18, PIW)'; y = linspace(0, 72, PIW)';       %    Left wall
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        x = linspace(32, 32, PIW)'; y = linspace(0, 72, PIW)';           %    Right wall
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        
        % Lower & Upper T-Walls
        x = linspace(0, 18, PIW)'; y = linspace(72, 72, PIW)';       %    Left wall-lower
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        x = linspace(32, 50, PIW)'; y = linspace(72, 72, PIW)';           %    Right wall -lower
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        x = linspace(0, 50, PIW)'; y = linspace(86, 86, PIW)';           %    Upper wall
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        MaxStep = 100;
        %   Targets
        Targets = [...
            10, 79;
            ];
        startPosition = [  ...
            25 5 pi/2;
            ];
        
    case 9      % offset Tmaze
        %   Outer Walls
        %   Upper & Lower Walls
        PIW = 200;
        x = linspace(0, 50, PIW)'; y = linspace(0, 0, PIW)';                %    Lower wall
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        x = linspace(0, 50, PIW)'; y = linspace(100, 100, PIW)';       %    Upper wall
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        %   Right & Left Walls
        PIW = 200;
        x = linspace(0, 0, PIW)'; y = linspace(0, 100, PIW)';       %    Left wall
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        x = linspace(50, 50, PIW)'; y = linspace(0, 100, PIW)';           %    Right wall
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        % Right & Left T-Walls
        PIW = 200;
        x = linspace(18, 18, PIW)'; y = linspace(20, 80, PIW)';       %    Left wall
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        x = linspace(32, 32, PIW)'; y = linspace(20, 80, PIW)';           %    Right wall
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        
        % Lower  T-Walls
        x = linspace(0, 18, PIW)'; y = linspace(80, 80, PIW)';       %    Left wall-lower
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        x = linspace(32, 50, PIW)'; y = linspace(80, 80, PIW)';           %    Right wall -lower
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        % Lower  T-Walls
        x = linspace(0, 18, PIW)'; y = linspace(20, 20, PIW)';       %    Left wall-lower
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        x = linspace(32, 50, PIW)'; y = linspace(20, 20, PIW)';           %    Right wall -lower
        Walls( length(Walls) : length(Walls)+PIW-1, 1:2) = [ x, y ];
        
        %   Targets
        Targets = [...
            10, 90;
            ];
        startPosition = [  ...
            5 5 pi/2;
            ];
      
    
   
end
% close all
% figure()
% hold on;
% grid on;
% xlabel('X  [cm]'); ylabel('Y  [cm]');
% plot( Walls(:,1), Walls(:,2),  '.', 'Markersize', 6)
% plot( Targets(:,1), Targets(:,2), 'gX', 'Markersize', 12)
% plot( startPosition(1), startPosition(2), 'ro', 'Markersize', 12)
% axis equal;
% hold off
Arena.Lmax = sqrt((max(Walls(:,1))-min(Walls(:,1)))^2+(max(Walls(:,2))-min(Walls(:,2)))^2);
Arena.Walls = Walls;
Arena.Targets = Targets;
Arena.StartingPoint = startPosition;
Arena.MaxStep = MaxStep;
end

function [x,y] = PlotOvalObject(cx, cy, dx, dy,PIW)
% (cx,cy) - coordinates of center of circle
% (dx,dy) - values of diameter of oval object
% PIW - Number of points in wall
x = cx + dx/2 * cos(0:(2*pi/PIW):2*pi)';
y = cy + dy/2 * sin(0:(2*pi/PIW):2*pi)';
end

