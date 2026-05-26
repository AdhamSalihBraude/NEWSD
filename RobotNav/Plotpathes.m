function Plotpathes(population, Robot, Arena,pltrobot)
VideoGen = 1;
FrameRate = 7;
number_individuals = length(population);
F = [];
for i = 1: length( population)
    F(i,:) = population(i).Trainfitness;
end
[MaxF,Idx] = max(F,[],1);
MinF = min(F,[],1);
F = (F- MinF)./(MaxF-MinF);
BestIND =  population(Idx);

ID = ones(size(MaxF));
I1 = 0;
I2 = [];
D = [];
for i = 1: length( population)
    if  any(F(i,:) < 0.4)


    else
        D = [D,norm(ID - F(i,:))];
        I2 = [I2,i];
    end
end
[Dmin,I] = sort(D);
NonSp = population(I2(randi(length(I2))));
NonSp.Trainfitness;
Ak = [Robot.WheelDiameter/4, Robot.WheelDiameter/4; 0.5*Robot.WheelDiameter/Robot.Diameter, - 0.5*Robot.WheelDiameter/Robot.Diameter];


wallhit = zeros(size(Arena));
for IndexArena = 1 : length(Arena)
    Ind = BestIND(IndexArena);
    RobotPosition = Arena(IndexArena).StartingPoint';
    Targets = Arena(IndexArena).Targets;
    NumTargets = size(Targets,1);
    Walls = Arena(IndexArena).Walls;
    Lmax = Arena(IndexArena).Lmax;
    Lastdist = Lmax;
    path = [];
    f1 = 0;

    R = 0;
    dLast = 0;
    avgI = [];
    H = Arena(IndexArena).MaxStep;%/size(Targets,1);
    %         VcmMax = Robot.WheelDiameter/4;

    gamma = 1;
    I = 100;

    disCount = 1;
    posDot = [0 0]';
    notMovflag = 0;

    for step  = 1 : Arena(IndexArena).MaxStep
        Movflag = 0;
        disCount = disCount*gamma;
        path = [path,RobotPosition];
        [tar_sens,obs_sens,~,~] = calcsens(RobotPosition(1),RobotPosition(2),RobotPosition(3),Arena(IndexArena),Robot,Targets);
        Input = [1-tar_sens,1-obs_sens]';%,wMotors];
        wMotors = NetCalcRob(Ind,Input,2);
        RobotPositionLast = RobotPosition;
        posDotLast = posDot;
        %             posDot = wMotors;

        posDot = Ak*wMotors';
        dt = 0.05;
        for t = 0:dt:Robot.dt
            if min(sqrt((RobotPosition(1)-Walls(:,1)).^2+(RobotPosition(2)-Walls(:,2)).^2)) > Robot.Diameter/2
                RobotPosition(1) = RobotPosition(1)+posDot(1)*cos(RobotPosition(3))*dt;
                RobotPosition(2) = RobotPosition(2)+posDot(1)*sin(RobotPosition(3))*dt;
                RobotPosition(3) = mod(RobotPosition(3) + posDot(2)* dt,2*pi);
                if min(sqrt((RobotPosition(1)-Targets(:,1)).^2+(RobotPosition(2)-Targets(:,2)).^2)) < Robot.Diameter/2
                    break
                end
            end
        end
        [dtar,mintarget] = min(sqrt((RobotPosition(1)-Targets(:,1)).^2+(RobotPosition(2)-Targets(:,2)).^2));
        if dtar < Robot.Diameter/2
            R = R + H;
            f1 = f1 + disCount*H;
            dLast = 0;
            Lastdist = Lmax;
            Targets(mintarget,:) = [];
            if isempty(Targets)
                f1 = f1 + (Arena(IndexArena).MaxStep-step);
                %                     if IndexArena == 1 || IndexArena == 3 ||IndexArena == 1
                %                                             fprintf('\n all targets in Arena %d  ', IndexArena);
                %                     end

                break;
            end
        else
            R = R - min(tar_sens);
            %f1 = f1 + (min([obs_sens])/(min(tar_sens)+1));
            dLast = 1;
            Lastdist = dtar;
        end
        if norm(RobotPosition(1:2) - RobotPositionLast(1:2)) < 5e-2 && notMovflag < 10
            notMovflag = notMovflag + 1;
        else
            notMovflag = 0;
        end
        if (posDot(1)*posDotLast(1)<0) && (posDot(2)*posDotLast(2)<0) && (RobotPosition(3)-RobotPositionLast(3)<1e-1) && Movflag < 3
            Movflag = Movflag + 1;
        else
            Movflag = 0;
        end

        %             Wallhit = 0;
        dobs = min(sqrt((RobotPosition(1)-Walls(:,1)).^2+(RobotPosition(2)-Walls(:,2)).^2));
        I = min([I,obs_sens]);
        %             f2 = f2 + (abs(wMotors(1))*I*(1-sqrt(abs(wMotors(1)))));
        avgI = [avgI;min(obs_sens)];
        R = R - sqrt(abs(wMotors(1) - wMotors(2)));
        if dobs < Robot.Diameter/2 || Movflag > 2 || notMovflag > 9
            %                 Wallhit = 1;
            f1 = 0;

            dLast = 0;
            wallhit(IndexArena) = 1;
            break
        else
            wallhit(IndexArena) = 0;%                 Reward = Reward + dobs;
        end
        if pltrobot > 0
            figure(IndexArena)
        end


        if pltrobot == 1
            [~,~,~,~] = plotRobot(RobotPosition',Arena(IndexArena),Robot);

            title(['Nav Arena: ', num2str(IndexArena),' step: ',num2str(step),' F: ',num2str((f1/step))]);

            hold on
            plot(Targets(:,1),Targets(:,2),'*g');
            plot(path(1,:),path(2,:),'-r','LineWidth',1.25);
            hold off
            drawnow;
            ForAVI(IndexArena).F(step) = getframe(gcf) ;
        end
    end
    f1 = f1 + dLast*(Lmax-Lastdist)/Lmax;

    Trainfitness(IndexArena) = (f1*mean(avgI))/NumTargets/Arena(IndexArena).MaxStep;
    if pltrobot == 2
        plot(path(1,:),path(2,:),'-r',Arena(IndexArena).Walls(:,1),Arena(IndexArena).Walls(:,2),'.k','LineWidth',1.25);
        title(['Nav Arena: ', num2str(IndexArena)]);
        grid on
        hold on
        %             plot(Targets(:,1),Targets(:,2),'*g');
        grid on
        %             hold off
        axis square
        drawnow;
    end
    %     if pltrobot == 1
    %         [~,~,~,~] = plotRobot(RobotPosition',Arena(IndexArena),Robot);
    %
    %         title(['Nav Arena: ', num2str(IndexArena),' step: ',num2str(step),' F: ',num2str(Trainfitness(IndexArena))]);
    %
    %         hold on
    %         plot(Targets(:,1),Targets(:,2),'*g');
    %         plot(path(1,:),path(2,:),'-r','LineWidth',1.25);
    %         hold off
    %         drawnow;
    %         ForAVI(IndexArena).F(step) = getframe(gcf) ;
    %     end
    if pltrobot == 1
        [~,~,~,~] = plotRobot(RobotPosition',Arena(IndexArena),Robot);
        title(['Sp Arena: ', num2str(IndexArena),' step: ',num2str(step),' F: ',num2str(Trainfitness(IndexArena))]);

        hold on
        plot(Targets(:,1),Targets(:,2),'*g');
        plot(path(1,:),path(2,:),'-r','LineWidth',1.25);
        hold off

        drawnow;

        ForAVI(IndexArena).F(step) = getframe(gcf) ;
    end

end
(Trainfitness- MinF)./(MaxF-MinF)
if VideoGen

    for IndexArena = 1 : length(Arena)
        writerObj = VideoWriter(['SpInArena',num2str(IndexArena)],'MPEG-4');
        writerObj.FrameRate = FrameRate;
        % set the seconds per image
        % open the video writer
        open(writerObj);
        % write the frames to the video
        for i = 1:length(ForAVI(IndexArena).F)
            % convert the image to a frame
            frame = ForAVI(IndexArena).F(i) ;
            writeVideo(writerObj, frame);
        end
        for i = 1 : 10
            writeVideo(writerObj, frame);
        end
        % close the writer object
        close(writerObj);
    end
    close all
end
ForAVI = [];
for IndexArena = 1 : length(Arena)
    Ind = NonSp;
    RobotPosition = Arena(IndexArena).StartingPoint';
    Targets = Arena(IndexArena).Targets;
    NumTargets = size(Targets,1);
    Walls = Arena(IndexArena).Walls;
    Lmax = Arena(IndexArena).Lmax;
    Lastdist = Lmax;
    path = [];
    f1 = 0;

    R = 0;
    dLast = 0;
    avgI = [];
    H = Arena(IndexArena).MaxStep;%/size(Targets,1);
    %         VcmMax = Robot.WheelDiameter/4;

    gamma = 1;
    I = 100;

    disCount = 1;
    posDot = [0 0]';
    notMovflag = 0;

    for step  = 1 : Arena(IndexArena).MaxStep
        Movflag = 0;
        disCount = disCount*gamma;
        path = [path,RobotPosition];
        [tar_sens,obs_sens,~,~] = calcsens(RobotPosition(1),RobotPosition(2),RobotPosition(3),Arena(IndexArena),Robot,Targets);
        Input = [1-tar_sens,1-obs_sens]';%,wMotors];
        wMotors = NetCalcRob(Ind,Input,2);
        RobotPositionLast = RobotPosition;
        posDotLast = posDot;
        %             posDot = wMotors;

        posDot = Ak*wMotors';
        dt = 0.05;
        for t = 0:dt:Robot.dt
            if min(sqrt((RobotPosition(1)-Walls(:,1)).^2+(RobotPosition(2)-Walls(:,2)).^2)) > Robot.Diameter/2
                RobotPosition(1) = RobotPosition(1)+posDot(1)*cos(RobotPosition(3))*dt;
                RobotPosition(2) = RobotPosition(2)+posDot(1)*sin(RobotPosition(3))*dt;
                RobotPosition(3) = mod(RobotPosition(3) + posDot(2)* dt,2*pi);
                if min(sqrt((RobotPosition(1)-Targets(:,1)).^2+(RobotPosition(2)-Targets(:,2)).^2)) < Robot.Diameter/2
                    break
                end
            end
        end
        [dtar,mintarget] = min(sqrt((RobotPosition(1)-Targets(:,1)).^2+(RobotPosition(2)-Targets(:,2)).^2));
        if dtar < Robot.Diameter/2
            R = R + H;
            f1 = f1 + disCount*H;
            dLast = 0;
            Lastdist = Lmax;
            Targets(mintarget,:) = [];
            if isempty(Targets)
                f1 = f1 + (Arena(IndexArena).MaxStep-step);
                %                     if IndexArena == 1 || IndexArena == 3 ||IndexArena == 1
                %                                             fprintf('\n all targets in Arena %d  ', IndexArena);
                %                     end

                break;
            end
        else
            R = R - min(tar_sens);
            %f1 = f1 + (min([obs_sens])/(min(tar_sens)+1));
            dLast = 1;
            Lastdist = dtar;
        end
        if norm(RobotPosition(1:2) - RobotPositionLast(1:2)) < 5e-2 && notMovflag < 10
            notMovflag = notMovflag + 1;
        else
            notMovflag = 0;
        end
        if (posDot(1)*posDotLast(1)<0) && (posDot(2)*posDotLast(2)<0) && (RobotPosition(3)-RobotPositionLast(3)<1e-1) && Movflag < 3
            Movflag = Movflag + 1;
        else
            Movflag = 0;
        end

        %             Wallhit = 0;
        dobs = min(sqrt((RobotPosition(1)-Walls(:,1)).^2+(RobotPosition(2)-Walls(:,2)).^2));
        I = min([I,obs_sens]);
        %             f2 = f2 + (abs(wMotors(1))*I*(1-sqrt(abs(wMotors(1)))));
        avgI = [avgI;min(obs_sens)];
        R = R - sqrt(abs(wMotors(1) - wMotors(2)));
        if dobs < Robot.Diameter/2 || Movflag > 2 || notMovflag > 9
            %                 Wallhit = 1;
            f1 = 0;

            dLast = 0;
            wallhit(IndexArena) = 1;
            break
        else
            wallhit(IndexArena) = 0;%                 Reward = Reward + dobs;
        end
        if pltrobot > 0
            figure(IndexArena)
        end


        if pltrobot == 1
            [~,~,~,~] = plotRobot(RobotPosition',Arena(IndexArena),Robot);

            title(['Nav Arena: ', num2str(IndexArena),' step: ',num2str(step),' F: ',num2str((f1/step))]);

            hold on
            plot(Targets(:,1),Targets(:,2),'*g');
            plot(path(1,:),path(2,:),'-r','LineWidth',1.25);
            hold off
            drawnow;
            ForAVI(IndexArena).F(step) = getframe(gcf) ;
        end
    end
    f1 = f1 + dLast*(Lmax-Lastdist)/Lmax;

    Trainfitness(IndexArena) = (f1*mean(avgI))/NumTargets/Arena(IndexArena).MaxStep;

    if pltrobot == 2
        plot(path(1,:),path(2,:),'--k',Arena(IndexArena).Walls(:,1),Arena(IndexArena).Walls(:,2),'.k','LineWidth',1.25);
        title(['Nav Arena: ', num2str(IndexArena)]);
        grid on
        hold on
        plot(Arena(IndexArena).Targets(:,1),Arena(IndexArena).Targets(:,2),'*b','MarkerSize',10);
        grid on
        hold off
        axis equal

        drawnow;
    end
    if pltrobot == 1
        [~,~,~,~] = plotRobot(RobotPosition',Arena(IndexArena),Robot);

        title(['NonSp Arena: ', num2str(IndexArena),' step: ',num2str(step),' F: ',num2str(Trainfitness(IndexArena))]);
        hold on
        plot(Targets(:,1),Targets(:,2),'*g');
        plot(path(1,:),path(2,:),'-r','LineWidth',1.25);
        hold off
        drawnow;
        ForAVI(IndexArena).F(step) = getframe(gcf) ;
    end

end

if VideoGen

    for IndexArena = 1 : length(Arena)
        writerObj = VideoWriter(['NonSPinArena',num2str(IndexArena)],'MPEG-4');
        writerObj.FrameRate = FrameRate;
        % set the seconds per image
        % open the video writer
        open(writerObj);
        % write the frames to the video
        for i=1:length(ForAVI(IndexArena).F)
            % convert the image to a frame
            frame = ForAVI(IndexArena).F(i) ;
            writeVideo(writerObj, frame);
        end
        for i = 1 : 10
            writeVideo(writerObj, frame);
        end
        % close the writer object
        close(writerObj);
    end
    close all
end
(Trainfitness- MinF)./(MaxF-MinF)
end
