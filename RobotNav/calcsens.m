function [tar_sens,obs_sens,target_hit,wall_hit]=calcsens(x,y,phi,Arena,Robot,Targets)
wall = Arena.Walls;
targets = Targets;
tar_sens = ones(1,length(Robot.SenLocation)); 
obs_sens = ones(1,length(Robot.SenLocation));
wall_hit = 0;
target_hit = 0;
dist_target = sqrt((targets(:,1)-x).^2+(targets(:,2)-y).^2);
dist_obs = sqrt((wall(:,1)-x).^2+(wall(:,2)-y).^2);
if min(dist_obs) > Robot.Diameter/2
    if min(dist_target) < Robot.Diameter/2
        target_hit = 1;
    end
    sen_real_angel = [];
    sen_real_angel1 = Robot.SenLocation + phi;
    for xxx = 1 :length(Robot.SenLocation)
        if sen_real_angel1(xxx) > 2*pi
            sen_real_angel(xxx) = sen_real_angel1(xxx)-2*pi;
        elseif sen_real_angel1(xxx) < 0
            sen_real_angel(xxx) = sen_real_angel1(xxx)+2*pi;
        else
            sen_real_angel(xxx) = sen_real_angel1(xxx);
        end
    end
    %obs sens       
    for sen = 1:length(Robot.SenLocation)
        sen_loc_x = x+Robot.Diameter/2*cos(sen_real_angel(sen));
        sen_loc_y = y+Robot.Diameter/2*sin(sen_real_angel(sen));
        raduos_from_wall = [wall(:,1) -  sen_loc_x , wall(:,2) -  sen_loc_y];
        dest_from_wall = sqrt(raduos_from_wall(:,1).^2+raduos_from_wall(:,2).^2);
        active_wall = raduos_from_wall(dest_from_wall <= Robot.ObstacleSen.Rang,:);
        active_wall_angle = atan2(active_wall(:,2),active_wall(:,1));
        active_wall_angle(active_wall_angle<0) = 2*pi + active_wall_angle(active_wall_angle<0);
        active_wall_after_angle = active_wall(((sen_real_angel(sen)-0.5*Robot.ObstacleSen.Span)<active_wall_angle) & (active_wall_angle<(sen_real_angel(sen)+0.5*Robot.ObstacleSen.Span)),:);
        activ_dest = sqrt(active_wall_after_angle(:,1).^2+active_wall_after_angle(:,2).^2);
        if size(activ_dest,1) > 0
            NN = sort(activ_dest);
            obs_sens(sen) = NN(1)/Robot.ObstacleSen.Rang;
        else
            obs_sens(sen) = 1;
        end
    end

    %tar sens
    for sen = 1:length(Robot.SenLocation)
        sen_loc_x = x+Robot.Diameter/2*cos(sen_real_angel(sen));
        sen_loc_y = y+Robot.Diameter/2*sin(sen_real_angel(sen));
        raduos_from_targets = [targets(:,1) -  sen_loc_x , targets(:,2) -  sen_loc_y];
        dest_from_targets = sqrt(raduos_from_targets(:,1).^2+raduos_from_targets(:,2).^2);
        active_targets = raduos_from_targets(dest_from_targets <= Robot.TargetSen.Rang,:);
        active_targets_angle = atan2(active_targets(:,2),active_targets(:,1));
        active_targets_angle(active_targets_angle<0) = 2*pi + active_targets_angle(active_targets_angle<0);
        active_targets_after_angle = active_targets(((sen_real_angel(sen)-0.5*Robot.TargetSen.Span)<active_targets_angle) & (active_targets_angle<(sen_real_angel(sen)+0.5*Robot.TargetSen.Span)),:);
        activ_dest = sqrt(active_targets_after_angle(:,1).^2+active_targets_after_angle(:,2).^2);
        if size(activ_dest,1) > 0
            NN = sort(activ_dest);
            tar_sens(sen) = NN(1)/Robot.TargetSen.Rang;
        else
            tar_sens(sen) = 1;
        end
    end
    
else
    wall_hit=1;
end

end