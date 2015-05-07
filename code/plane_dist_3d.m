%----------------------------------------------------------------------
% Function to evaluate the symmetric transfer error of a homography with
% respect to a set of matched points as needed by RANSAC.

function [inliers, p] = plane_dist_3d(p, x, t);
    
    %t contains both distance and angle(radians) inlier thresholds
    t_dist = t(1);
    t_angle = t(2);
    
    %Calculating distance from plane
    d_dist = (p' * [x(1:3, :);ones(1, size(x(1:3, :), 2))])/sqrt(p(1:3)' * p(1:3));
    
    %Calculating angle with normal
    normal = p(1:3);
    d_normal = abs(normal' * x(4:6, :))/sqrt(normal' * normal);

    %Applying the inlier criterion
    inliers = find((abs(d_dist) < t_dist) & (d_normal >= cos(t_angle)));    
    %inliers = inliers'
end
    
 
