function all_planes = get_all_planes(points, parameters)
    all_planes = [];
    %planes = {};
    %plane_inliers = {};

    %Inlier criterion, pi/2 to remove angle contraint.
    t = [0.1;pi/2];
    t = parameters;

    number_planes = 1;
    % Run RANSAC to find inliers
    [p, inliers] = ransac(points', @plane_3d, @plane_dist_3d, @isdegenerate, 3, t);
    points_in_plane = points(inliers, :);
    %plane_inliers{1} = points_in_plane;
    %planes{1} = p;
    curr_plane.points = points_in_plane;
    curr_plane.plane = p/p(4);
    all_planes = [all_planes; curr_plane];

    hold on;
    plot3(points_in_plane(:, 1), points_in_plane(:, 2), points_in_plane(:, 3), 'r.')

    %fprintf('Plane detection done..\n');
    fprintf('Number of inliers %d \n', size(inliers, 2));
    
    while size(inliers, 2) >= 5000
        %Running once more to get a second plane
        inlier_index = 1;
        global_index = 1;
        outlier_index = 1;
        outliers = ones(1, size(points, 1) - size(inliers, 2));

        while global_index ~= size(points, 1) 
            if inlier_index <= size(inliers, 2) 
                if inliers(inlier_index) == global_index
                    inlier_index = inlier_index + 1;
                    global_index = global_index + 1;
                else
                    outliers(outlier_index) = global_index;
                    outlier_index = outlier_index + 1;
                    global_index = global_index + 1;
                end
            else 
                outliers(outlier_index) = global_index;
                outlier_index = outlier_index + 1;
                global_index = global_index + 1;
            end
        end

        points = points(outliers, :);
        % Run RANSAC to find inliers
        [p, inliers] = ransac(points', @plane_3d, @plane_dist_3d, @isdegenerate, 3, t);
        points_in_plane = points(inliers, :);
        curr_plane.points = points_in_plane;
        curr_plane.plane = p/p(4);
        all_planes = [all_planes; curr_plane];
        plot3(points_in_plane(:, 1), points_in_plane(:, 2), points_in_plane(:, 3), 'g.')
        fprintf('Number of inliers %d \n', size(inliers, 2));
        number_planes = number_planes + 1;
        if number_planes > 10
            break;
        end
    end
end
